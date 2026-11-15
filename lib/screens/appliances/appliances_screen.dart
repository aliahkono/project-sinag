import 'package:flutter/material.dart';

import '../../app/glossary.dart';
import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 08 · Appliances — Figma frame 97:206
///
/// Live load of the building's metered appliances, and today's energy for
/// the whole building. Each appliance shows what it is using now; today's
/// totals and the energy split are under "See details".
class AppliancesScreen extends StatelessWidget {
  const AppliancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'LIVE MONITORING',
      title: 'Appliances',
      bottomBar: const SharedBottomBar(section: Routes.appliances),
      about: const [
        'Showing 3 of 12 metered loads.',
        Glossary.needsInternet,
        Glossary.noRemoteControl,
        ...Glossary.dataLabels,
      ],
      children: [
        const Tag('ONLINE · LAST READING 09:40', color: SinagColors.success),
        const Panel(
          children: [
            PanelTitle('Today’s building energy'),
            KeyValue('Used so far', '186 kWh'),
            MoreDetails(
              children: [
                KeyValue('Main meter · Measured', '186 kWh'),
                KeyValue('Metered loads · Measured', '128 kWh'),
                KeyValue('Unmetered remainder · Computed', '58 kWh'),
                Note(
                  'Main meter minus all metered appliances. Inventory '
                  'estimates 52 kWh for unmetered equipment; the 6 kWh gap '
                  'is not assigned to a load.',
                ),
              ],
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
            const Tag('AFTER-HOURS ALERT', color: SinagColors.dangerText),
            const KeyValue('Using now', '2.4 kW'),
            SecondaryButton(
              'View AC-03',
              onPressed: () => nav.pushNamed(Routes.applianceDetail),
            ),
            const MoreDetails(
              children: [
                PanelText('Council office · 2nd floor'),
                KeyValue('Live · Measured', '2.4 kW'),
                KeyValue('Today · Measured', '19.2 kWh'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('AC-01 · Aircon'),
            Tag('STANDBY', color: SinagColors.success),
            KeyValue('Using now', '0.03 kW'),
            MoreDetails(
              children: [
                PanelText('Treasury · Ground floor'),
                KeyValue('Today · Measured', '12.6 kWh'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-02 · Lighting circuit'),
            Tag('ON · WITHIN SCHEDULE'),
            KeyValue('Using now', '0.9 kW'),
            MoreDetails(
              children: [
                PanelText('East wing · 2nd floor'),
                KeyValue('Today · Measured', '7.2 kWh'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
