import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 25 · Inventory — Figma frame 97:733
///
/// Yearly register of appliances (rated watts, hours used, standby thresholds)
/// used for estimates and alert rules. Each item shows its rating; usual use
/// and threshold are under "See details".
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'JANUARY REGISTER',
      title: 'Inventory',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'The register is used for estimates and alert rules. Building A was '
            'last approved on 20 January.',
        'Estimated figures are rated watts × usual hours. They are not '
            'measured readings and not a direct savings claim.',
        'The next annual inventory is due January 2027. Equipment changes '
            'during the year also need a dated operating-change record.',
      ],
      children: [
        const Tag('JANUARY 2026 REGISTER · BUILDING A'),
        SecondaryButton(
          'Aircon  ·  Lighting  ·  Equipment',
          onPressed: () => showSinagSnack(context, 'Showing all categories'),
        ),
        const Panel(
          children: [
            PanelTitle('AC-03 · Aircon'),
            KeyValue('Rated input', '2,400 W'),
            MoreDetails(
              children: [
                PanelText('Council office · metered'),
                KeyValue('Usual use', '8 h / onsite day'),
                KeyValue('Standby threshold', '0.10 kW'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-02 · Lighting circuit'),
            KeyValue('Rated load', '900 W'),
            MoreDetails(
              children: [
                PanelText('East wing · metered'),
                KeyValue('Usual use', '8 h / onsite day'),
                KeyValue('Standby threshold', '0.05 kW'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Unmetered equipment group'),
            Tag('52 kWh / DAY · ESTIMATED', color: SinagColors.warning),
            MoreDetails(
              children: [
                PanelText('Computers, printers and pantry equipment'),
                KeyValue('Combined rated input', '6,500 W'),
                KeyValue('Usual use', '8 h / onsite day'),
                Note(
                  'Rated watts × usual hours. Not a measured reading and not '
                  'a direct savings claim.',
                ),
              ],
            ),
          ],
        ),
        PrimaryButton(
          'Add / edit inventory item',
          onPressed: () =>
              Navigator.of(context).pushNamed(Routes.operatingChanges),
        ),
      ],
    );
  }
}
