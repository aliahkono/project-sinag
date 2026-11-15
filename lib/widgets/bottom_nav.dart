import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import 'page_layout.dart';

/// The three tabs of the EEC Officer's bottom navigation.
enum SinagTab { dashboard, scanner, reports }

/// Figma component "BotNavBar" (1:2364): Dashboard · Scanner · Reports.
/// The highlighted tab sits on a navy pill. Every tab can be tapped,
/// including the highlighted one (see [openTab]):
/// - on that tab's own screen → scrolls back to the top
/// - anywhere else (e.g. Appliances, under Dashboard) → opens that tab
class SinagBottomNav extends StatelessWidget {
  const SinagBottomNav({super.key, this.current = SinagTab.dashboard});

  /// Which tab is highlighted.
  final SinagTab current;

  void _go(BuildContext context, SinagTab tab) {
    final route = switch (tab) {
      SinagTab.dashboard => Routes.dashboard,
      SinagTab.scanner => Routes.scanBill,
      SinagTab.reports => Routes.reports,
    };
    // Tabs are in enum order left to right, so the index difference gives
    // the slide direction.
    openTab(
      context,
      route,
      startFresh: true,
      direction: tabDirection(
        current.index,
        tab.index,
        count: SinagTab.values.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 23, right: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D1B365D),
            offset: Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Figma uses different icon artwork for active and inactive
          // Dashboard / Reports tabs, so each state has its own asset.
          current == SinagTab.dashboard
              ? _NavItem(
                  label: 'Dashboard',
                  icon: 'assets/images/nav_dashboard.svg',
                  iconSize: const Size(17.1, 21.1),
                  active: true,
                  onTap: () => _go(context, SinagTab.dashboard),
                )
              : _NavItem(
                  label: 'Dashboard',
                  icon: 'assets/images/nav_dashboard_inactive.svg',
                  iconSize: const Size(18, 18),
                  labelTopPadding: 4,
                  active: false,
                  onTap: () => _go(context, SinagTab.dashboard),
                ),
          _NavItem(
            label: 'Scanner',
            icon: 'assets/images/nav_scanner.svg',
            iconSize: const Size(20, 22),
            labelTopPadding: 4,
            active: current == SinagTab.scanner,
            onTap: () => _go(context, SinagTab.scanner),
          ),
          current == SinagTab.reports
              ? _NavItem(
                  label: 'Reports',
                  icon: 'assets/images/nav_reports_active.svg',
                  iconSize: const Size(18, 18),
                  labelTopPadding: 4,
                  active: true,
                  onTap: () => _go(context, SinagTab.reports),
                )
              : _NavItem(
                  label: 'Reports',
                  icon: 'assets/images/nav_reports.svg',
                  iconSize: const Size(18, 22),
                  active: false,
                  onTap: () => _go(context, SinagTab.reports),
                ),
        ],
      ),
    );
  }
}

/// One tab: icon above a label, on a navy pill when active.
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.iconSize,
    required this.active,
    required this.onTap,
    this.labelTopPadding = 0,
  });

  final String label;
  final String icon;
  final Size iconSize;
  final bool active;
  final VoidCallback onTap;
  final double labelTopPadding;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? SinagColors.navyActiveLabel
        : SinagColors.navInactive;
    // Flexible + scaleDown keeps the three tabs on one row on narrow phones.
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        // Screen readers announce the highlighted tab as "selected".
        child: Semantics(
          button: true,
          selected: active,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: active
                    ? SinagColors.navyActive.withValues(alpha: 0.8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: iconSize.width,
                    height: iconSize.height,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                  SizedBox(height: labelTopPadding),
                  Text(label, style: SinagText.navLabel.copyWith(color: color)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
