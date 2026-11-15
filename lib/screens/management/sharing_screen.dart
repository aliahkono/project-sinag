import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// Labelled on/off switch row using the Figma switch artwork (44×26).
class _SwitchRow extends StatefulWidget {
  const _SwitchRow(this.label, {this.initial = false});
  final String label;
  final bool initial;

  @override
  State<_SwitchRow> createState() => _SwitchRowState();
}

class _SwitchRowState extends State<_SwitchRow> {
  late bool _on = widget.initial;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(widget.label, style: SinagText.link)),
        const SizedBox(width: 12),
        Semantics(
          toggled: _on,
          label: widget.label,
          child: GestureDetector(
            onTap: () => setState(() => _on = !_on),
            child: SvgPicture.asset(
              _on
                  ? 'assets/images/switch_on.svg'
                  : 'assets/images/switch_off.svg',
              width: 44,
              height: 26,
            ),
          ),
        ),
      ],
    );
  }
}

/// 27 · Sharing — Figma frame 97:797
///
/// EEC Officer controls what the mayor / department head and DOE / DILG are
/// allowed to see.
class SharingScreen extends StatelessWidget {
  const SharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'EEC OFFICER · ACCESS',
      title: 'Sharing',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'The LGU controls who outside the EEC team can see SINAG data.',
        'The Mayor / department head view is read-only: no bill images, '
            'appliance controls, rule editing or report submission.',
        'Nothing is shared with DOE / DILG outside the approved scope: no raw '
            'bills, action evidence or account-level activity.',
        'Revoking access takes effect on the next online check. Every view, '
            'change and export is logged.',
      ],
      children: [
        const Tag('EEC OFFICER · LGU CONTROLLED'),
        const Panel(
          children: [
            PanelTitle('Mayor / department head'),
            _SwitchRow('Summary & building rankings', initial: true),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('DOE / DILG'),
            _SwitchRow('Allow external read-only access', initial: true),
            PanelText('Building A only · until 31 Dec 2026'),
            MoreDetails(
              children: [
                KeyValue('LGU approval', 'SHARE-1126'),
                KeyValue('Permitted building', 'Building A only'),
                KeyValue('Allowed content', 'Summary + rankings'),
                KeyValue('Access expires', '31 Dec 2026'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('What can be shared'),
            _SwitchRow('Energy totals & savings labels', initial: true),
            _SwitchRow('Building rankings', initial: true),
            _SwitchRow('Raw bill images'),
            _SwitchRow('Detailed alert action records'),
          ],
        ),
        PrimaryButton(
          'Save sharing permissions',
          onPressed: () => showSinagSnack(context, 'Sharing permissions saved'),
        ),
        SecondaryButton(
          'View activity log',
          onPressed: () => Navigator.of(context).pushNamed(Routes.activityLog),
        ),
      ],
    );
  }
}
