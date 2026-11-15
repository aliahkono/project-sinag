import 'package:flutter/material.dart';

import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 21 · Report meter fault — Figma frame 97:605
///
/// Report a failed meter to the EEC Officer; the building falls back to
/// bill-only reporting for that month.
class ReportMeterFaultScreen extends StatelessWidget {
  const ReportMeterFaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'DATA HEALTH',
      title: 'Report meter fault',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'This records a maintenance issue for the EEC Officer. It does not '
            'operate, reset or switch equipment remotely.',
      ],
      children: [
        const Tag(
          'BUILDING B · MAIN METER MB-01',
          color: SinagColors.dangerText,
        ),
        const SinagField(
          label: 'Fault type',
          initialValue: 'No readings · failed meter',
        ),
        const SinagField(
          label: 'Issue first noticed',
          initialValue: '10 Nov 2026 · 14:00',
        ),
        const SinagField(
          label: 'Checks performed',
          initialValue: 'Power and connection checked. Meter display is unresponsive. No local readings can be recovered.',
          multiline: true,
        ),
        const SinagField(
          label: 'Reported by',
          initialValue: 'Facility manager · Building B',
        ),
        const Panel(
          tone: PanelTone.warning,
          children: [
            PanelTitle('Building B will use bills only for November'),
            MoreDetails(
              children: [
                PanelText(
                  'Building B falls back to bill-only mode for November 2026.',
                ),
                PanelText(
                  'Meter gaps remain visible. Inventory estimates, if shown, '
                  'are labeled Estimated and are not treated as measured '
                  'savings.',
                  color: SinagColors.text,
                ),
              ],
            ),
          ],
        ),
        PrimaryButton(
          'Report fault to EEC Officer',
          onPressed: () =>
              showSinagSnack(context, 'Fault reported to the EEC Officer'),
        ),
        SecondaryButton(
          'Attach equipment photo',
          onPressed: () => showSinagSnack(context, 'Opening camera…'),
        ),
      ],
    );
  }
}
