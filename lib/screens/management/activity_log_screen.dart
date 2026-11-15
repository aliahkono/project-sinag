import 'package:flutter/material.dart';

import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 28 · Activity log — Figma frame 97:829
///
/// Audit trail of views, changes and exports, by account. Each entry shows
/// who did what; record numbers are under "See details".
class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'ACCESS & AUDIT',
      title: 'Activity log',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'A building-level audit trail: account role, action and time. No '
            'employee or resident profile data is kept.',
        'Entries cannot be edited from this screen. Exporting needs '
            'internet.',
      ],
      children: [
        SecondaryButton(
          'All activity  ·  Views  ·  Edits  ·  Exports',
          onPressed: () => showSinagSnack(context, 'Showing all activity'),
        ),
        const Panel(
          children: [
            PanelTitle('12 Nov · 09:32 · Viewed'),
            Tag('MAYOR OFFICE · ACCOUNT MAYOR-01'),
            PanelText(
              'Opened Building A’s summary and rankings.',
              color: SinagColors.text,
            ),
            MoreDetails(
              children: [
                PanelText(
                  'Opened Building A’s read-only summary and building '
                  'rankings.',
                ),
                KeyValue('Access policy', 'SHARE-1126'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('12 Nov · 09:10 · Changed'),
            Tag('EEC OFFICER · ACCOUNT EEC-01'),
            PanelText(
              'Gave DOE / DILG access to Building A.',
              color: SinagColors.text,
            ),
            MoreDetails(
              children: [
                PanelText(
                  'Granted DOE / DILG summary access to Building A until 31 '
                  'Dec 2026.',
                ),
                KeyValue('Record', 'SHARE-1126'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('12 Nov · 08:45 · Exported'),
            Tag('EEC OFFICER · ACCOUNT EEC-01'),
            PanelText(
              'Exported the after-hours alert log.',
              color: SinagColors.text,
            ),
            MoreDetails(
              children: [
                PanelText(
                  'Exported the after-hours alert log with closure notes. '
                  'CSV · November 2026.',
                ),
                KeyValue('Export reference', 'EXP-1126-04'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('11 Nov · 19:10 · Acknowledged'),
            Tag('FACILITY MANAGER · ACCOUNT FM-01'),
            PanelText(
              'Replied “I’ll check it” to alert A-1126-03 by SMS.',
              color: SinagColors.text,
            ),
            MoreDetails(children: [PanelText('Action record still required.')]),
          ],
        ),
        SecondaryButton(
          'Export activity log',
          onPressed: () => showSinagSnack(context, 'Activity log exported'),
        ),
      ],
    );
  }
}
