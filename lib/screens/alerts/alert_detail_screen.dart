import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 12 · Alert detail — Figma frame 97:316
///
/// One alert: how much was wasted, where it stands now, and what to do.
/// The overnight chart and the full timeline are under "See …" toggles.
class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key});

  static const _overnight = <double>[
    86.4, 86.4, 3.24, 3, 3, 3, 3, 3, 3, 3, 3, 3, //
  ];
  static const _colors = <Color>[
    SinagColors.dangerText, SinagColors.dangerText, //
    SinagColors.navy, SinagColors.navy, SinagColors.navy, SinagColors.navy,
    SinagColors.navy, SinagColors.navy, SinagColors.navy, SinagColors.navy,
    SinagColors.navy, SinagColors.navy,
  ];

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'AFTER-HOURS · INVESTIGATE',
      title: 'Alert detail',
      bottomBar: const SharedBottomBar(section: Routes.alerts),
      about: const [
        'Energy is only excluded as overtime when there is an approval '
            'record.',
        'Closing the alert stores the evidence for spot checks.',
        'Cost is computed at ₱11/kWh from the measured load.',
      ],
      children: [
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const Tag('NEEDS AN ACTION RECORD', color: SinagColors.warning),
            Text(
              '4.8 kWh  /  ₱52.80',
              style: SinagText.alertFigure.copyWith(
                fontSize: 24,
                height: 35 / 24,
              ),
            ),
            const PanelText('Wasted after hours, 18:00–20:00'),
            const MoreDetails(
              label: 'See overnight chart',
              children: [
                PanelText('Alert A-1126-03 · 11 November'),
                Note(
                  'Computed waste · 18:00–20:00\n'
                  'Measured load 2.4 kW · cost at ₱11/kWh',
                ),
                Caption('kW · overnight · Measured'),
                LoadBarChart(
                  barHeights: _overnight,
                  barColors: _colors,
                  shadeFrom: 0,
                  shadeTo: 12,
                  shadeColor: SinagColors.tintDanger,
                ),
                KeyValue('18:00       22:00', '02:00       06:00'),
                Caption('Red = after-hours load; 2.4 kW until 20:00.'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Where it stands'),
            TimelineRow('19:10', 'Acknowledged · “I’ll check it”'),
            TimelineRow('20:00', 'Load fell to standby · action not recorded'),
            MoreDetails(
              label: 'See full timeline',
              children: [
                TimelineRow(
                  '18:00',
                  'Detected above 0.10 kW after office hours',
                ),
                TimelineRow('18:00–18:30', 'Grace period · 30 minutes'),
                TimelineRow('18:30', 'Push + SMS to facility manager'),
                TimelineRow('19:00', 'Escalated to EEC Officer + guard'),
              ],
            ),
          ],
        ),
        PrimaryButton(
          'Record action & close',
          onPressed: () => nav.pushNamed(Routes.closeAlert),
        ),
        SecondaryButton(
          'Approved overtime',
          onPressed: () => nav.pushNamed(Routes.overtimeEvents),
        ),
        SecondaryButton(
          'Report meter error',
          onPressed: () => nav.pushNamed(Routes.reportMeterFault),
        ),
      ],
    );
  }
}
