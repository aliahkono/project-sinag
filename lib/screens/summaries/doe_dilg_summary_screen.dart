import 'package:flutter/material.dart';

import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 30 · DOE / DILG summary — Figma frame 97:875
///
/// Read-only view the LGU shares with DOE / DILG, limited to the approved
/// scope and dates. What is shared, the energy figures and the ranking come
/// first; the scope rules are in the ⓘ. No bottom navigation.
class DoeDilgSummaryScreen extends StatelessWidget {
  const DoeDilgSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'LGU-AUTHORIZED VIEW',
      title: 'DOE / DILG summary',
      about: const [
        'Energy summaries and rankings only. Raw bills, alert evidence, rule '
            'changes and detailed activity are not shared.',
        'Only authorized buildings are shown; other LGU buildings and their '
            'rankings are hidden.',
        'The LGU can revoke access at any time. This view is not a '
            'submission: official reports are submitted by the EEC Officer in '
            'the GEMP Online System.',
        'Internet is required to validate access.',
      ],
      children: [
        const Tag('READ-ONLY · NO EDITING · NO EXPORTS'),
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Shared by the LGU'),
            PanelText('Building A only · until 31 Dec 2026'),
            MoreDetails(
              children: [
                KeyValue('Authorization', 'SHARE-1126'),
                KeyValue('Expires', '31 Dec 2026'),
                Note(
                  'Access may be revoked by the LGU at any time. This view '
                  'is not a submission.',
                ),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Building A · November to date'),
            Text('5,100 kWh', style: SinagText.code),
            const KeyValue('Cost', '₱56,100'),
            const KeyValue('Saved this year', '12.4%'),
            const MoreDetails(
              children: [
                PanelText('Measured · last reading 12 Nov at 09:40'),
                KeyValue('Cost · Computed', '₱56,100'),
                KeyValue('Adjusted change · Computed', '−5.6%'),
                KeyValue('YTD adjusted · Computed', '12.4%'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Shared building ranking'),
            KeyValue('1 · Building A', '12.4%'),
          ],
        ),
      ],
    );
  }
}
