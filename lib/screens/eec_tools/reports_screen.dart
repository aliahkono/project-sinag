import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 19 · Reports — Figma frame 97:540
///
/// EEC Officer prepares the monthly MECR export for GEMP, and tracks EECP /
/// LEECP status, alert-log exports and deadlines. How exports relate to GEMP
/// is in the ⓘ.
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    void exported(String what) => showSinagSnack(context, '$what exported');
    return SinagPage(
      eyebrow: 'EEC OFFICER · EXPORTS',
      title: 'Reports',
      bottomBar: const SinagBottomNav(current: SinagTab.reports),
      about: const [
        'Export here, submit in GEMP: the EEC Officer submits through the '
            'GEMP Online System. SINAG does not submit to DOE.',
        'Exports need internet.',
        'Drafts keep their incomplete flags. Don’t present held or estimated '
            'readings as measured data.',
      ],
      children: [
        Panel(
          children: [
            const PanelTitle('MECR-ready monthly data'),
            const Tag(
              'INCOMPLETE · 1 BILL / METER REVIEW',
              color: SinagColors.warning,
            ),
            PrimaryButton(
              'Review data before final export',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
            SecondaryButton(
              'Export draft CSV · incomplete',
              onPressed: () => exported('Draft CSV'),
            ),
            const MoreDetails(
              children: [
                PanelText('October 2026 · Building A'),
                KeyValue('Consumption · Measured', '14,250 kWh'),
                KeyValue('Bill amount · Measured', '₱110,571.50'),
              ],
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Next deadline'),
            KeyValue('Monthly MECR', '15 Nov 2026'),
            MoreDetails(
              label: 'See all deadlines',
              children: [
                KeyValue('January inventory', 'January 2027'),
                KeyValue('LEECP', 'June 2027'),
                Caption('Reminders on · 3 days before each deadline'),
              ],
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('EECP / LEECP status'),
            const KeyValue('EECP', 'Active · updated 01 Jul'),
            const KeyValue('LEECP', 'Draft · due June 2027'),
            SecondaryButton(
              'Export status table',
              onPressed: () => exported('Status table'),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Alert log & evidence'),
            SecondaryButton(
              'Export alert log · CSV',
              onPressed: () => exported('Alert log'),
            ),
            const MoreDetails(
              label: 'What’s included',
              children: [
                PanelText(
                  'Timing steps, quick replies, approvals, closure notes and '
                  'late-detection flags.',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
