import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sinag/app/app.dart';
import 'package:project_sinag/app/buildings.dart';
import 'package:project_sinag/app/roles.dart';
import 'package:project_sinag/app/route_table.dart';

/// Keeps screens light: counts the words a person sees on each screen
/// before tapping anything (page body only — not the top bar or tabs, and
/// not text folded under "See details" or in the ⓘ).
void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  setUp(() {
    SinagSession.role = SinagRole.eecOfficer;
    selectedBuilding.value = sinagBuildings.first;
  });

  const maxWords = 110;
  final counts = <String, int>{};

  for (final route in sinagRoutes.keys) {
    testWidgets('$route shows at most $maxWords words at first', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(402, 874);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(SinagApp(initialRoute: route));
      await tester.pumpAndSettle();

      // Only the scrolling page body of the screen on top.
      final body = find.byType(SingleChildScrollView).last;
      final words = find
          .descendant(of: body, matching: find.byType(Text))
          .evaluate()
          .map((e) => (e.widget as Text).data ?? '')
          .join(' ')
          .split(RegExp(r'\s+'))
          .where((w) => RegExp(r'[A-Za-z0-9₱]').hasMatch(w))
          .length;
      counts[route] = words;
      expect(words, lessThanOrEqualTo(maxWords));
    });
  }

  tearDownAll(() {
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    // ignore: avoid_print
    print(
      sorted
          .map((e) => '${e.value.toString().padLeft(4)}  ${e.key}')
          .join('\n'),
    );
  });
}
