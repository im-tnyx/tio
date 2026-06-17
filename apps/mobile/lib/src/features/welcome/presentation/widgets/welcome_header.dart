import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final imageHeight = (screenHeight * 0.35).clamp(260.0, 340.0);

    return Stack(
      children: [
        // Landing Screen Image
        Image.asset(
          'assets/images/landing_screen.png',
          width: double.infinity,
          height: imageHeight, // Height to cover the top portion nicely
          fit: BoxFit.cover,
        ),
        // Gradient overlay to fade the image bottom into the background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, theme.colorScheme.surface],
                stops: const [0.65, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
