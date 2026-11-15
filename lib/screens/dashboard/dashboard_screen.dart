import 'package:flutter/material.dart';

import '../../app/buildings.dart';
import '../../app/glossary.dart';
import '../../app/roles.dart';
import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 05 · Dashboard — Figma frame 97:110
///
/// The EEC Officer's home screen after sign-in: this month's energy use
/// against the baseline, savings, after-hours waste, and shortcuts to the
/// rest of the app.
///
/// Each card leads with one headline; breakdowns sit under "See details"
/// and the label legend is in the ⓘ next to the title.
///   1. _OpenAlertsCard       red: open after-hours alerts → 11 · Alerts
///   2. _MonthVsBaselineCard  navy: kWh and ₱ so far this month
///   3. _FairComparisonCard   change after adjusting for onsite days
///   4. _YearToDateCard       savings progress bar (target 10–20%)
///   5. _AfterHoursAvoidedCard  green: savings SINAG can claim
///   6. Two shortcut buttons  → 08 · Appliances, 14 · Alert rules
///   7. _EecWorkspaceCard     shortcuts to EEC Officer tools
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);

    return SinagPage(
      eyebrow: 'EEC OFFICER · OVERVIEW',
      title: 'Dashboard',
      role: SinagRole.eecOfficer,
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        ...Glossary.dataLabels,
        Glossary.needsInternet,
        Glossary.noRemoteControl,
      ],
      children: [
        // Which building this is (chosen in the top bar or on Buildings).
        Tag(
          '${selectedBuildingTag()} · DEMO DATA · '
          '1–12 NOV 2026',
          color: SinagColors.muted,
        ),
        const _OpenAlertsCard(),
        const _MonthVsBaselineCard(),
        const _FairComparisonCard(),
        const _YearToDateCard(),
        const _AfterHoursAvoidedCard(),
        SecondaryButton(
          'Appliances  ·  Live load',
          onPressed: () => nav.pushNamed(Routes.appliances),
        ),
        SecondaryButton(
          'Alert rules & operating calendar',
          onPressed: () => nav.pushNamed(Routes.alertRules),
        ),
        const _EecWorkspaceCard(),
      ],
    );
  }
}

/// 1. Red card: open after-hours alerts.
class _OpenAlertsCard extends StatelessWidget {
  const _OpenAlertsCard();

  @override
  Widget build(BuildContext context) {
    return Panel(
      tone: PanelTone.danger,
      children: [
        const PanelTitle('2 open after-hours alerts'),
        const PanelText('Aircon AC-03 needs follow-up.'),
        PrimaryButton(
          'Review alerts',
          onPressed: () => Navigator.of(context).pushNamed(Routes.alerts),
        ),
      ],
    );
  }
}

/// 2. Navy card: energy and cost so far this month.
class _MonthVsBaselineCard extends StatelessWidget {
  const _MonthVsBaselineCard();

  @override
  Widget build(BuildContext context) {
    return Panel(
      tone: PanelTone.navy,
      children: [
        const PanelTitle('This month vs baseline'),
        Text('5,100 kWh', style: SinagText.bigNumber),
        const PanelText('₱56,100 so far · 1–12 November'),
        const MoreDetails(
          children: [
            Caption('Same-period comparison · 1–12 November'),
            Caption('5,100 kWh · Measured · latest reading 09:40'),
            Caption('₱56,100 · Computed · indicative cost at ₱11/kWh'),
          ],
        ),
      ],
    );
  }
}

/// 3. Change after adjusting for fewer onsite days.
class _FairComparisonCard extends StatelessWidget {
  const _FairComparisonCard();

  @override
  Widget build(BuildContext context) {
    return const Panel(
      children: [
        PanelTitleWithInfo(
          'Fair comparison: 5.6% less',
          infoTitle: 'Why "fair"?',
          info: [
            'This month had 9 onsite days; the baseline had 10. Fewer days '
                'use less energy without anyone saving.',
            'The fair figure removes that schedule effect, so only real '
                'efficiency is counted.',
          ],
        ),
        PanelText('−300 kWh / −₱3,300 after adjusting for fewer onsite days.'),
        MoreDetails(
          label: 'See breakdown',
          children: [
            // Raw change
            KeyValue('Raw change · Computed', '−900 kWh / −₱9,900'),
            Tag('−15.0% vs 6,000 kWh / ₱66,000', color: SinagColors.success),
            // Per onsite day
            KeyValue('Per onsite day · Computed', '566.7 vs 600 kWh'),
            KeyValue('Cost per onsite day', '₱6,233 vs ₱6,600'),
            Tag(
              '−5.6% · 9 onsite days vs baseline 10',
              color: SinagColors.success,
            ),
            // Adjusted change
            KeyValue('Adjusted change · Computed', '−300 kWh / −₱3,300'),
            Tag('−5.6% vs adjusted 5,400 kWh', color: SinagColors.success),
            Note(
              'Schedule effect · Computed\n'
              '600 kWh / ₱6,600 from fewer onsite days. Not counted as '
              'efficiency.',
            ),
          ],
        ),
      ],
    );
  }
}

/// 4. Year-to-date savings with a progress bar towards the 20% stretch target.
class _YearToDateCard extends StatelessWidget {
  const _YearToDateCard();

  static const _savingsPercent = 12.4;
  static const _stretchTargetPercent = 20.0;

  @override
  Widget build(BuildContext context) {
    return const Panel(
      children: [
        PanelTitle('12.4% saved this year'),
        SinagProgressBar(fraction: _savingsPercent / _stretchTargetPercent),
        KeyValue('Minimum 10%', 'Stretch 20%'),
        MoreDetails(
          children: [
            Note(
              'Adjusted savings, year to date · Computed. Within the 10–20% '
              'annual target.',
            ),
          ],
        ),
      ],
    );
  }
}

/// 5. Green card: after-hours energy avoided thanks to SINAG.
class _AfterHoursAvoidedCard extends StatelessWidget {
  const _AfterHoursAvoidedCard();

  @override
  Widget build(BuildContext context) {
    return const Panel(
      tone: PanelTone.success,
      children: [
        PanelTitle('186 kWh after-hours avoided'),
        PanelText('₱2,046 saved this month'),
        MoreDetails(
          children: [
            Note(
              'Computed. SINAG-attributable savings from confirmed '
              'interventions, excluding approved overtime.',
              color: SinagColors.success,
            ),
          ],
        ),
      ],
    );
  }
}

/// 7. Shortcuts to the EEC Officer's management screens.
class _EecWorkspaceCard extends StatelessWidget {
  const _EecWorkspaceCard();

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return Panel(
      padding: 16,
      children: [
        const PanelTitle('EEC workspace'),
        SmallButton(
          label: 'Reports · Meters · Data review',
          onPressed: () => nav.pushNamed(Routes.reports),
        ),
        SmallButton(
          label: 'Inventory · Changes · Sharing',
          onPressed: () => nav.pushNamed(Routes.inventory),
        ),
        SmallButton(
          label: '8:00 AM summary',
          onPressed: () => nav.pushNamed(Routes.morningSummary),
        ),
      ],
    );
  }
}
