import 'package:flutter/material.dart';

import '../../app/buildings.dart';
import '../../app/roles.dart';
import '../../app/routes.dart';
import '../../widgets/sinag_widgets.dart';

/// 17 · Focal workspace — Figma frame 97:476
///
/// Focal person's home, written as a to-do list in plain words: what to do
/// today, bills waiting to upload, a bill that doesn't match the meter, and
/// open alerts. Access rules and offline notes are in the ⓘ.
class FocalWorkspaceScreen extends StatelessWidget {
  const FocalWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'FOCAL PERSON',
      title: 'Focal workspace',
      role: SinagRole.focalPerson,
      bottomBar: const RoleNav(items: focalNav, section: Routes.scanBill),
      about: const [
        'You scan bills, check the numbers read from them, and follow up '
            'alerts.',
        'You can’t edit alert rules or export reports. Ask the EEC Officer '
            'if a correction needs approval.',
        'Bill photos and SMS replies work offline. Live readings and reading '
            'the bill (OCR) need internet.',
      ],
      children: [
        Tag('FOCAL PERSON · ${selectedBuildingTag()}'),
        Panel(
          children: [
            const PanelTitle('What to do today'),
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
        Panel(
          tone: PanelTone.warning,
          children: [
            const PanelTitle('1 bill doesn’t match the meter'),
            const PanelText(
              'The October bill is 3.8% higher than the meter. Check the '
              'numbers.',
            ),
            SecondaryButton(
              'Review source readings',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
            const MoreDetails(
              children: [
                PanelText(
                  'October bill and main meter differ by 3.8%. Confirm the '
                  'source values; the EEC Officer approves or rejects held '
                  'readings.',
                ),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('2 bills waiting to upload'),
            PanelText('October and September are saved on this phone.'),
            MoreDetails(
              children: [
                Note('Offline capture · the bill is read (OCR) after sync.'),
              ],
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
      ],
    );
  }
}
