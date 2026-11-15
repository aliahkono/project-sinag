import 'package:flutter/material.dart';

import '../../app/buildings.dart';
import '../../app/glossary.dart';
import '../../app/roles.dart';
import '../../app/routes.dart';
import '../../widgets/sinag_widgets.dart';

/// 18 · Facility workspace — Figma frame 97:508
///
/// Facility manager's home, in plain words: what to do, the unit that needs
/// a record of what was done, and a late meter reading to check. Access
/// rules and the no-remote-switching note are in the ⓘ.
class FacilityWorkspaceScreen extends StatelessWidget {
  const FacilityWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'FACILITY MANAGER',
      title: 'Facility workspace',
      role: SinagRole.facilityManager,
      bottomBar: const RoleNav(items: facilityNav, section: Routes.alerts),
      about: const [
        'You respond to alerts, check equipment, and record what was done.',
        Glossary.noRemoteControl,
        'Alert rules, approving data and exports are handled by the EEC '
            'Officer.',
        'SMS replies work without mobile data.',
      ],
      children: [
        Tag('FACILITY MANAGER · ${selectedBuildingTag()}'),
        Panel(
          children: [
            const PanelTitle('What to do'),
            PrimaryButton(
              'Open after-hours alerts',
              onPressed: () => nav.pushNamed(Routes.alerts),
            ),
            SecondaryButton(
              'View appliances',
              onPressed: () => nav.pushNamed(Routes.appliances),
            ),
          ],
        ),
        Panel(
          tone: PanelTone.danger,
          children: [
            const PanelTitle('AC-03 needs an action record'),
            const PanelText(
              'Council office · 2nd floor. Was using about ₱26 an hour.',
            ),
            SecondaryButton(
              'Record what was done',
              onPressed: () => nav.pushNamed(Routes.closeAlert),
            ),
            const MoreDetails(
              children: [
                KeyValue('Last recorded load', '2.4 kW · Measured'),
                KeyValue('Estimated hourly cost', '₱26.40 · Computed'),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('LT-02 lights: reading came in late'),
            const PanelText(
              'The meter was offline overnight. Check the lighting load, not '
              'the time it arrived.',
            ),
            SecondaryButton(
              'Investigate late reading',
              onPressed: () => nav.pushNamed(Routes.meters),
            ),
            const MoreDetails(
              children: [PanelText('The meter reconnected at 07:45.')],
            ),
          ],
        ),
      ],
    );
  }
}
