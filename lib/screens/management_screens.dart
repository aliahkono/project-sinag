import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';

/// 24 · Morning summary (97:701)
class MorningSummaryScreen extends StatelessWidget {
  const MorningSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'EEC OFFICER · 8:00 AM',
      title: 'Morning summary',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Tag('DELIVERED AT 08:00 · 12 NOV 2026'),
        Panel(
          tone: PanelTone.navy,
          children: [
            const PanelTitle('Your overnight summary'),
            const PanelText('Building A · EEC Officer'),
            Text(
              '2 alerts need follow-up',
              style: SinagText.mediumNumber.copyWith(
                fontSize: 23,
                height: 33 / 23,
              ),
            ),
            const Caption('Computed from latest synced meter records'),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('AC-03 · Council office'),
            const PanelText('Detected 18:00 · notified 18:30 · 11 Nov'),
            const Tag(
              'ACKNOWLEDGED · ACTION RECORD MISSING',
              color: SinagColors.warning,
            ),
            const KeyValue('Waste · Computed', '4.8 kWh / ₱52.80'),
            SecondaryButton(
              'Finish action record',
              onPressed: () => nav.pushNamed(Routes.closeAlert),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('LT-02 · East wing lighting'),
            const PanelText('Measured 11 Nov, 18:00–20:00'),
            const Tag('LATE DETECTION', color: SinagColors.dangerText),
            const KeyValue('Readings arrived', '12 Nov · 07:45'),
            const KeyValue('Waste · Computed', '1.8 kWh / ₱19.80'),
            const Note(
              'Meter was offline. These readings were not available for a real-time alert.',
            ),
            SecondaryButton(
              'Review late detection',
              onPressed: () => nav.pushNamed(Routes.meters),
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Data needing attention'),
            const KeyValue('Held readings / bill checks', '4 items'),
            const KeyValue('Offline, buffering meter', 'AC-04'),
            SecondaryButton(
              'Open data review queue',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
          ],
        ),
        const Note(
          'Summary delivery needs internet. Late detections retain both measured-at and received-at times.',
        ),
      ],
    );
  }
}

/// 25 · Inventory (97:733)
class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'JANUARY REGISTER',
      title: 'Inventory',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Panel(
          children: [
            PanelTitle('January 2026 register'),
            PanelText('Building A · last approved 20 January'),
            Tag('USED FOR ESTIMATES & ALERT RULES'),
          ],
        ),
        SecondaryButton(
          'Aircon  ·  Lighting  ·  Equipment',
          onPressed: () => showSinagSnack(context, 'Showing all categories'),
        ),
        const Panel(
          children: [
            PanelTitle('AC-03 · Aircon'),
            PanelText('Council office · metered'),
            KeyValue('Rated input', '2,400 W'),
            KeyValue('Usual use', '8 h / onsite day'),
            KeyValue('Standby threshold', '0.10 kW'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('LT-02 · Lighting circuit'),
            PanelText('East wing · metered'),
            KeyValue('Rated load', '900 W'),
            KeyValue('Usual use', '8 h / onsite day'),
            KeyValue('Standby threshold', '0.05 kW'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Unmetered equipment group'),
            PanelText('Computers, printers and pantry equipment'),
            KeyValue('Combined rated input', '6,500 W'),
            KeyValue('Usual use', '8 h / onsite day'),
            Tag('52 kWh / DAY · ESTIMATED', color: SinagColors.warning),
            Note(
              'Rated watts × usual hours. Not a measured reading and not a direct savings claim.',
            ),
          ],
        ),
        PrimaryButton(
          'Add / edit inventory item',
          onPressed: () =>
              Navigator.of(context).pushNamed(Routes.operatingChanges),
        ),
        const Panel(
          children: [
            PanelTitle('Next annual inventory'),
            PanelText('January 2027'),
            Note(
              'Equipment changes during the year also require a dated operating-change record.',
            ),
          ],
        ),
      ],
    );
  }
}

/// 26 · Operating changes (97:765)
class OperatingChangesScreen extends StatelessWidget {
  const OperatingChangesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'BASELINE ADJUSTMENTS',
      title: 'Operating changes',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Keep the baseline comparable'),
            PanelText(
              'Log changes to floor area, offices, equipment or hours. Approved changes adjust the baseline; schedule effects remain separate.',
            ),
          ],
        ),
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
            Note(
              'New records office · approved by department head · reference OC-0701.',
            ),
            KeyValue('01 Sep · office hours', '08:00–17:00 → 18:00'),
            Note('Approved by EEC Officer · reference OC-0901.'),
            Tag('BASELINE VERSION 3 · COMPUTED'),
          ],
        ),
        const Note(
          'Pending changes do not alter reported savings. Previous baseline versions stay in the activity log.',
        ),
      ],
    );
  }
}

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

/// 27 · Sharing (97:797)
class SharingScreen extends StatelessWidget {
  const SharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'EEC OFFICER · ACCESS',
      title: 'Sharing',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Tag('EEC OFFICER · LGU CONTROLLED'),
        const Panel(
          children: [
            PanelTitle('Mayor / department head'),
            _SwitchRow('Summary & building rankings', initial: true),
            Note(
              'Read-only. No bill images, appliance controls, rule editing or report submission.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('DOE / DILG'),
            _SwitchRow('Allow external read-only access', initial: true),
            KeyValue('LGU approval', 'SHARE-1126'),
            KeyValue('Permitted building', 'Building A only'),
            KeyValue('Allowed content', 'Summary + rankings'),
            KeyValue('Access expires', '31 Dec 2026'),
            Note(
              'Nothing is shared outside this scope. No raw bills, action evidence or account-level activity.',
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
        const Note(
          'Revoking access takes effect on the next online check. Every view, change and export is logged.',
        ),
      ],
    );
  }
}

/// 28 · Activity log (97:829)
class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'ACCESS & AUDIT',
      title: 'Activity log',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        SecondaryButton(
          'All activity  ·  Views  ·  Edits  ·  Exports',
          onPressed: () => showSinagSnack(context, 'Showing all activity'),
        ),
        const PanelText(
          'Building-level audit trail · account role, action and time. No employee or resident profile data.',
        ),
        const Panel(
          children: [
            PanelTitle('12 Nov · 09:32 · Viewed'),
            Tag('MAYOR OFFICE · ACCOUNT MAYOR-01'),
            PanelText(
              'Opened Building A’s read-only summary and building rankings.',
              color: SinagColors.text,
            ),
            KeyValue('Access policy', 'SHARE-1126'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('12 Nov · 09:10 · Changed'),
            Tag('EEC OFFICER · ACCOUNT EEC-01'),
            PanelText(
              'Granted DOE / DILG summary access to Building A until 31 Dec 2026.',
              color: SinagColors.text,
            ),
            KeyValue('Record', 'SHARE-1126'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('12 Nov · 08:45 · Exported'),
            Tag('EEC OFFICER · ACCOUNT EEC-01'),
            PanelText(
              'Exported the after-hours alert log with closure notes. CSV · November 2026.',
              color: SinagColors.text,
            ),
            KeyValue('Export reference', 'EXP-1126-04'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('11 Nov · 19:10 · Acknowledged'),
            Tag('FACILITY MANAGER · ACCOUNT FM-01'),
            PanelText(
              'Replied “I’ll check it” to alert A-1126-03 by SMS. Action record still required.',
              color: SinagColors.text,
            ),
          ],
        ),
        SecondaryButton(
          'Export activity log',
          onPressed: () => showSinagSnack(context, 'Activity log exported'),
        ),
        const Note(
          'Export requires internet. Entries cannot be edited from this screen.',
        ),
      ],
    );
  }
}

/// 29 · Leadership summary (97:861) — read-only role, no bottom navigation.
class LeadershipSummaryScreen extends StatelessWidget {
  const LeadershipSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'MAYOR / DEPARTMENT HEAD',
      title: 'Leadership summary',
      children: [
        const Tag('READ-ONLY · LGU LEADERSHIP'),
        Text(
          'November progress, at a glance',
          style: SinagText.sectionTitle.copyWith(fontSize: 19, height: 28 / 19),
        ),
        Panel(
          tone: PanelTone.navy,
          children: [
            const PanelTitle('Building A · 1–12 November'),
            const PanelText('Measured · reading 12 Nov at 09:40'),
            Text(
              '5,100 kWh',
              style: SinagText.code.copyWith(color: Colors.white),
            ),
            const PanelText(
              '₱56,100 · Computed at ₱11/kWh',
              color: Colors.white,
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Savings, without the schedule effect'),
            KeyValue('Raw change · Computed', '−15.0%'),
            KeyValue('Per onsite day · Computed', '−5.6%'),
            KeyValue('Adjusted change · Computed', '−5.6%'),
            Note(
              '600 kWh of the raw reduction comes from fewer onsite days, not efficiency.',
            ),
            KeyValue('YTD adjusted · Computed', '12.4%'),
            Tag('WITHIN 10–20% ANNUAL TARGET', color: SinagColors.success),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Building rankings'),
            PanelText('YTD adjusted savings · Computed'),
            KeyValue('1 · Building A · Tier 3', '12.4%'),
            KeyValue('2 · Annex · Tier 1', '8.1% · bill-based'),
            KeyValue('Building B · Tier 2', 'Unranked · incomplete'),
            Note(
              'Building B is in bill-only mode for November. Incomplete periods are excluded from rankings.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Direct SINAG contribution'),
            KeyValue('After-hours avoided · Computed', '186 kWh / ₱2,046'),
            Note(
              'Confirmed interventions only. No raw bill images or detailed action evidence in this view.',
            ),
          ],
        ),
        const Note(
          'This summary needs internet. Changes, exports and alert-rule controls are not available to this role.',
        ),
      ],
    );
  }
}

/// 30 · DOE / DILG summary (97:875) — external read-only role.
class DoeDilgSummaryScreen extends StatelessWidget {
  const DoeDilgSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'LGU-AUTHORIZED VIEW',
      title: 'DOE / DILG summary',
      children: [
        const Tag('READ-ONLY · DOE / DILG'),
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Shared by the LGU'),
            PanelText('Approved scope: Building A only'),
            KeyValue('Authorization', 'SHARE-1126'),
            KeyValue('Expires', '31 Dec 2026'),
            Note(
              'Access may be revoked by the LGU at any time. This view is not a submission.',
            ),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Building A · November to date'),
            const PanelText('Measured · last reading 12 Nov at 09:40'),
            Text('5,100 kWh', style: SinagText.code),
            const KeyValue('Cost · Computed', '₱56,100'),
            const KeyValue('Adjusted change · Computed', '−5.6%'),
            const KeyValue('YTD adjusted · Computed', '12.4%'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Shared building ranking'),
            KeyValue('1 · Building A', '12.4% · Computed'),
            Note(
              'Only authorized buildings are shown. Other LGU buildings and their rankings are hidden.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Scope of this view'),
            PanelText(
              'Energy summaries and rankings only. Raw bills, alert evidence, rule changes and detailed activity are not shared.',
            ),
            Tag('NO EDITING · NO EXPORTS · NO SUBMISSION'),
          ],
        ),
        const Note(
          'Official reports are submitted separately by the EEC Officer in the GEMP Online System. Internet is required to validate access.',
        ),
      ],
    );
  }
}
