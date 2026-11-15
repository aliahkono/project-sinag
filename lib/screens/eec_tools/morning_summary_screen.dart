import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 24 · Morning summary — Figma frame 97:701
///
/// The 8:00 AM digest: overnight alerts that need follow-up and data needing
/// attention. Each item shows what to do; timings and figures are under
/// "See details".
class MorningSummaryScreen extends StatelessWidget {
  const MorningSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'EEC OFFICER · 8:00 AM',
      title: 'Morning summary',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'Delivered every day at 08:00, computed from the latest synced meter '
            'records. Delivery needs internet.',
        'Late detections keep both the time the reading was measured and the '
            'time it was received.',
      ],
      children: [
        const Tag('DELIVERED AT 08:00 · 12 NOV 2026'),
        Panel(
          tone: PanelTone.navy,
          children: [
            const PanelTitle('Your overnight summary'),
            Text(
              '2 alerts need follow-up',
              style: SinagText.mediumNumber.copyWith(
                fontSize: 23,
                height: 33 / 23,
              ),
            ),
            const PanelText('Building A · EEC Officer'),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const Tag('ACTION RECORD MISSING', color: SinagColors.warning),
            SecondaryButton(
              'Finish action record',
              onPressed: () => nav.pushNamed(Routes.closeAlert),
            ),
            const MoreDetails(
              children: [
                PanelText('Detected 18:00 · notified 18:30 · 11 Nov'),
                Tag(
                  'ACKNOWLEDGED · ACTION RECORD MISSING',
                  color: SinagColors.warning,
                ),
                KeyValue('Waste · Computed', '4.8 kWh / ₱52.80'),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('LT-02 · East wing lighting'),
            const Tag('LATE DETECTION', color: SinagColors.dangerText),
            SecondaryButton(
              'Review late detection',
              onPressed: () => nav.pushNamed(Routes.meters),
            ),
            const MoreDetails(
              children: [
                PanelText('Measured 11 Nov, 18:00–20:00'),
                KeyValue('Readings arrived', '12 Nov · 07:45'),
                KeyValue('Waste · Computed', '1.8 kWh / ₱19.80'),
                Note(
                  'Meter was offline. These readings were not available for '
                  'a real-time alert.',
                ),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Data needing attention'),
            const KeyValue('Held readings / bill checks', '4 items'),
            const KeyValue('Offline meter (storing readings)', 'AC-04'),
            SecondaryButton(
              'Open data review queue',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
          ],
        ),
      ],
    );
  }
}
