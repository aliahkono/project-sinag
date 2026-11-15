import 'package:flutter/material.dart';

import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 16 · Overtime & events — Figma frame 97:444
///
/// Log approved overtime or events in advance so their energy isn't counted as
/// after-hours waste.
class OvertimeEventsScreen extends StatelessWidget {
  const OvertimeEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'APPROVED EXCEPTIONS',
      title: 'Overtime & events',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'Log approved overtime or events before they start. Approved time is '
            'excluded from alerts and after-hours waste.',
        'An approval is required: unapproved requests don’t stop alerts, and '
            'an overtime quick reply must match a valid approval record.',
        'Alerts resume when the event ends, with the usual 30-minute grace '
            'period. Loads outside the zone are still monitored.',
      ],
      children: [
        const Tag('LOG BEFORE THE ACTIVITY STARTS'),
        const SinagField(
          label: 'Office / zone',
          initialValue: 'Council office · Council wing',
        ),
        const SinagField(label: 'Activity', initialValue: 'Council session'),
        const SinagField(
          label: 'Date & time',
          initialValue: '17 Nov 2026 · 18:00–21:00',
        ),
        const SinagField(
          label: 'Affected loads',
          initialValue: 'AC-03 · LT-02',
        ),
        const SinagField(
          label: 'Approval reference',
          initialValue: 'EVT-1117 · approved by department head',
        ),
        const SinagField(
          label: 'Approval evidence',
          initialValue: 'Session calendar reference SC-1117',
        ),
        PrimaryButton(
          'Save approved event',
          onPressed: () => showSinagSnack(context, 'Approved event saved'),
        ),
        const Panel(
          children: [
            PanelTitle('Upcoming approved events'),
            Tag('17 NOV · 18:00–21:00'),
            PanelText('Council session', color: SinagColors.text),
            MoreDetails(
              children: [
                PanelText(
                  'AC-03 and LT-02 · Approval EVT-1117 · Council wing',
                  color: SinagColors.text,
                ),
                Note(
                  'Alerts resume at 21:00 with a 30-minute grace period. '
                  'Loads outside this zone are still monitored.',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
