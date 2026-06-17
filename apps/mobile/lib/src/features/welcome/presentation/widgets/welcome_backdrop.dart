import 'package:flutter/material.dart';

class WelcomeBackdrop extends StatelessWidget {
  const WelcomeBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    // [TAG: CANVAS BACKGROUND MAPPING]
    // Uses Scaffold background color which corresponds to CanvasBackground (White in light, 121212 in dark)
    final themeColor = Theme.of(context).scaffoldBackgroundColor;

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeColor.withValues(alpha: 0.18),
                  themeColor.withValues(alpha: 0.08),
                  themeColor.withValues(alpha: 0.0),
                ],
                stops: const [
                  0.0,
                  0.35,
                  1.0,
                ],
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.85,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    themeColor.withValues(alpha: 0.0),
                    themeColor.withValues(alpha: 0.30),
                    themeColor.withValues(alpha: 1.0),
                    themeColor.withValues(alpha: 1.0),
                    themeColor.withValues(alpha: 1.0),
                    themeColor.withValues(alpha: 1.0),
                  ],
                  stops: const [
                    0.0,
                    0.20,
                    0.30,
                    0.65,
                    0.75,
                    1.0,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
