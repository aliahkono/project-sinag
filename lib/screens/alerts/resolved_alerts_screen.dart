import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';
import 'alert_tabs.dart';

/// 31 · Resolved alerts — Figma frame 97:889
///
/// Closed alerts with their evidence records. The Open / Resolved tabs switch
/// back to 11 · Alerts. Each card shows how it was resolved; the evidence is
/// under "See details".
class ResolvedAlertsScreen extends StatelessWidget {
  const ResolvedAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'AFTER-HOURS · EVIDENCE',
      title: 'Resolved alerts',
      bottomBar: const SharedBottomBar(section: Routes.alerts),
      about: const [
        'An alert is resolved once an action or an approved exception is '
            'recorded.',
        'Showing 3 of 8 resolved alerts. Detection, grace, notification, '
            'escalation and acknowledgment times remain in every record.',
      ],
      children: [
        const PageTabs(tabs: alertTabs, selected: 1),
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const Tag(
              'RESOLVED · MANUAL SWITCH-OFF',
              color: SinagColors.success,
            ),
            const PanelText('07 Nov · closed 20:15'),
            MoreDetails(
              children: [
                const KeyValue('Waste · Computed', '3.6 kWh / ₱39.60'),
                const PanelText(
                  'Facility manager: guard checked the empty office and '
                  'switched off the unit. Meter trace confirmed standby.',
                  color: SinagColors.text,
                ),
                const KeyValue('Evidence record', 'FM-1107-02'),
                SecondaryButton(
                  'View saved action record',
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.activityLog),
                ),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('AC-03 · Council office'),
            Tag('RESOLVED · APPROVED OVERTIME'),
            PanelText('03 Nov'),
            MoreDetails(
              children: [
                PanelText(
                  'Session approval EVT-1103 matched 18:00–21:00. Approved '
                  'energy excluded from waste.',
                  color: SinagColors.text,
                ),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-01 · Treasury lighting'),
            Tag('RESOLVED · METER ERROR', color: SinagColors.warning),
            PanelText('02 Nov'),
            MoreDetails(
              children: [
                PanelText(
                  'Fault verified by the EEC Officer. Reading rejected '
                  '(invalid data excluded) and maintenance reference linked.',
                  color: SinagColors.text,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
