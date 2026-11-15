import 'package:flutter/material.dart';

import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 29 · Leadership summary — Figma frame 97:861
///
/// Read-only summary for the mayor / department head: three headline figures
/// (energy this month, savings this year, after-hours savings) and the
/// building rankings. Breakdowns are under "See details"; what this role can
/// and can't do is in the ⓘ. No bottom navigation.
class LeadershipSummaryScreen extends StatelessWidget {
  const LeadershipSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'MAYOR / DEPARTMENT HEAD',
      title: 'Leadership summary',
      about: const [
        'A read-only view of November progress.',
        'Changes, exports and alert-rule controls are not available to this '
            'role. No raw bill images or detailed action evidence are shown.',
        'This summary needs internet.',
      ],
      children: [
        const Tag('READ-ONLY · LGU LEADERSHIP'),
        Text(
          'November progress, at a glance',
          style: SinagText.sectionTitle.copyWith(fontSize: 19, height: 28 / 19),
        ),
        Panel(
          tone: PanelTone.navy,
          children: [
            const PanelTitle('Building A · 1–12 November'),
            Text(
              '5,100 kWh',
              style: SinagText.code.copyWith(color: Colors.white),
            ),
            const PanelText('₱56,100', color: Colors.white),
            const MoreDetails(
              children: [
                PanelText('Measured · reading 12 Nov at 09:40'),
                PanelText('Cost computed at ₱11/kWh'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('12.4% saved this year'),
            SinagProgressBar(fraction: 12.4 / 20),
            Tag('ON TARGET · GOAL 10–20%', color: SinagColors.success),
            MoreDetails(
              children: [
                PanelText('Savings, without the schedule effect'),
                KeyValue('Raw change · Computed', '−15.0%'),
                KeyValue('Per onsite day · Computed', '−5.6%'),
                KeyValue('Adjusted change · Computed', '−5.6%'),
                Note(
                  '600 kWh of the raw reduction comes from fewer onsite '
                  'days, not efficiency.',
                ),
                KeyValue('YTD adjusted · Computed', '12.4%'),
              ],
            ),
          ],
        ),
        const Panel(
          tone: PanelTone.success,
          children: [
            PanelTitle('186 kWh saved after hours'),
            PanelText('₱2,046 this month from staff responding to alerts.'),
            MoreDetails(
              children: [
                Note(
                  'Direct SINAG contribution · Computed. Confirmed '
                  'interventions only.',
                  color: SinagColors.success,
                ),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Building rankings'),
            KeyValue('1 · Building A', '12.4%'),
            KeyValue('2 · Annex', '8.1%'),
            KeyValue('Building B', 'Not ranked yet'),
            MoreDetails(
              children: [
                PanelText('YTD adjusted savings · Computed'),
                KeyValue('Building A', 'Tier 3 · live meters'),
                KeyValue('Annex', 'Tier 1 · bill-based'),
                Note(
                  'Building B is in bill-only mode for November. Incomplete '
                  'periods are excluded from rankings.',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
