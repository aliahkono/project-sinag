import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 10 · Notify — Figma frame 97:270
///
/// The push + SMS message sent when a unit is left running after hours, with
/// its quick replies (I'll check it / approved overtime / meter error).
/// Opened from the bell in the top bar.
class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'AFTER-HOURS · DELIVERY',
      title: 'Notify',
      about: const [
        'Sent by push and SMS when equipment keeps running 30 minutes after '
            'office hours end.',
        'If nobody responds, the facility manager is notified first. After a '
            '30-minute wait it escalates to the EEC Officer and the guard.',
        'Overtime replies need approval details before the energy is '
            'excluded from waste.',
      ],
      children: [
        const Tag('PUSH + SMS · 11 NOV, 18:30'),
        Panel(
          tone: PanelTone.danger,
          children: [
            const PanelTitle('SINAG · Unit left running'),
            const PanelText('AC-03 · Council office, 2nd floor'),
            Text('2.4 kW · ₱26.40 / hour', style: SinagText.alertFigure),
            const PanelText(
              'Office hours ended at 18:00.',
              color: SinagColors.text,
            ),
            PrimaryButton(
              'I’ll check it',
              onPressed: () => nav.pushNamed(Routes.alertDetail),
            ),
            SecondaryButton(
              'Approved overtime',
              onPressed: () => nav.pushNamed(Routes.overtimeEvents),
            ),
            SecondaryButton(
              'Report meter error',
              onPressed: () => nav.pushNamed(Routes.reportMeterFault),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Also sent by SMS'),
            Tag('REPLIES WORK WITHOUT MOBILE DATA'),
            MoreDetails(
              label: 'See the message',
              children: [
                PanelText(
                  'SINAG: AC-03, Council office 2F is using 2.4 kW '
                  '(₱26.40/hr) after hours. Reply 1 CHECK, 2 OVERTIME, or '
                  '3 METER ERROR. Ref A-1126-03.',
                ),
                Note(
                  'Measured load · Computed cost at ₱11/kWh. The 30-minute '
                  'grace period has elapsed.',
                ),
              ],
            ),
          ],
        ),
        SecondaryButton(
          'Open full alert',
          onPressed: () => nav.pushNamed(Routes.alertDetail),
        ),
      ],
    );
  }
}
