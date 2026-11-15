import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 20 · Meters — Figma frame 97:573
///
/// Health of each meter (online, buffering, failed). Each card shows its
/// status first; what it means is under "See details". The monitoring tiers
/// are explained in the ⓘ.
class MetersScreen extends StatelessWidget {
  const MetersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'DATA HEALTH',
      title: 'Meters',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'Monitoring tiers: Tier 1 = bills only. Tier 2 = main meter + bills. '
            'Tier 3 = appliance meters + main meter + bills.',
        'Months with a failed meter fall back to bill-only reporting. No live '
            'savings are claimed from missing readings.',
      ],
      children: [
        const Tag('BUILDING A · TIER 3'),
        const Panel(
          children: [
            PanelTitle('Main meter · MA-01'),
            Tag('ONLINE · LAST SEEN 09:40', color: SinagColors.success),
            MoreDetails(
              children: [
                PanelText('Building A · online'),
                KeyValue('Current load · Measured', '7.8 kW'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('AC-04 meter'),
            Tag('OFFLINE · STORING READINGS', color: SinagColors.warning),
            MoreDetails(
              children: [
                PanelText('Building A · storing readings locally (buffering)'),
                KeyValue('Last contact', '11 Nov · 14:10'),
                Note(
                  'Approximately 7 days of local storage. Readings sync when '
                  'the connection returns.',
                ),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-02 meter'),
            Tag('ONLINE · CAUGHT UP', color: SinagColors.success),
            MoreDetails(
              children: [
                PanelText(
                  'Building A · reconnected at 07:45 · backfill '
                  'received',
                ),
                Note(
                  'Overnight records are marked late detection. Original '
                  'measurement times are preserved.',
                ),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Building B · main meter MB-01'),
            const Tag(
              'FAILED · BILLS ONLY THIS MONTH',
              color: SinagColors.dangerText,
            ),
            SecondaryButton(
              'Report / view meter fault',
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.reportMeterFault),
            ),
            const MoreDetails(
              children: [
                PanelText(
                  'Tier 2 · failed since 10 Nov · November bill-only '
                  'mode',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
