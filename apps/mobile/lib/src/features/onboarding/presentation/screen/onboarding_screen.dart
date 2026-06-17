import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../provider/onboarding_provider.dart';
import '../widgets/onboarding_top_bar.dart';
import '../widgets/onboarding_bottom_bar.dart';
import '../widgets/section_renderer.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isTypingFinished = false;

  bool _hasInitialValue(OnboardingProvider provider, int step) {
    switch (step) {
      case 1:
        return provider.state.name.isNotEmpty;
      case 2:
        return provider.state.gender.isNotEmpty;
      case 3:
        return provider.state.dob > 0;
      case 4:
        return provider.state.height > 0.0;
      case 5:
        return provider.state.currentWeight > 0.0;
      case 6:
        return provider.state.goals.isNotEmpty;
      case 7:
        return provider.state.targetWeight > 0.0;
      case 8:
        return provider.state.activityLevel.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<OnboardingProvider>(context, listen: false);
      setState(() {
        _isTypingFinished = _hasInitialValue(provider, provider.flowState.step);
      });
    });
  }

  Future<void> _handleNext(OnboardingProvider provider) async {
    if (!provider.isStepValid()) return;

    final result = await provider.nextStep();
    if (result == true) {
      if (mounted) {
        context.go('/main');
      }
    } else if (result == false) {
      if (mounted) {
        context.push('/login');
      }
    } else {
      setState(() {
        _isTypingFinished = _hasInitialValue(provider, provider.flowState.step);
      });
    }
  }

  void _handleBack(OnboardingProvider provider) {
    final isExit = provider.previousStep();
    if (isExit) {
      context.go('/welcome');
    } else {
      setState(() {
        _isTypingFinished = _hasInitialValue(provider, provider.flowState.step);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final provider = Provider.of<OnboardingProvider>(context);
    final currentStep = provider.flowState.step;
    final totalSteps = provider.totalSteps;
    final progress = totalSteps > 0 ? (currentStep / totalSteps) : 0.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: theme.colorScheme.surface,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              OnboardingTopBar(
                showBackButton: true,
                showProgressBar: true,
                progress: progress,
                onBackClick: () => _handleBack(provider),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: SectionRenderer(
                    section: provider.flowState.safeSection,
                    step: currentStep,
                    onTypingDone: () {
                      setState(() {
                        _isTypingFinished = true;
                      });
                    },
                  ),
                ),
              ),
              if (provider.isSavingDraft)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.spaceL),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                OnboardingBottomBar(
                  visible: _isTypingFinished || _hasInitialValue(provider, currentStep),
                  enabled: provider.isStepValid(),
                  text: currentStep == totalSteps ? 'Finish & Sync' : 'Continue',
                  onClick: () => _handleNext(provider),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
