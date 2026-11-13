import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';
import 'role_navs.dart';

/// 05 · Dashboard (97:110)
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'EEC OFFICER · OVERVIEW',
      title: 'Dashboard',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      children: [
        const Tag('DEMO DATA · 1–12 NOV 2026', color: SinagColors.muted),
        Panel(
          tone: PanelTone.danger,
          children: [
            const PanelTitle('2 open after-hours alerts'),
            const PanelText(
              'Aircon AC-03 needs follow-up. No equipment is switched off remotely.',
            ),
            PrimaryButton(
              'Review alerts',
              onPressed: () => nav.pushNamed(Routes.alerts),
            ),
          ],
        ),
        Panel(
          tone: PanelTone.navy,
          children: [
            const PanelTitle('This month vs baseline'),
            const PanelText('Same-period comparison · 1–12 November'),
            Text('5,100 kWh', style: SinagText.bigNumber),
            const Caption('Measured · latest reading 09:40'),
            Text('₱56,100', style: SinagText.mediumNumber),
            const Caption('Computed · indicative cost at ₱11/kWh'),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Make the comparison fair'),
            KeyValue('Raw change · Computed', '−900 kWh / −₱9,900'),
            Tag('−15.0% vs 6,000 kWh / ₱66,000', color: SinagColors.success),
            KeyValue('Per onsite day · Computed', '566.7 vs 600 kWh'),
            KeyValue('Cost per onsite day', '₱6,233 vs ₱6,600'),
            Tag(
              '−5.6% · 9 onsite days vs baseline 10',
              color: SinagColors.success,
            ),
            KeyValue('Adjusted change · Computed', '−300 kWh / −₱3,300'),
            Tag('−5.6% vs adjusted 5,400 kWh', color: SinagColors.success),
            Note(
              'Schedule effect · Computed\n600 kWh / ₱6,600 from fewer onsite days. Not counted as efficiency.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('12.4% adjusted savings · year to date'),
            PanelText('Computed · within the 10–20% annual target'),
            SinagProgressBar(fraction: 12.4 / 20),
            KeyValue('Minimum 10%', 'Stretch 20%'),
          ],
        ),
        const Panel(
          tone: PanelTone.success,
          children: [
            PanelTitle('186 kWh after-hours avoided'),
            PanelText('Computed · ₱2,046 avoided this month'),
            Note(
              'SINAG-attributable savings from confirmed interventions, excluding approved overtime.',
              color: SinagColors.success,
            ),
          ],
        ),
        SecondaryButton(
          'Appliances  ·  Live load',
          onPressed: () => nav.pushNamed(Routes.appliances),
        ),
        SecondaryButton(
          'Alert rules & operating calendar',
          onPressed: () => nav.pushNamed(Routes.alertRules),
        ),
        const Caption(
          'Measured = meter / bill · Estimated = inventory\nComputed = derived from labeled inputs\nLive dashboard requires internet.',
        ),
        Panel(
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
        ),
      ],
    );
  }
}

/// 06 · Scan bill (97:142)
class ScanBillScreen extends StatelessWidget {
  const ScanBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'FOCAL PERSON · CAPTURE',
      title: 'Scan bill',
      bottomBar: RoleNav(items: focalNav, selected: 0),
      children: [
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Offline capture is ready'),
            PanelText('Photos stay on this phone until a connection returns.'),
            Tag('OFFLINE · 2 BILLS QUEUED'),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Capture the whole bill'),
            const PanelText('Keep all four corners visible and avoid glare.'),
            const Tag('PHOTO OR PDF', color: SinagColors.muted),
            PrimaryButton(
              'Take a bill photo',
              onPressed: () => nav.pushNamed(Routes.reviewBill),
            ),
            SecondaryButton(
              'Upload a PDF',
              onPressed: () => nav.pushNamed(Routes.reviewBill),
            ),
            const Note(
              'OCR starts after upload and needs internet. You confirm extracted fields before saving.',
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Waiting on this phone'),
            KeyValue('October · Building A', 'Queued'),
            KeyValue('September · Building A', 'Queued'),
            Note(
              'Saved securely · will upload automatically when online. Do not remove the app before syncing.',
            ),
          ],
        ),
        Panel(
          tone: PanelTone.warning,
          children: [
            const PanelTitle('August bill is missing'),
            const PanelText(
              'Add the missing bill to complete the building’s monthly record.',
            ),
            SecondaryButton(
              'Add missing bill',
              onPressed: () => nav.pushNamed(Routes.reviewBill),
            ),
          ],
        ),
        SecondaryButton(
          'Review uploaded bill',
          onPressed: () => nav.pushNamed(Routes.reviewBill),
        ),
        const Note(
          'Focal person · capture and confirmation only. No direct submission to DOE.',
        ),
      ],
    );
  }
}
