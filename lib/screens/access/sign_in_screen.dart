import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 01 · Sign in — Figma frame 97:54
///
/// First screen of the app. The user signs in with a government email and
/// password (or agency SSO), then goes to 02 · Verify.
///
/// Layout, top to bottom:
///   1. "Energy accountability" intro card
///   2. Note: access is set by the LGU
///   3. Work email + password fields
///   4. "Sign in securely" (main) and "Continue with agency SSO"
///   5. Forgot password · Request facility access links
///   6. "Secure by design" notes, in the ⓘ next to the title
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goToVerify() => Navigator.of(context).pushNamed(Routes.verify);

    return SinagPage(
      header: SinagHeader.auth,
      eyebrow: 'ACCESS · STEP 1 OF 2',
      eyebrowColor: SinagColors.lightBlueText, // light blue welcome accent
      title: 'Sign in',
      // 6. "Secure by design" — in the ⓘ next to the title.
      about: const [
        'Secure by design: a verification code is required next.',
        'Only building-level energy data is stored; no employee or resident '
            'personal data.',
        'Official government access only. Views, changes and exports are '
            'recorded.',
      ],
      children: [
        // 1. Intro card (light blue — the app's welcome accent)
        const Panel(
          tone: PanelTone.lightBlue,
          children: [
            PanelTitle('Energy accountability, every day'),
            PanelText(
              'Systematic Information Network for Auditing Government-energy',
            ),
            Tag(
              'RA 11285 · LGU ENERGY MANAGEMENT',
              color: SinagColors.lightBlueText,
            ),
          ],
        ),

        // 2. Access note
        const BodyText(
          'Use your assigned government account. Your access is set by the '
          'LGU, not chosen at sign-in.',
        ),

        // 3. Credentials
        const SinagField(
          label: 'Work email',
          initialValue: 'eec.officer@agency.gov.ph',
          keyboardType: TextInputType.emailAddress,
        ),
        const SinagField(
          label: 'Password',
          initialValue: 'demopassword', // 12 characters → 12 dots, as in Figma
          obscure: true,
        ),

        // 4. Sign-in buttons
        PrimaryButton('Sign in securely', onPressed: goToVerify),
        SecondaryButton('Continue with agency SSO', onPressed: goToVerify),

        // 5. Help links
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
      ],
    );
  }
}
