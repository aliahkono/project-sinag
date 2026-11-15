import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';
import 'alert_tabs.dart';

/// 11 · Alerts — Figma frame 97:284
///
/// Open after-hours alerts and this week's after-hours waste. The Open /
/// Resolved tabs switch to 31 · Resolved alerts. Each alert shows what to do
/// first; timings and figures are under "See details".
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'AFTER-HOURS · OPEN',
      title: 'Alerts',
      bottomBar: const SharedBottomBar(section: Routes.alerts),
      about: const [
        'An alert opens when equipment keeps using power after office hours.',
        'Hourly cost is computed at ₱11/kWh. Waste counts only confirmed, '
            'unapproved use; approved overtime and events are excluded.',
        'Updated 08:00. The EEC morning summary lists the same alerts.',
      ],
      children: [
        const PageTabs(tabs: alertTabs, selected: 0),
        Panel(
          tone: PanelTone.navy,
          children: [
            const PanelTitle('This week’s after-hours waste'),
            Text(
              '32.4 kWh  ·  ₱356.40',
              style: SinagText.mediumNumber.copyWith(
                fontSize: 23,
                height: 33 / 23,
              ),
            ),
            const Caption('09–15 Nov'),
            const MoreDetails(
              children: [
                Caption('Computed · confirmed unapproved consumption'),
                Caption('Excludes approved events'),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const Tag('NEEDS AN ACTION RECORD', color: SinagColors.warning),
            const KeyValue('Using now', '2.4 kW · ₱26.40/hr'),
            PrimaryButton(
              'Investigate AC-03',
              onPressed: () => nav.pushNamed(Routes.alertDetail),
            ),
            const MoreDetails(
              children: [
                PanelText('11 Nov · detected 18:00 · notified 18:30'),
                Tag(
                  'ACKNOWLEDGED · AWAITING ACTION RECORD',
                  color: SinagColors.warning,
                ),
                KeyValue('Waste so far · Computed', '4.8 kWh · ₱52.80'),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('LT-02 · East wing lighting'),
            const Tag(
              'LATE · METER WAS OFFLINE',
              color: SinagColors.dangerText,
            ),
            SecondaryButton(
              'Review late detection',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
            const MoreDetails(
              children: [
                PanelText('11 Nov · readings received 12 Nov at 07:45'),
                KeyValue('Recorded overnight load', '0.9 kW · ₱9.90/hr'),
              ],
            ),
          ],
        ),
        SecondaryButton(
          'Log approved overtime / event',
          onPressed: () => nav.pushNamed(Routes.overtimeEvents),
        ),
      ],
    );
  }
}
