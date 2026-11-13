import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sinag/main.dart';

void main() {
  // Don't fetch Inter over the network during tests.
  GoogleFonts.config.allowRuntimeFetching = false;

  // Every route builds and lays out on a 402px-wide phone without overflow.
  for (final route in sinagRoutes.keys) {
    testWidgets('renders $route', (tester) async {
      tester.view.physicalSize = const Size(402, 874);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(SinagApp(initialRoute: route));
      await tester.pump();
      expect(tester.takeException(), isNull);
      expect(find.byType(Scaffold), findsWidgets);
    });
  }

  testWidgets('sign in → verify → my access', (tester) async {
    await tester.pumpWidget(const SinagApp());
    await tester.tap(find.text('Sign in securely'));
    await tester.pumpAndSettle();
    expect(find.text('Verify'), findsOneWidget);
    await tester.tap(find.text('Verify & continue'));
    await tester.pumpAndSettle();
    expect(find.text('My access'), findsOneWidget);
  });
}
