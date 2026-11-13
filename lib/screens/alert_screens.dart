import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';

/// 10 · Notify (97:270)
class NotifyScreen extends StatelessWidget {
  const NotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'AFTER-HOURS · DELIVERY',
      title: 'Notify',
      children: [
        const Tag('PUSH + SMS · 11 NOV, 18:30'),
        Panel(
          tone: PanelTone.danger,
          children: [
            const PanelTitle('SINAG · Unit left running'),
            const PanelText('AC-03 · Council office, 2nd floor'),
            Text('2.4 kW · ₱26.40 / hour', style: SinagText.alertFigure),
            const PanelText(
              'Measured load · Computed cost at ₱11/kWh. Office hours ended at 18:00; the 30-minute grace period has elapsed.',
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
            PanelTitle('SMS delivery'),
            PanelText(
              'SINAG: AC-03, Council office 2F is using 2.4 kW (₱26.40/hr) after hours. Reply 1 CHECK, 2 OVERTIME, or 3 METER ERROR. Ref A-1126-03.',
            ),
            Tag('SMS REPLIES WORK WITHOUT MOBILE DATA'),
            Note(
              'Overtime replies require approval details before the energy is excluded from waste.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('If nobody responds'),
            PanelText(
              'Notify facility manager first. After a 30-minute wait, escalate to the EEC Officer and guard.',
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

const _alertTabs = [
  ('Open (2)', Routes.alerts),
  ('Resolved (8)', Routes.resolvedAlerts),
];

/// 11 · Alerts (97:284)
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'AFTER-HOURS · OPEN',
      title: 'Alerts',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const PageTabs(tabs: _alertTabs, selected: 0),
        Panel(
          tone: PanelTone.navy,
          children: [
            const PanelTitle('This week’s after-hours waste'),
            const PanelText('Computed · confirmed unapproved consumption'),
            Text(
              '32.4 kWh  ·  ₱356.40',
              style: SinagText.mediumNumber.copyWith(
                fontSize: 23,
                height: 33 / 23,
              ),
            ),
            const Caption('09–15 Nov · excludes approved events'),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const PanelText('11 Nov · detected 18:00 · notified 18:30'),
            const Tag(
              'ACKNOWLEDGED · AWAITING ACTION RECORD',
              color: SinagColors.warning,
            ),
            const KeyValue('Measured load', '2.4 kW · ₱26.40/hr¹'),
            const KeyValue('Waste so far · Computed', '4.8 kWh · ₱52.80'),
            PrimaryButton(
              'Investigate AC-03',
              onPressed: () => nav.pushNamed(Routes.alertDetail),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('LT-02 · East wing lighting'),
            const PanelText('11 Nov · readings received 12 Nov at 07:45'),
            const Tag(
              'LATE DETECTION · METER WAS OFFLINE',
              color: SinagColors.dangerText,
            ),
            const KeyValue('Recorded overnight load', '0.9 kW · ₱9.90/hr¹'),
            SecondaryButton(
              'Review late detection',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
          ],
        ),
        SecondaryButton(
          'Log approved overtime / event',
          onPressed: () => nav.pushNamed(Routes.overtimeEvents),
        ),
        const Caption(
          '¹ Hourly cost is computed at ₱11/kWh.\nUpdated 08:00 · EEC morning summary available.',
        ),
      ],
    );
  }
}

/// 12 · Alert detail (97:316)
class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key});

  static const _overnight = <double>[
    86.4, 86.4, 3.24, 3, 3, 3, 3, 3, 3, 3, 3, 3, //
  ];
  static const _colors = <Color>[
    SinagColors.dangerText, SinagColors.dangerText, //
    SinagColors.navy, SinagColors.navy, SinagColors.navy, SinagColors.navy,
    SinagColors.navy, SinagColors.navy, SinagColors.navy, SinagColors.navy,
    SinagColors.navy, SinagColors.navy,
  ];

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'AFTER-HOURS · INVESTIGATE',
      title: 'Alert detail',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const PanelText('Alert A-1126-03 · 11 November'),
            const Tag(
              'ACKNOWLEDGED · ACTION RECORD NEEDED',
              color: SinagColors.warning,
            ),
            Text(
              '4.8 kWh  /  ₱52.80',
              style: SinagText.alertFigure.copyWith(
                fontSize: 24,
                height: 35 / 24,
              ),
            ),
            const Note(
              'Computed waste · 18:00–20:00\nMeasured load 2.4 kW · cost at ₱11/kWh',
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Caption('kW · overnight · Measured'),
                SizedBox(height: 5),
                LoadBarChart(
                  barHeights: _overnight,
                  barColors: _colors,
                  shadeFrom: 0,
                  shadeTo: 12,
                  shadeColor: SinagColors.tintDanger,
                ),
                SizedBox(height: 5),
                KeyValue('18:00       22:00', '02:00       06:00'),
                SizedBox(height: 5),
                Caption('Red = after-hours load; 2.4 kW until 20:00.'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('What happened, and when'),
            TimelineRow('18:00', 'Detected above 0.10 kW after office hours'),
            TimelineRow('18:00–18:30', 'Grace period · 30 minutes'),
            TimelineRow('18:30', 'Push + SMS to facility manager'),
            TimelineRow('19:00', 'Escalated to EEC Officer + guard'),
            TimelineRow('19:10', 'Acknowledged · “I’ll check it”'),
            TimelineRow(
              '20:00',
              'Load fell to standby · action not yet recorded',
            ),
          ],
        ),
        PrimaryButton(
          'Record action & close',
          onPressed: () => nav.pushNamed(Routes.closeAlert),
        ),
        SecondaryButton(
          'Approved overtime',
          onPressed: () => nav.pushNamed(Routes.overtimeEvents),
        ),
        SecondaryButton(
          'Report meter error',
          onPressed: () => nav.pushNamed(Routes.reportMeterFault),
        ),
        const Note(
          'Energy is only excluded as overtime with an approval record. Closing stores evidence for spot checks.',
        ),
      ],
    );
  }
}

/// 13 · Close alert (97:348)
class CloseAlertScreen extends StatelessWidget {
  const CloseAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'AFTER-HOURS · EVIDENCE',
      title: 'Close alert',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Complete the evidence record'),
            PanelText('AC-03 · Alert A-1126-03 · 11 Nov'),
            PanelText(
              'Acknowledging is not closing. Record what happened so the EEC Officer can verify it later.',
              color: SinagColors.text,
            ),
          ],
        ),
        const SinagField(
          label: 'Action taken',
          initialValue: 'Unit manually switched off',
        ),
        const SinagField(
          label: 'Action time',
          initialValue: '11 Nov 2026 · 20:00',
        ),
        const SinagField(
          label: 'Recorded by role',
          initialValue: 'Facility manager',
        ),
        const SinagField(
          label: 'What was checked',
          initialValue: 'Council office was empty. Guard checked the room and switched the aircon off. Load returned to 0.03 kW standby.',
          multiline: true,
        ),
        Panel(
          children: [
            const PanelTitle('Supporting evidence'),
            const KeyValue('Meter trace', 'Attached automatically'),
            const KeyValue('Action reference', 'FM-1126-03'),
            SecondaryButton(
              'Attach photo or inspection note',
              onPressed: () => showSinagSnack(context, 'Opening camera…'),
            ),
            const Caption(
              'Only photograph equipment. Do not include employees or residents.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Closure outcome'),
            PanelText(
              'Confirmed avoidable load · 4.8 kWh / ₱52.80 computed waste. No overtime approval was found.',
            ),
          ],
        ),
        PrimaryButton(
          'Save action & close alert',
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(Routes.resolvedAlerts),
        ),
        const Note(
          'This record, timestamps and meter trace stay in the alert log for spot checks.',
        ),
      ],
    );
  }
}

/// 31 · Resolved alerts (97:889)
class ResolvedAlertsScreen extends StatelessWidget {
  const ResolvedAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'AFTER-HOURS · EVIDENCE',
      title: 'Resolved alerts',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const PageTabs(tabs: _alertTabs, selected: 1),
        const Panel(
          tone: PanelTone.success,
          children: [
            PanelTitle('Resolved with evidence'),
            PanelText(
              'Resolution means an action or approved exception is recorded.',
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const PanelText('07 Nov · closed 20:15'),
            const Tag(
              'RESOLVED · MANUAL SWITCH-OFF',
              color: SinagColors.success,
            ),
            const KeyValue('Waste · Computed', '3.6 kWh / ₱39.60'),
            const PanelText(
              'Facility manager: guard checked the empty office and switched off the unit. Meter trace confirmed standby.',
              color: SinagColors.text,
            ),
            const KeyValue('Evidence record', 'FM-1107-02'),
            SecondaryButton(
              'View saved action record',
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.activityLog),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('AC-03 · Council office'),
            PanelText('03 Nov · approved overtime'),
            Tag('RESOLVED · APPROVED EXCEPTION'),
            PanelText(
              'Session approval EVT-1103 matched 18:00–21:00. Approved energy excluded from waste.',
              color: SinagColors.text,
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-01 · Treasury lighting'),
            PanelText('02 Nov · meter error'),
            Tag('RESOLVED · INVALID DATA EXCLUDED', color: SinagColors.warning),
            PanelText(
              'Fault verified by the EEC Officer. Reading rejected and maintenance reference linked.',
              color: SinagColors.text,
            ),
          ],
        ),
        const Note(
          'Showing 3 of 8 resolved alerts. Detection, grace, notification, escalation and acknowledgment times remain in every record.',
        ),
      ],
    );
  }
}
