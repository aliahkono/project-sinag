import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 15 · Work calendar — Figma frame 97:412
///
/// Weekday, work-from-home and weekend schedules, holidays and council
/// sessions that decide when "after hours" starts.
class WorkCalendarScreen extends StatelessWidget {
  const WorkCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'EEC OFFICER ONLY',
      title: 'Work calendar',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'The calendar decides when "after hours" starts for each zone.',
        'During an approved council session, only loads in that zone and '
            'time window are exempt. Afterwards the normal grace and '
            'escalation rules resume.',
      ],
      children: [
        const Panel(
          children: [
            PanelTitle('Zone schedule'),
            PanelText('Council wing · Building A'),
            SinagField(
              label: 'Weekdays',
              initialValue: 'Mon–Thu · 08:00–18:00',
            ),
            SinagField(
              label: 'Work-from-home day',
              initialValue: 'Friday · no onsite hours',
            ),
            SinagField(
              label: 'Weekend schedule',
              initialValue: 'Saturday & Sunday · closed',
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Holiday calendar · 2026'),
            const KeyValue('30 Nov · Bonifacio Day', 'Closed'),
            const KeyValue('25 Dec · Christmas Day', 'Closed'),
            const KeyValue('Local holidays', 'None added'),
            SecondaryButton(
              'Add holiday / local closure',
              onPressed: () => showSinagSnack(context, 'Add a local closure'),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Council session calendar'),
            const KeyValue('17 Nov · Council session', '18:00–21:00'),
            const Tag('APPROVED · COUNCIL WING', color: SinagColors.success),
            SecondaryButton(
              'View approved overtime & events',
              onPressed: () => nav.pushNamed(Routes.overtimeEvents),
            ),
            const MoreDetails(
              children: [
                Note(
                  'Linked to event EVT-1117. Only loads in the approved zone '
                  'and time window are exempt.',
                ),
              ],
            ),
          ],
        ),
        PrimaryButton(
          'Save calendar',
          onPressed: () => showSinagSnack(context, 'Calendar saved'),
        ),
      ],
    );
  }
}
