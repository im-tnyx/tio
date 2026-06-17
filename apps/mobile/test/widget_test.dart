import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tnyx/src/app/app.dart';

void main() {
  testWidgets('App starts with Splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that Splash screen shows a loading indicator (based on default state)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Allow the SplashViewModel delayed transition timer to complete.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(); // Pump frame after timer fires
  });
}
