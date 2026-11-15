import 'package:flutter/material.dart';

import '../../app/glossary.dart';
import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 09 · Appliance detail — Figma frame 97:238
///
/// One appliance (AC-03): what it is using now, yesterday's hourly chart and
/// its alert history. Meter details and rules are under "See details".
class ApplianceDetailScreen extends StatelessWidget {
  const ApplianceDetailScreen({super.key});

  // Bar heights (px on the 132px chart) for 00:00–23:00, from the design.
  static const _hourly = <double>[
    4.32, 3.24, 3.24, 3.24, 3.24, 3.24, 4.32, 8.64, //
    64.8, 86.4, 75.6, 97.2, 64.8, 81, 86.4, 75.6, //
    86.4, 97.2, 81, 81, 4.32, 3.24, 3.24, 3.24,
  ];

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'METERED LOAD',
      title: 'Appliance detail',
      bottomBar: const SharedBottomBar(section: Routes.appliances),
      about: const [
        Glossary.noRemoteControl,
        'Latest reading · 12 Nov, 09:40.',
        ...Glossary.dataLabels,
      ],
      children: [
        const Panel(
          children: [
            PanelTitle('AC-03 · Council office'),
            Tag('OPEN AFTER-HOURS ALERT', color: SinagColors.dangerText),
            KeyValue('Using now', '2.4 kW'),
            MoreDetails(
              children: [
                PanelText('2nd floor · Aircon · Meter AC-03-M'),
                KeyValue('Live · Measured', '2.4 kW'),
                KeyValue('11 Nov total · Measured', '24.0 kWh'),
                Caption('Latest reading · 12 Nov, 09:40'),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Yesterday’s use'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                LoadBarChart(barHeights: _hourly),
                SizedBox(height: 5),
                KeyValue('00:00      08:00', '18:00      24:00'),
                SizedBox(height: 5),
                Caption('Blue = office hours, 08:00–18:00'),
              ],
            ),
            const MoreDetails(
              children: [
                PanelText('11 November 2026 · kW · Measured'),
                KeyValue('Standby rule', 'Above 0.10 kW'),
                KeyValue('Allowed office hours', '08:00–18:00'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Alert history'),
            KeyValue('11 Nov · 18:30', 'Open · 4.8 kWh'),
            KeyValue('07 Nov · 18:30', 'Resolved · switched off'),
            KeyValue('03 Nov · 19:00', 'Approved overtime'),
          ],
        ),
        PrimaryButton(
          'View latest alert',
          onPressed: () => Navigator.of(context).pushNamed(Routes.alertDetail),
        ),
      ],
    );
  }
}
