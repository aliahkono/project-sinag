import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';

/// 19 · Reports (97:540)
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
      children: [
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Export here. Submit in GEMP.'),
            PanelText(
              'The EEC Officer submits through the GEMP Online System. SINAG does not submit to DOE.',
            ),
            Tag('INTERNET REQUIRED FOR EXPORTS'),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('MECR-ready monthly data'),
            const PanelText('October 2026 · Building A'),
            const Tag(
              'INCOMPLETE · 1 BILL / METER REVIEW',
              color: SinagColors.warning,
            ),
            const KeyValue('Consumption · Measured', '14,250 kWh'),
            const KeyValue('Bill amount · Measured', '₱110,571.50'),
            PrimaryButton(
              'Review data before final export',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
            SecondaryButton(
              'Export draft CSV · incomplete',
              onPressed: () => exported('Draft CSV'),
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
            const PanelText(
              'Includes timing steps, quick replies, approvals, closure notes and late-detection flags.',
            ),
            SecondaryButton(
              'Export alert log · CSV',
              onPressed: () => exported('Alert log'),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Upcoming deadlines'),
            KeyValue('Monthly MECR', '15 Nov 2026'),
            KeyValue('January inventory', 'January 2027'),
            KeyValue('LEECP', 'June 2027'),
            Caption('Reminders on · 3 days before each deadline'),
          ],
        ),
        const Note(
          'Drafts retain incomplete flags. Do not present held or estimated readings as measured data.',
        ),
      ],
    );
  }
}

/// 20 · Meters (97:573)
class MetersScreen extends StatelessWidget {
  const MetersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'DATA HEALTH',
      title: 'Meters',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Tag('BUILDING A · TIER 3'),
        const Panel(
          children: [
            PanelTitle('Main meter · MA-01'),
            PanelText('Building A · online'),
            Tag('ONLINE · LAST SEEN 09:40', color: SinagColors.success),
            KeyValue('Current load · Measured', '7.8 kW'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('AC-04 meter'),
            PanelText('Building A · storing readings locally'),
            Tag('OFFLINE · BUFFERING', color: SinagColors.warning),
            KeyValue('Last contact', '11 Nov · 14:10'),
            Note(
              'Approximately 7 days of local storage. Readings sync when the connection returns.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-02 meter'),
            PanelText('Building A · reconnected at 07:45'),
            Tag('ONLINE · BACKFILL RECEIVED', color: SinagColors.success),
            Note(
              'Overnight records are marked late detection. Original measurement times are preserved.',
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Building B · main meter MB-01'),
            const PanelText('Tier 2 · failed since 10 Nov'),
            const Tag(
              'FAILED · NOVEMBER BILL-ONLY MODE',
              color: SinagColors.dangerText,
            ),
            SecondaryButton(
              'Report / view meter fault',
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.reportMeterFault),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Building monitoring tiers'),
            KeyValue('Tier 1', 'Bills only'),
            KeyValue('Tier 2', 'Main meter + bills'),
            KeyValue('Tier 3', 'Appliance meters + main + bills'),
          ],
        ),
        const Note(
          'Failed meter months fall back to bill-only reporting. No live savings claim is made from missing readings.',
        ),
      ],
    );
  }
}

/// 21 · Report meter fault (97:605)
class ReportMeterFaultScreen extends StatelessWidget {
  const ReportMeterFaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'DATA HEALTH',
      title: 'Report meter fault',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
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
            PanelTitle('Reporting impact'),
            PanelText(
              'Building B falls back to bill-only mode for November 2026.',
            ),
            PanelText(
              'Meter gaps remain visible. Inventory estimates, if shown, are labeled Estimated and are not treated as measured savings.',
              color: SinagColors.text,
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
        const Note(
          'This records a maintenance issue. It does not operate, reset or switch equipment remotely.',
        ),
      ],
    );
  }
}

/// 22 · Data review queue (97:637)
class DataReviewScreen extends StatelessWidget {
  const DataReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'EEC OFFICER · QUALITY',
      title: 'Data review queue',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: const [
        Tag('4 HELD ITEMS · 2 INCOMPLETE MONTHS', color: SinagColors.warning),
        PanelText(
          'EEC Officer approval is required. Rejected values stay in the audit trail and are excluded from calculations.',
        ),
        Panel(
          children: [
            PanelTitle('October · bill / meter mismatch'),
            PanelText('14,250 kWh bill vs 13,728 kWh main meter'),
            Tag(
              '3.8% DIFFERENCE · OVER 3% LIMIT',
              color: SinagColors.dangerText,
            ),
            Note(
              'Compare source dates and OCR fields. October remains incomplete until reconciled.',
            ),
            _Decision(),
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
            Note(
              'Backfill not yet available. Accept an explained gap or reject the record; do not invent measurements.',
            ),
            _Decision(),
          ],
        ),
        SinagField(
          label: 'Decision note · required',
          initialValue: 'Record evidence before approving or rejecting.',
          multiline: true,
        ),
        Note(
          'Each decision stores the role, time, source values and reason. Monthly completeness is rechecked after all items are resolved.',
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

/// 23 · Learning mode (97:669)
class LearningModeScreen extends StatefulWidget {
  const LearningModeScreen({super.key});

  @override
  State<LearningModeScreen> createState() => _LearningModeScreenState();
}

class _LearningModeScreenState extends State<LearningModeScreen> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'EEC OFFICER · CALIBRATION',
      title: 'Learning mode',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        Panel(
          tone: PanelTone.info,
          children: [
            const PanelTitle('Learning mode'),
            PanelText(
              _enabled
                  ? 'Observing · notifications paused'
                  : 'Preview state · ready to enable',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('Enable learning mode', style: SinagText.button),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => setState(() => _enabled = !_enabled),
                  child: _enabled
                      ? const _ToggleOn()
                      : SvgPicture.asset(
                          'assets/images/toggle_off.svg',
                          width: 48,
                          height: 28,
                        ),
                ),
              ],
            ),
            Note(
              _enabled
                  ? 'ON · Observing 16 Nov–06 Dec 2026'
                  : 'OFF · No current observation session',
              strong: true,
              color: SinagColors.muted,
            ),
          ],
        ),
        const SinagField(
          label: 'Observation window',
          initialValue: '2 weeks   [3 weeks]   4 weeks',
        ),
        const SinagField(
          label: 'Planned dates',
          initialValue: '16 Nov–06 Dec 2026 · 3 weeks',
        ),
        const Panel(
          children: [
            PanelTitle('When enabled'),
            PanelText(
              'Meter readings continue, but no push, SMS or escalation is sent. The log records the alerts that would have fired.',
            ),
          ],
        ),
        PrimaryButton(
          'Start 3-week learning period',
          onPressed: () {
            setState(() => _enabled = true);
            showSinagSnack(context, 'Learning period started');
          },
        ),
        Panel(
          children: [
            const PanelTitle('Previous observation log'),
            const PanelText('19 Oct–01 Nov · completed'),
            const KeyValue('22 Oct · AC-03', 'Would notify 18:30'),
            const Note('2.4 kW · aircon threshold 0.10 kW'),
            const KeyValue('26 Oct · LT-02', 'Would escalate 19:00'),
            const Note('0.9 kW · no overtime record'),
            const KeyValue('29 Oct · IT-01', 'Suppressed · 24/7 load'),
            SecondaryButton(
              'Review thresholds',
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.alertRules),
            ),
          ],
        ),
        const Note(
          'At the end of the window, review rules before enabling live notifications.',
        ),
      ],
    );
  }
}

/// "On" counterpart of the Figma toggle asset (same 48×28 geometry).
class _ToggleOn extends StatelessWidget {
  const _ToggleOn();

  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 28,
    padding: const EdgeInsets.all(3),
    alignment: Alignment.centerRight,
    decoration: BoxDecoration(
      color: SinagColors.navy,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    ),
  );
}
