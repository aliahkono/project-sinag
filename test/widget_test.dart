import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sinag/app/app.dart';
import 'package:project_sinag/app/buildings.dart';
import 'package:project_sinag/app/roles.dart';
import 'package:project_sinag/widgets/buttons.dart';
import 'package:project_sinag/app/route_table.dart';

void main() {
  // Don't fetch Inter over the network during tests.
  GoogleFonts.config.allowRuntimeFetching = false;

  // Each test starts as the EEC Officer looking at Building A (both are
  // remembered app-wide).
  setUp(() {
    SinagSession.role = SinagRole.eecOfficer;
    selectedBuilding.value = sinagBuildings.first;
  });

  group('building picker', () {
    Future<void> phone(WidgetTester tester) async {
      tester.view.physicalSize = const Size(402, 874);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }

    // The tick shown next to the current building in the dropdown.
    Finder tickNextTo(String name) => find.descendant(
      of: find.ancestor(of: find.text(name), matching: find.byType(Row)).first,
      matching: find.byIcon(Icons.check_circle),
    );

    testWidgets('after sign-in a building must be chosen first', (
      tester,
    ) async {
      await phone(tester);
      selectedBuilding.value = null; // nothing chosen yet
      await tester.pumpWidget(const SinagApp(initialRoute: '/my-access'));
      await tester.pumpAndSettle();

      // Continue → the list of all buildings, none marked.
      await tester.tap(find.text('Continue as EEC Officer'));
      await tester.pumpAndSettle();
      expect(find.text('Buildings'), findsOneWidget);
      expect(find.textContaining('SELECTED'), findsNothing);
      expect(find.text('Select Building A'), findsOneWidget);
      expect(find.text('Select Building B'), findsOneWidget);

      // Choose Building B → its Dashboard, with the dropdown in the top bar.
      await tester.ensureVisible(find.text('Select Building B'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Select Building B'));
      await tester.pumpAndSettle();
      expect(find.text('This month vs baseline'), findsOneWidget);
      expect(find.text('Building B'), findsOneWidget);
      await tester.tap(find.text('Building B'));
      await tester.pumpAndSettle();
      expect(tickNextTo('City Hall Complex – Building B'), findsOneWidget);
    });

    testWidgets('top bar says "Select building" until one is chosen', (
      tester,
    ) async {
      await phone(tester);
      selectedBuilding.value = null;
      await tester.pumpWidget(const SinagApp(initialRoute: '/dashboard'));
      await tester.pumpAndSettle();
      expect(find.text('Select building'), findsOneWidget);
      expect(
        find.text('NO BUILDING SELECTED · DEMO DATA · 1–12 NOV 2026'),
        findsOneWidget,
      );

      // Tapping it opens the full Buildings screen, not a dropdown.
      await tester.tap(find.text('Select building'));
      await tester.pumpAndSettle();
      expect(find.text('Buildings'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });

    testWidgets('top bar shows the current building and the dropdown ticks '
        'it', (tester) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/dashboard'));
      await tester.pumpAndSettle();
      expect(find.text('Building A'), findsOneWidget);

      await tester.tap(find.text('Building A'));
      await tester.pumpAndSettle();
      expect(
        find.text('CURRENTLY VIEWING · TIER 3 · LIVE METERS'),
        findsOneWidget,
      );
      expect(tickNextTo('City Hall Complex – Building A'), findsOneWidget);
      expect(tickNextTo('City Hall Complex – Building B'), findsNothing);

      // Pick Building B: the top bar and the tick follow.
      await tester.tap(find.text('City Hall Complex – Building B'));
      await tester.pumpAndSettle();
      expect(find.text('Building B'), findsOneWidget);
      expect(selectedBuilding.value?.id, 'b');

      await tester.tap(find.text('Building B'));
      await tester.pumpAndSettle();
      expect(tickNextTo('City Hall Complex – Building B'), findsOneWidget);
      expect(tickNextTo('City Hall Complex – Building A'), findsNothing);
    });

    testWidgets('picking a building opens that building\'s main screen', (
      tester,
    ) async {
      await phone(tester);
      // EEC Officer on Appliances → picks Building B → Dashboard.
      await tester.pumpWidget(const SinagApp(initialRoute: '/appliances'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Building A'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('City Hall Complex – Building B'));
      await tester.pumpAndSettle();
      expect(find.text('This month vs baseline'), findsOneWidget);
      expect(
        find.text('BUILDING B · DEMO DATA · 1–12 NOV 2026'),
        findsOneWidget,
      );
      expect(find.byTooltip('Back'), findsNothing); // fresh start
    });

    testWidgets('a focal person lands on their own workspace', (tester) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/focal'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Building A'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Annex Building').last);
      await tester.pumpAndSettle();
      expect(find.text('Focal workspace'), findsOneWidget);
      expect(find.text('FOCAL PERSON · ANNEX BUILDING'), findsOneWidget);
      expect(find.text('Annex Building'), findsOneWidget); // top bar
    });

    testWidgets('Buildings screen marks the selected building', (tester) async {
      await phone(tester);
      selectedBuilding.value = sinagBuildings[2]; // Annex
      await tester.pumpWidget(const SinagApp(initialRoute: '/buildings'));
      await tester.pumpAndSettle();

      expect(find.text('SELECTED · TIER 1 · BILL-ONLY'), findsOneWidget);
      expect(find.text('TIER 3 · LIVE METERS'), findsOneWidget);
      expect(find.text('Open Annex'), findsOneWidget);
      expect(find.text('Switch to Building A'), findsOneWidget);

      // Switching from the Buildings screen updates the selection.
      await tester.ensureVisible(find.text('Switch to Building B'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Switch to Building B'));
      await tester.pumpAndSettle();
      expect(selectedBuilding.value?.id, 'b');
      expect(find.text('Building B'), findsOneWidget);
    });
  });

  // Every route builds and lays out without overflow, on the Figma phone
  // width (402px) and a narrower common phone (360px). Opening a route
  // directly puts Sign in behind it, so the back arrow is shown too.
  for (final width in [402.0, 360.0]) {
    for (final route in sinagRoutes.keys) {
      testWidgets('renders $route at ${width.toInt()}px', (tester) async {
        tester.view.physicalSize = Size(width, 874);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(SinagApp(initialRoute: route));
        await tester.pump();
        expect(tester.takeException(), isNull);
        expect(find.byType(Scaffold), findsWidgets);
      });
    }
  }

  group('tabs are interactive', () {
    // Phone-sized window for every test in this group.
    Future<void> phone(WidgetTester tester) async {
      tester.view.physicalSize = const Size(402, 874);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }

    double scrollOffset(WidgetTester tester) => tester
        .state<ScrollableState>(find.byType(Scrollable).first)
        .position
        .pixels;

    testWidgets('highlighted Dashboard tab opens the Dashboard from a '
        'screen under it', (tester) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/appliances'));
      await tester.pumpAndSettle();
      expect(find.text('Appliances'), findsWidgets);

      await tester.tap(find.text('Dashboard'));
      await tester.pumpAndSettle();
      expect(find.text('This month vs baseline'), findsOneWidget);
      // Tabs start fresh: no back arrow.
      expect(find.byTooltip('Back'), findsNothing);
    });

    testWidgets('tapping the tab you are on scrolls back to the top', (
      tester,
    ) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/dashboard'));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Scrollable).first, const Offset(0, -600));
      await tester.pumpAndSettle();
      expect(scrollOffset(tester), greaterThan(0));

      // The page title scrolled away, so this 'Dashboard' is the tab.
      await tester.tap(find.text('Dashboard').last);
      await tester.pumpAndSettle();
      expect(scrollOffset(tester), 0);
      expect(find.text('This month vs baseline'), findsOneWidget);
    });

    testWidgets('highlighted role tab opens its screen from a workspace', (
      tester,
    ) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/focal'));
      await tester.pumpAndSettle();
      expect(find.text('Focal workspace'), findsOneWidget);

      await tester.tap(find.text('Bills'));
      await tester.pumpAndSettle();
      expect(find.text('Scan bill'), findsOneWidget);
    });

    // True if the role-bar tab with this label is highlighted (navy).
    bool isHighlighted(String label) => find
        .byWidgetPredicate(
          (w) => w is SmallButton && w.label == label && w.primary,
        )
        .evaluate()
        .isNotEmpty;

    testWidgets('focal bar highlights the tab of the screen you are on', (
      tester,
    ) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/scan-bill'));
      await tester.pumpAndSettle();
      expect(isHighlighted('Bills'), isTrue);
      expect(isHighlighted('Review'), isFalse);

      await tester.tap(find.text('Review'));
      await tester.pumpAndSettle();
      expect(find.text('Review bill'), findsOneWidget);
      expect(isHighlighted('Review'), isTrue);
      expect(isHighlighted('Bills'), isFalse);

      // Alerts keeps the focal person's bar, with Alerts highlighted.
      await tester.tap(find.text('Alerts').last);
      await tester.pumpAndSettle();
      expect(find.text('Open (2)'), findsOneWidget);
      expect(isHighlighted('Alerts'), isTrue);
      expect(find.text('Scanner'), findsNothing);
    });

    testWidgets('tab switches slide in the agreed directions', (tester) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/scan-bill'));
      await tester.pumpAndSettle();

      // Taps a tab and returns how far (in px) something only the new screen
      // has is from its resting place, part-way through the slide.
      // Negative = still off to the left, positive = still off to the right.
      Future<double> tapAndMeasure(String tab, String marker) async {
        await tester.tap(find.text(tab).last);
        await tester.pump(); // start the transition
        await tester.pump(const Duration(milliseconds: 60));
        final midX = tester.getTopLeft(find.text(marker).last).dx;
        await tester.pumpAndSettle();
        final restX = tester.getTopLeft(find.text(marker)).dx;
        return midX - restX;
      }

      const fromLeft = -20.0; // still off to the left
      const fromRight = 50.0; // still off to the right

      // Bills → Review: screen slides right (comes in from the left).
      expect(await tapAndMeasure('Review', 'Review bill'), lessThan(fromLeft));
      // Review → Alerts: slides left (comes in from the right).
      expect(await tapAndMeasure('Alerts', 'Open (2)'), greaterThan(fromRight));
      // Alerts → Review: slides left (comes in from the right).
      expect(
        await tapAndMeasure('Review', 'Review bill'),
        greaterThan(fromRight),
      );
      // Review → Bills: slides right (comes in from the left).
      expect(await tapAndMeasure('Bills', 'Scan bill'), lessThan(fromLeft));
      // Bills → Alerts: from the left; Alerts → Bills: from the right.
      expect(await tapAndMeasure('Alerts', 'Open (2)'), lessThan(fromLeft));
      expect(await tapAndMeasure('Bills', 'Scan bill'), greaterThan(fromRight));
    });

    testWidgets('facility manager keeps their bar on Appliances', (
      tester,
    ) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/facility'));
      await tester.pumpAndSettle();
      expect(isHighlighted('Alerts'), isTrue);

      await tester.tap(find.text('Appliances').last);
      await tester.pumpAndSettle();
      expect(find.text('Today’s building energy'), findsOneWidget);
      expect(isHighlighted('Appliances'), isTrue);
      expect(find.text('Scanner'), findsNothing);
    });

    testWidgets('Open / Resolved tabs switch both ways', (tester) async {
      await phone(tester);
      await tester.pumpWidget(const SinagApp(initialRoute: '/alerts'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Resolved (8)'));
      await tester.pumpAndSettle();
      expect(find.text('Resolved alerts'), findsOneWidget);

      await tester.tap(find.text('Open (2)'));
      await tester.pumpAndSettle();
      expect(find.text('Alerts'), findsOneWidget);
      // Still on Alerts after tapping its own (highlighted) tab.
      await tester.tap(find.text('Open (2)'));
      await tester.pumpAndSettle();
      expect(find.text('Alerts'), findsOneWidget);
    });
  });

  testWidgets('See details opens and closes extra information', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const SinagApp(initialRoute: '/dashboard'));
    await tester.pumpAndSettle();

    // The breakdown is hidden until asked for.
    expect(find.text('Raw change · Computed'), findsNothing);
    await tester.ensureVisible(find.text('See breakdown'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('See breakdown'));
    await tester.pumpAndSettle();
    expect(find.text('Raw change · Computed'), findsOneWidget);

    await tester.tap(find.text('Hide details'));
    await tester.pumpAndSettle();
    expect(find.text('Raw change · Computed'), findsNothing);
  });

  testWidgets('the ⓘ next to the title explains the screen', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const SinagApp(initialRoute: '/dashboard'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('About Dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('Measured: read from a meter or a bill.'), findsOneWidget);
  });

  testWidgets('bell opens Notify, and back returns', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const SinagApp(initialRoute: '/dashboard'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Notifications'));
    await tester.pumpAndSettle();
    expect(find.text('Notify'), findsOneWidget);
    expect(find.text('SINAG · Unit left running'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('This month vs baseline'), findsOneWidget);
  });

  testWidgets('back arrow returns to the previous screen', (tester) async {
    await tester.pumpWidget(const SinagApp());
    await tester.pumpAndSettle();
    // First screen: nothing to go back to.
    expect(find.byTooltip('Back'), findsNothing);

    await tester.tap(find.text('Sign in securely'));
    await tester.pumpAndSettle();
    expect(find.text('Verify'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Verify'), findsNothing);
  });

  testWidgets('sign in → verify → my access', (tester) async {
    await tester.pumpWidget(const SinagApp());
    await tester.tap(find.text('Sign in securely'));
    await tester.pumpAndSettle();
    expect(find.text('Verify'), findsOneWidget);
    await tester.tap(find.text('Verify & continue'));
    await tester.pumpAndSettle();
    expect(find.text('My access'), findsOneWidget);
  });

  testWidgets('my access → buildings → dashboard', (tester) async {
    tester.view.physicalSize = const Size(402, 874);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    // Scrolls a button into view, then taps it.
    Future<void> tapText(String text) async {
      await tester.ensureVisible(find.text(text));
      await tester.pumpAndSettle();
      await tester.tap(find.text(text));
      await tester.pumpAndSettle();
    }

    await tester.pumpWidget(const SinagApp(initialRoute: '/my-access'));
    await tester.pumpAndSettle();
    await tapText('Select building');
    expect(find.text('Buildings'), findsOneWidget);
    await tapText('Open Building A');
    await tester.pumpAndSettle();
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('This month vs baseline'), findsOneWidget);
    // Opening a building starts fresh, so there's no way back to sign-in.
    expect(find.byTooltip('Back'), findsNothing);

    // From the Dashboard, open Appliances, then go back.
    await tapText('Appliances  ·  Live load');
    expect(find.byTooltip('Back'), findsOneWidget);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('This month vs baseline'), findsOneWidget);
  });
}
