import 'package:flutter/material.dart';

import '../app/roles.dart';
import 'bottom_nav.dart';
import 'buttons.dart';
import 'page_layout.dart';

// Every tab here can be tapped, including the highlighted one (see openTab):
// - on that tab's own screen → scrolls back to the top
// - anywhere else → opens that tab's screen

/// "Role-specific navigation" (bottom bar for focal persons and facility
/// managers): a white strip of small buttons, one per tab. Each tab is a
/// (label, route) pair. These are top-level sections, so opening one clears
/// the history (no back arrow).
///
/// The highlighted (navy) tab follows the screen you are on: on Review bill,
/// "Review" is highlighted. A screen that isn't itself a tab (e.g. Focal
/// workspace, Alert detail) says which tab it belongs to with [section].
class RoleNav extends StatelessWidget {
  const RoleNav({super.key, required this.items, this.section});

  /// (label, route) for each tab.
  final List<(String, String)> items;

  /// Route of the tab to highlight when the current screen isn't a tab.
  final String? section;

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)?.settings.name;
    // The current screen wins if it is one of the tabs.
    var selected = items.indexWhere((item) => item.$2 == current);
    if (selected < 0) {
      selected = items.indexWhere((item) => item.$2 == section);
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(
              child: _Tab(
                label: items[i].$1,
                selected: i == selected,
                onTap: () => openTab(
                  context,
                  items[i].$2,
                  startFresh: true,
                  direction: tabDirection(selected, i, count: items.length),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Bottom bar for screens shared by several roles (Alerts, Appliances and
/// their detail screens). Shows the bar of the role the user is working as
/// (see [SinagSession]):
///
/// - EEC Officer      → Dashboard · Scanner · Reports, with [eecTab] lit
/// - Focal person     → Bills · Review · Alerts
/// - Facility manager → Alerts · Appliances
///
/// [section] is the route of the role tab this screen belongs to, e.g.
/// Routes.alerts for Alert detail.
class SharedBottomBar extends StatelessWidget {
  const SharedBottomBar({
    super.key,
    required this.section,
    this.eecTab = SinagTab.dashboard,
  });

  final String section;
  final SinagTab eecTab;

  @override
  Widget build(BuildContext context) => switch (SinagSession.role) {
    SinagRole.eecOfficer => SinagBottomNav(current: eecTab),
    SinagRole.focalPerson => RoleNav(items: focalNav, section: section),
    SinagRole.facilityManager => RoleNav(items: facilityNav, section: section),
  };
}

/// Tabs inside a page, e.g. "Open (2) / Resolved (8)". Each tab is a
/// (label, route) pair. Switching swaps the screen in place, so the back
/// arrow still returns to wherever the user came from.
class PageTabs extends StatelessWidget {
  const PageTabs({super.key, required this.tabs, required this.selected});
  final List<(String, String)> tabs;

  /// Index of the highlighted tab.
  final int selected;

  @override
  Widget build(BuildContext context) => SmallButtonRow(
    children: [
      for (var i = 0; i < tabs.length; i++)
        _Tab(
          label: tabs[i].$1,
          selected: i == selected,
          onTap: () => openTab(
            context,
            tabs[i].$2,
            startFresh: false,
            direction: tabDirection(selected, i, count: tabs.length),
          ),
        ),
    ],
  );
}

/// One tab: a small button, navy when selected, announced as "selected"
/// by screen readers.
class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    child: SmallButton(label: label, primary: selected, onPressed: onTap),
  );
}
