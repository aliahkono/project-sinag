import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../widgets/sinag_widgets.dart';

/// 14 · Alert rules — Figma frame 97:380
///
/// EEC Officer sets office hours per zone, the grace period and escalation,
/// standby thresholds and loads allowed to run 24/7.
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
      about: const [
        'These rules decide when equipment counts as left running after '
            'hours, and who is told.',
        'Approved events override the schedule for their exact zone and '
            'time. All rule changes are logged.',
        'A reading must stay above the appliance’s standby threshold after '
            'the grace period before anyone is notified.',
      ],
      children: [
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
            const PanelTitle('Wait before alerting'),
            OptionChips(
              options: _grace,
              initial: _graceIndex,
              onChanged: (i) => setState(() => _graceIndex = i),
            ),
            Caption('$minutes minutes after closing time.'),
            const KeyValue('First told', 'Facility manager'),
            MoreDetails(
              label: 'See escalation',
              children: [
                const Caption(
                  'Grace period: detection still starts at closing time.',
                ),
                const SinagField(
                  label: 'Escalation wait after notification',
                  initialValue: '30 minutes',
                ),
                const KeyValue('Then escalate to', 'EEC Officer + guard'),
                SecondaryButton(
                  'Manage role contacts',
                  onPressed: () => nav.pushNamed(Routes.sharing),
                ),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Standby thresholds'),
            KeyValue('Aircon · above', '0.10 kW'),
            KeyValue('Lighting · above', '0.05 kW'),
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
            const PanelText('Try the rules for 2–4 weeks without alerting.'),
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
      ],
    );
  }
}
