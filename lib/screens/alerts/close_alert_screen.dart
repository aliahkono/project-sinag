import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 13 · Close alert — Figma frame 97:348
///
/// Record what was done about an alert (action, time, what was checked,
/// evidence) before closing it.
class CloseAlertScreen extends StatelessWidget {
  const CloseAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'AFTER-HOURS · EVIDENCE',
      title: 'Close alert',
      bottomBar: const SharedBottomBar(section: Routes.alerts),
      about: const [
        'Acknowledging an alert is not closing it. Record what happened so '
            'the EEC Officer can verify it later.',
        'This record, its timestamps and the meter trace stay in the alert '
            'log for spot checks.',
      ],
      children: [
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Record what was done'),
            PanelText('AC-03 · Alert A-1126-03 · 11 Nov'),
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
          initialValue:
              'Council office was empty. Guard checked the room and switched '
              'the aircon off. Load returned to 0.03 kW standby.',
          multiline: true,
        ),
        Panel(
          children: [
            const PanelTitle('Evidence'),
            SecondaryButton(
              'Attach photo or inspection note',
              onPressed: () => showSinagSnack(context, 'Opening camera…'),
            ),
            const Caption('Photograph equipment only, not people.'),
            const MoreDetails(
              children: [
                KeyValue('Meter trace', 'Attached automatically'),
                KeyValue('Action reference', 'FM-1126-03'),
                PanelText(
                  'Closure outcome: confirmed avoidable load · 4.8 kWh / '
                  '₱52.80 computed waste. No overtime approval was found.',
                ),
              ],
            ),
          ],
        ),
        PrimaryButton(
          'Save action & close alert',
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(Routes.resolvedAlerts),
        ),
      ],
    );
  }
}
