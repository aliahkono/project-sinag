import 'package:flutter/material.dart';

import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 22 · Data review queue — Figma frame 97:637
///
/// EEC Officer approves or rejects held readings (bill / meter mismatch,
/// spikes, negative readings, gaps).
class DataReviewScreen extends StatelessWidget {
  const DataReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'EEC OFFICER · QUALITY',
      title: 'Data review queue',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'Readings that look wrong are held here until the EEC Officer '
            'approves or rejects them.',
        'Rejected values stay in the audit trail and are excluded from '
            'calculations.',
        'Each decision stores the role, time, source values and reason. '
            'Monthly completeness is rechecked after all items are resolved.',
      ],
      children: const [
        Tag('4 HELD ITEMS · 2 INCOMPLETE MONTHS', color: SinagColors.warning),
        Panel(
          children: [
            PanelTitle('October · bill / meter mismatch'),
            Tag(
              '3.8% DIFFERENCE · OVER 3% LIMIT',
              color: SinagColors.dangerText,
            ),
            _Decision(),
            MoreDetails(
              children: [
                PanelText('14,250 kWh bill vs 13,728 kWh main meter'),
                Note(
                  'Compare source dates and OCR fields. October remains '
                  'incomplete until reconciled.',
                ),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            PanelTitle('November · spike'),
            PanelText('AC-03 · 11 Nov at 16:20'),
            KeyValue('Measured value', '18.2 kW'),
            KeyValue('Prior reading', '2.4 kW'),
            _Decision(),
          ],
        ),
        Panel(
          children: [
            PanelTitle('November · negative reading'),
            PanelText('AC-01 · 11 Nov at 17:10'),
            KeyValue('Held energy value', '−1.2 kWh'),
            _Decision(),
          ],
        ),
        Panel(
          children: [
            PanelTitle('November · reading gap'),
            PanelText('Main meter · 11 Nov, 02:00–05:00'),
            Tag('3 HOURS · OVER 2-HOUR LIMIT', color: SinagColors.warning),
            _Decision(),
            MoreDetails(
              children: [
                Note(
                  'Backfill not yet available. Accept an explained gap or '
                  'reject the record; do not invent measurements.',
                ),
              ],
            ),
          ],
        ),
        SinagField(
          label: 'Decision note · required',
          initialValue: 'Record evidence before approving or rejecting.',
          multiline: true,
        ),
      ],
    );
  }
}

/// Approve / Reject pair. Once a decision is made it is shown as a status
/// label (the record stays in the audit trail).
class _Decision extends StatefulWidget {
  const _Decision();

  @override
  State<_Decision> createState() => _DecisionState();
}

class _DecisionState extends State<_Decision> {
  bool? _approved;

  @override
  Widget build(BuildContext context) {
    if (_approved != null) {
      return Row(
        children: [
          Expanded(
            child: Tag(
              _approved!
                  ? 'APPROVED · DECISION RECORDED'
                  : 'REJECTED · EXCLUDED FROM CALCULATIONS',
              color: _approved! ? SinagColors.success : SinagColors.dangerText,
            ),
          ),
          TextLink(
            'Undo',
            small: true,
            onTap: () => setState(() => _approved = null),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            'Approve',
            onPressed: () => setState(() => _approved = true),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SecondaryButton(
            'Reject',
            onPressed: () => setState(() => _approved = false),
          ),
        ),
      ],
    );
  }
}
