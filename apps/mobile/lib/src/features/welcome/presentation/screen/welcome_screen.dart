import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../core/theme/tokens/foundation/insets.dart';
import '../action/welcome_action.dart';
import '../widgets/welcome_action_buttons.dart';
import '../widgets/welcome_header.dart';
import '../widgets/welcome_features_list.dart';
import '../widgets/welcome_footer.dart';
import '../widgets/welcome_top_bar.dart';
import '../widgets/welcome_backdrop.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({required this.onAction, super.key});

  final ValueChanged<WelcomeAction> onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          // Background Backdrop Gradients
          const WelcomeBackdrop(),
          // Content Layout
          Column(
            children: [
              // Top Section (Image banner with overlayed Top Action Bar)
              Stack(
                children: [
                  const WelcomeHeader(),
                  Positioned(
                    top: Dimens.spaceNone,
                    left: Dimens.spaceNone,
                    right: Dimens.spaceNone,
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: Insets.topBar,
                        child: WelcomeTopBar(
                          localeCode: 'en',
                          skipText: 'Skip',
                          onSkip: () =>
                              onAction(const WelcomeGetStartedAction()),
                          onLanguageTap: () {
                            // Future enhancement: Open language bottom sheet
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Scrollable is disabled, we distribute the rest of screen using Spacers
              Expanded(
                child: SafeArea(
                  top:
                      false, // Safely pads the system navigation bar at the bottom
                  child: Column(
                    children: [
                      const Spacer(),
                      const WelcomeFeaturesList(),
                      const Spacer(),
                      // Bottom Action Buttons Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.paddingScreen,
                        ),
                        child: WelcomeActionButtons(onAction: onAction),
                      ),
                      const Spacer(),
                      // Legal Footer
                      const WelcomeFooter(),
                      const SizedBox(height: Dimens.spaceXS),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
