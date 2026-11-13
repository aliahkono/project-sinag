import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';
import 'role_navs.dart';

/// 17 · Focal workspace (97:476)
class FocalWorkspaceScreen extends StatelessWidget {
  const FocalWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'FOCAL PERSON',
      title: 'Focal workspace',
      bottomBar: RoleNav(items: focalNav, selected: 0),
      children: [
        const Tag('FOCAL PERSON · BUILDING A'),
        Panel(
          children: [
            const PanelTitle('Your next actions'),
            const PanelText(
              'Scan bills, review readings and follow up alerts.',
            ),
            PrimaryButton(
              'Scan or upload bill',
              onPressed: () => nav.pushNamed(Routes.scanBill),
            ),
            SecondaryButton(
              'Review extracted bill',
              onPressed: () => nav.pushNamed(Routes.reviewBill),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('2 bills waiting to upload'),
            PanelText('October and September are saved on this phone.'),
            Tag('OFFLINE CAPTURE · OCR AFTER SYNC', color: SinagColors.warning),
          ],
        ),
        Panel(
          tone: PanelTone.warning,
          children: [
            const PanelTitle('1 reading needs review'),
            const PanelText(
              'October bill and main meter differ by 3.8%. Confirm the source values; the EEC Officer approves or rejects held readings.',
            ),
            SecondaryButton(
              'Review source readings',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('2 open after-hours alerts'),
            const PanelText(
              'AC-03 · Council office\nLT-02 · East wing lighting',
            ),
            SecondaryButton(
              'Follow up alerts',
              onPressed: () => nav.pushNamed(Routes.alerts),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Your access'),
            PanelText(
              'No alert-rule editing or report exports. Contact the EEC Officer if a correction needs approval.',
            ),
          ],
        ),
        const Note(
          'Bill photos and SMS replies work offline. Live readings and OCR need internet.',
        ),
      ],
    );
  }
}

/// 18 · Facility workspace (97:508)
class FacilityWorkspaceScreen extends StatelessWidget {
  const FacilityWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'FACILITY MANAGER',
      title: 'Facility workspace',
      bottomBar: RoleNav(items: facilityNav, selected: 0),
      children: [
        const Tag('FACILITY MANAGER · BUILDING A'),
        Panel(
          children: [
            const PanelTitle('Check the building'),
            const PanelText(
              'Respond to alerts and inspect metered appliances.',
            ),
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
            const PanelText('Council office · 2nd floor'),
            const KeyValue('Last recorded load', '2.4 kW · Measured'),
            const KeyValue('Estimated hourly cost', '₱26.40 · Computed'),
            SecondaryButton(
              'Record what was done',
              onPressed: () => nav.pushNamed(Routes.closeAlert),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('LT-02 · late detection'),
            const PanelText(
              'The meter reconnected at 07:45. Review the overnight lighting load, not the arrival time.',
            ),
            SecondaryButton(
              'Investigate late reading',
              onPressed: () => nav.pushNamed(Routes.meters),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Your access'),
            PanelText(
              'Alerts, appliance details and action records. Alert rules, data approval and exports are managed by the EEC Officer.',
            ),
          ],
        ),
        const PanelText(
          'No remote switching. Inspect the equipment and decide what to do. SMS replies work without mobile data.',
        ),
      ],
    );
  }
}
