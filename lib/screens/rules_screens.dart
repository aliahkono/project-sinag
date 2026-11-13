import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';

/// 14 · Alert rules (97:380)
class AlertRulesScreen extends StatefulWidget {
  const AlertRulesScreen({super.key});

  @override
  State<AlertRulesScreen> createState() => _AlertRulesScreenState();
}

class _AlertRulesScreenState extends State<AlertRulesScreen> {
  static const _grace = ['15 min', '30 min', '60 min'];
  int _graceIndex = 1;

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final minutes = _grace[_graceIndex].split(' ').first;
    return SinagPage(
      eyebrow: 'EEC OFFICER ONLY',
      title: 'Alert rules',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Tag('EEC OFFICER ONLY'),
        Panel(
          children: [
            const PanelTitle('Office hours by zone'),
            const KeyValue('Administrative offices', 'Mon–Thu · 08:00–18:00'),
            const KeyValue('Council wing', 'Mon–Thu · 08:00–18:00'),
            const KeyValue('Friday', 'Work from home'),
            SecondaryButton(
              'Edit calendar & zone hours',
              onPressed: () => nav.pushNamed(Routes.workCalendar),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Timing and escalation'),
            OptionChips(
              options: _grace,
              initial: _graceIndex,
              onChanged: (i) => setState(() => _graceIndex = i),
            ),
            Caption(
              '$minutes minutes selected · detection still starts at closing time.',
            ),
            const SinagField(
              label: 'Escalation wait after notification',
              initialValue: '30 minutes',
            ),
            const KeyValue('First notification', 'Facility manager'),
            const KeyValue('Then escalate to', 'EEC Officer + guard'),
            SecondaryButton(
              'Manage role contacts',
              onPressed: () => nav.pushNamed(Routes.sharing),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Standby thresholds'),
            KeyValue('Aircon · above', '0.10 kW'),
            KeyValue('Lighting · above', '0.05 kW'),
            Note(
              'A reading must exceed the appliance-type threshold after the grace period to notify.',
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Allowed to run 24/7'),
            const KeyValue('Server rack · IT-01', 'Exempt'),
            const KeyValue('Security lights · LT-04', 'Exempt'),
            SecondaryButton(
              'Manage always-on loads',
              onPressed: () => nav.pushNamed(Routes.inventory),
            ),
          ],
        ),
        Panel(
          tone: PanelTone.info,
          children: [
            const PanelTitle('Learning mode · OFF'),
            const PanelText(
              'Observe would-be alerts for 2–4 weeks without notifying or escalating.',
            ),
            SecondaryButton(
              'Open learning mode',
              onPressed: () => nav.pushNamed(Routes.learningMode),
            ),
          ],
        ),
        PrimaryButton(
          'Save alert rules',
          onPressed: () => showSinagSnack(context, 'Alert rules saved'),
        ),
        const Note(
          'Approved events override the schedule for their exact zone and time. All rule changes are logged.',
        ),
      ],
    );
  }
}

/// 15 · Work calendar (97:412)
class WorkCalendarScreen extends StatelessWidget {
  const WorkCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'EEC OFFICER ONLY',
      title: 'Work calendar',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
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
            const Note(
              'Linked to event EVT-1117. Only loads in the approved zone and time window are exempt.',
            ),
            SecondaryButton(
              'View approved overtime & events',
              onPressed: () => nav.pushNamed(Routes.overtimeEvents),
            ),
          ],
        ),
        PrimaryButton(
          'Save calendar',
          onPressed: () => showSinagSnack(context, 'Calendar saved'),
        ),
        const Note(
          'After the session ends, the normal grace and escalation rules resume.',
        ),
      ],
    );
  }
}

/// 16 · Overtime & events (97:444)
class OvertimeEventsScreen extends StatelessWidget {
  const OvertimeEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'APPROVED EXCEPTIONS',
      title: 'Overtime & events',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Log before the activity starts'),
            PanelText(
              'Approved time is excluded from alerts and after-hours waste.',
            ),
          ],
        ),
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
            PanelText(
              'Council session · AC-03 and LT-02\nApproval EVT-1117 · Council wing',
              color: SinagColors.text,
            ),
            Note(
              'Alerts resume at 21:00 with a 30-minute grace period. Loads outside this zone are still monitored.',
            ),
          ],
        ),
        const Panel(
          tone: PanelTone.warning,
          children: [
            PanelTitle('Approval is required'),
            PanelText(
              'Unapproved requests do not suppress alerts. An overtime quick reply must be matched to a valid approval record.',
            ),
          ],
        ),
      ],
    );
  }
}
