import 'package:flutter/material.dart';

import '../../app/roles.dart';
import '../../app/routes.dart';
import '../../widgets/sinag_widgets.dart';

/// 06 · Scan bill — Figma frame 97:142
///
/// Focal person captures a monthly electricity bill (photo or PDF). Works
/// offline: captures wait on the phone until there is a connection. How
/// offline capture and OCR work is in the ⓘ.
class ScanBillScreen extends StatelessWidget {
  const ScanBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'FOCAL PERSON · CAPTURE',
      title: 'Scan bill',
      role: SinagRole.focalPerson,
      bottomBar: const RoleNav(items: focalNav),
      about: const [
        'Works offline: photos stay on this phone until a connection '
            'returns, then upload by themselves. Don’t remove the app before '
            'they sync.',
        'Reading the bill (OCR) starts after upload and needs internet. You '
            'confirm the numbers before they are saved.',
        'You capture and confirm bills only. Nothing is sent to DOE from '
            'here.',
      ],
      children: [
        const Tag('OFFLINE · 2 BILLS QUEUED'),
        Panel(
          children: [
            const PanelTitle('Capture the whole bill'),
            const PanelText('Keep all four corners visible and avoid glare.'),
            PrimaryButton(
              'Take a bill photo',
              onPressed: () => nav.pushNamed(Routes.reviewBill),
            ),
            SecondaryButton(
              'Upload a PDF',
              onPressed: () => nav.pushNamed(Routes.reviewBill),
            ),
          ],
        ),
        Panel(
          tone: PanelTone.warning,
          children: [
            const PanelTitle('August bill is missing'),
            const PanelText('Add it to complete the building’s record.'),
            SecondaryButton(
              'Add missing bill',
              onPressed: () => nav.pushNamed(Routes.reviewBill),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Waiting on this phone'),
            KeyValue('October · Building A', 'Queued'),
            KeyValue('September · Building A', 'Queued'),
          ],
        ),
        SecondaryButton(
          'Review uploaded bill',
          onPressed: () => nav.pushNamed(Routes.reviewBill),
        ),
      ],
    );
  }
}
