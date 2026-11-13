import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import '../widgets/sinag_widgets.dart';

/// 01 · Sign in (97:54)
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      header: SinagHeader.auth,
      eyebrow: 'ACCESS · STEP 1 OF 2',
      title: 'Sign in',
      children: [
        const Panel(
          children: [
            PanelTitle('Energy accountability, every day'),
            PanelText(
              'Systematic Information Network for Auditing Government-energy',
            ),
            Tag('RA 11285 · LGU ENERGY MANAGEMENT'),
          ],
        ),
        const BodyText(
          'Use your assigned government account. Your access is set by the LGU, not chosen at sign-in.',
        ),
        const SinagField(
          label: 'Work email',
          initialValue: 'eec.officer@agency.gov.ph',
          keyboardType: TextInputType.emailAddress,
        ),
        const SinagField(
          label: 'Password',
          initialValue: 'demopassword',
          obscure: true,
        ),
        PrimaryButton(
          'Sign in securely',
          onPressed: () => Navigator.of(context).pushNamed(Routes.verify),
        ),
        SecondaryButton(
          'Continue with agency SSO',
          onPressed: () => Navigator.of(context).pushNamed(Routes.verify),
        ),
        Wrap(
          children: [
            TextLink(
              'Forgot password?',
              small: true,
              onTap: () => showSinagSnack(context, 'Password reset link sent'),
            ),
            Text('  ·  ', style: SinagText.smallStrong),
            TextLink(
              'Request facility access',
              small: true,
              onTap: () =>
                  showSinagSnack(context, 'Access request sent to your LGU'),
            ),
          ],
        ),
        const Panel(
          children: [
            PanelTitle('Secure by design'),
            PanelText(
              'A verification code is required next. Only building-level energy data is stored; no employee or resident personal data.',
            ),
            Note(
              'Official government access only. Views, changes and exports are recorded.',
            ),
          ],
        ),
      ],
    );
  }
}

/// 02 · Verify (97:68)
class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      header: SinagHeader.auth,
      eyebrow: 'ACCESS · STEP 2 OF 2',
      title: 'Verify',
      children: [
        const Tag('PASSWORD VERIFIED', color: SinagColors.success),
        Text('Check your government email', style: SinagText.sectionTitle),
        const BodyText('Enter the 6-digit code sent to\ne•••@agency.gov.ph.'),
        Panel(
          children: [
            const PanelTitle('Verification code'),
            Text('4   8   2   1   9   6', style: SinagText.code),
            Text(
              'Code expires in 04:32',
              style: SinagText.tag.copyWith(color: SinagColors.muted),
            ),
          ],
        ),
        PrimaryButton(
          'Verify & continue',
          onPressed: () => Navigator.of(context).pushNamed(Routes.myAccess),
        ),
        SecondaryButton(
          'Resend code in 00:32',
          onPressed: () => showSinagSnack(context, 'A new code was sent'),
        ),
        const Panel(
          children: [
            PanelTitle('Two steps. One secure workspace.'),
            PanelText(
              '1  Password confirmed\n2  Verify identity\n3  Open your assigned building',
            ),
          ],
        ),
        TextLink(
          'Use a different account',
          onTap: () =>
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.signIn, (_) => false),
        ),
      ],
    );
  }
}

/// 03 · My access (97:82)
class MyAccessScreen extends StatelessWidget {
  const MyAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      header: SinagHeader.auth,
      eyebrow: 'ACCESS & PERMISSIONS',
      title: 'My access',
      children: [
        const Panel(
          children: [
            PanelTitle('Your assigned access'),
            PanelText('City Hall Complex · LGU account'),
            Tag('EEC OFFICER · FULL BUILDING ACCESS'),
            BodyText(
              'All monitoring, alerts, alert rules, data review and report exports.',
              strong: true,
            ),
          ],
        ),
        PrimaryButton(
          'Continue as EEC Officer',
          onPressed: () =>
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.dashboard, (_) => false),
        ),
        // Each role row opens that role's home screen as a preview.
        Panel(
          children: [
            const PanelTitle('What each role can see'),
            for (final (label, value, route) in const [
              (
                'Focal person',
                'Scan · review · follow up',
                Routes.focalWorkspace,
              ),
              (
                'Facility manager',
                'Alerts · appliances',
                Routes.facilityWorkspace,
              ),
              ('EEC Officer', 'Everything + rules / reports', Routes.dashboard),
              (
                'Mayor / department head',
                'Summary · rankings only',
                Routes.leadershipSummary,
              ),
              ('DOE / DILG', 'Read-only if LGU allows', Routes.doeDilgSummary),
            ])
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pushNamed(route),
                child: KeyValue(label, value),
              ),
          ],
        ),
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Permissions are assigned'),
            PanelText(
              'Contact your LGU administrator to change your role. External access is off until the LGU grants it.',
            ),
          ],
        ),
        SecondaryButton(
          'Select building',
          onPressed: () => Navigator.of(context).pushNamed(Routes.buildings),
        ),
      ],
    );
  }
}

/// 04 · Buildings (97:96)
class BuildingsScreen extends StatelessWidget {
  const BuildingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void open() =>
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.dashboard, (_) => false);
    return SinagPage(
      header: SinagHeader.auth,
      eyebrow: 'JURISDICTION',
      title: 'Buildings',
      children: [
        const BodyText('Choose a building in your LGU.'),
        const SinagField(label: 'Search buildings', initialValue: 'City Hall'),
        Panel(
          children: [
            const PanelTitle('City Hall Complex – Building A'),
            const PanelText('Main administrative offices'),
            const Tag(
              'SELECTED · TIER 3 · LIVE METERS',
              color: SinagColors.success,
            ),
            const KeyValue('Last reading', '12 Nov · 09:40'),
            PrimaryButton('Open Building A', onPressed: open),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('City Hall Complex – Building B'),
            const PanelText('Legislative offices'),
            const Tag('TIER 2 · NOVEMBER BILL-ONLY'),
            const KeyValue('Status', 'Meter failed · 10 Nov'),
            SecondaryButton('Switch to Building B', onPressed: open),
          ],
        ),
        Panel(
          children: [
            const PanelTitle('Annex Building'),
            const PanelText('Records and storage'),
            const Tag('TIER 1 · BILL-ONLY', color: SinagColors.warning),
            const KeyValue('Latest bill', 'October 2026'),
            SecondaryButton('Switch to Annex', onPressed: open),
          ],
        ),
        const Note(
          'Your role and sharing permissions apply separately to each building.',
        ),
      ],
    );
  }
}
