import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';

/// 08 · Appliances (97:206)
class AppliancesScreen extends StatelessWidget {
  const AppliancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'LIVE MONITORING',
      title: 'Appliances',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Tag('ONLINE · LAST READING 09:40', color: SinagColors.success),
        const Panel(
          children: [
            PanelTitle('Today’s building energy'),
            KeyValue('Main meter · Measured', '186 kWh'),
            KeyValue('Metered loads · Measured', '128 kWh'),
            KeyValue('Unmetered remainder · Computed', '58 kWh'),
            Note(
              'Main meter minus all metered appliances. Inventory estimates 52 kWh for unmetered equipment; the 6 kWh gap is not assigned to a load.',
            ),
          ],
        ),
        SecondaryButton(
          'Aircon  ·  Lighting  ·  All loads',
          onPressed: () => showSinagSnack(context, 'Showing all loads'),
        ),
        Panel(
          children: [
            const PanelTitle('AC-03 · Aircon'),
            const PanelText('Council office · 2nd floor'),
            const Tag('AFTER-HOURS ALERT', color: SinagColors.dangerText),
            const KeyValue('Live · Measured', '2.4 kW'),
            const KeyValue('Today · Measured', '19.2 kWh'),
            SecondaryButton(
              'View AC-03',
              onPressed: () => nav.pushNamed(Routes.applianceDetail),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('AC-01 · Aircon'),
            PanelText('Treasury · Ground floor'),
            Tag('STANDBY', color: SinagColors.success),
            KeyValue('Live · Measured', '0.03 kW'),
            KeyValue('Today · Measured', '12.6 kWh'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-02 · Lighting circuit'),
            PanelText('East wing · 2nd floor'),
            Tag('ON · WITHIN SCHEDULE'),
            KeyValue('Live · Measured', '0.9 kW'),
            KeyValue('Today · Measured', '7.2 kWh'),
          ],
        ),
        const Note(
          'Showing 3 of 12 metered loads · Live values need internet. No remote on/off controls.',
        ),
      ],
    );
  }
}

/// 09 · Appliance detail (97:238)
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
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Panel(
          children: [
            PanelTitle('AC-03 · Council office'),
            PanelText('2nd floor · Aircon · Meter AC-03-M'),
            Tag('OPEN AFTER-HOURS ALERT', color: SinagColors.dangerText),
            KeyValue('Live · Measured', '2.4 kW'),
            KeyValue('11 Nov total · Measured', '24.0 kWh'),
            Caption('Latest reading · 12 Nov, 09:40'),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Yesterday’s load profile'),
            const PanelText('11 November 2026'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Caption('kW · 24-hour timeline · Measured'),
                SizedBox(height: 5),
                LoadBarChart(barHeights: _hourly),
                SizedBox(height: 5),
                KeyValue('00:00      08:00', '18:00      24:00'),
                SizedBox(height: 5),
                Caption('Blue shading = office hours · 08:00–18:00'),
              ],
            ),
            const KeyValue('Standby rule', 'Above 0.10 kW'),
            const KeyValue('Allowed office hours', '08:00–18:00'),
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
        const Note(
          'A person checks the unit and chooses an action. SINAG never switches equipment off.',
        ),
      ],
    );
  }
}
