import 'package:flutter/material.dart';

import '../../widgets/sinag_widgets.dart';

/// 26 · Operating changes — Figma frame 97:765
///
/// Log changes to floor area, offices, equipment or hours so the baseline
/// stays comparable. Why this matters is in the ⓘ.
class OperatingChangesScreen extends StatelessWidget {
  const OperatingChangesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'BASELINE ADJUSTMENTS',
      title: 'Operating changes',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'Log changes to floor area, offices, equipment or hours so this '
            'year can still be compared fairly with the baseline.',
        'Approved changes adjust the baseline; schedule effects stay '
            'separate. Pending changes don’t alter reported savings.',
        'Previous baseline versions stay in the activity log.',
      ],
      children: [
        const SinagField(label: 'Change category', initialValue: 'Equipment'),
        const SinagField(label: 'Effective date', initialValue: '01 Dec 2026'),
        const SinagField(
          label: 'Before → after',
          initialValue: 'AC-05 · 2,400 W unit → 1,800 W inverter',
        ),
        const SinagField(
          label: 'Reason / evidence',
          initialValue:
              'Approved equipment replacement · purchase reference PR-1201',
          multiline: true,
        ),
        const SinagField(
          label: 'Approver',
          initialValue: 'Department head · approval pending',
        ),
        PrimaryButton(
          'Save change for approval',
          onPressed: () => showSinagSnack(context, 'Change saved for approval'),
        ),
        const Panel(
          children: [
            PanelTitle('Approved changes'),
            KeyValue('01 Jul · floor area', '2,400 → 2,600 m²'),
            KeyValue('01 Sep · office hours', '08:00–17:00 → 18:00'),
            MoreDetails(
              children: [
                Note(
                  'Floor area: new records office · approved by department '
                  'head · reference OC-0701.',
                ),
                Note(
                  'Office hours: approved by EEC Officer · reference OC-0901.',
                ),
                Tag('BASELINE VERSION 3 · COMPUTED'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
