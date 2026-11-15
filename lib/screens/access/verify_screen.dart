import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 02 · Verify — Figma frame 97:68
///
/// Second sign-in step: the user enters the 6-digit code sent to their
/// government email, then goes to 03 · My access.
///
/// Layout, top to bottom:
///   1. "PASSWORD VERIFIED" + "Check your government email"
///   2. Verification code card (code + time left)
///   3. "Verify & continue" (main) and "Resend code"
///   4. "Two steps. One secure workspace." progress card
///   5. "Use a different account" link (back to 01 · Sign in)
class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);

    return SinagPage(
      header: SinagHeader.auth,
      eyebrow: 'ACCESS · STEP 2 OF 2',
      title: 'Verify',
      children: [
        // 1. Status + instructions
        const Tag('PASSWORD VERIFIED', color: SinagColors.success),
        Text('Check your government email', style: SinagText.sectionTitle),
        const BodyText('Enter the 6-digit code sent to\ne•••@agency.gov.ph.'),

        // 2. Code card
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

        // 3. Buttons
        PrimaryButton(
          'Verify & continue',
          onPressed: () => nav.pushNamed(Routes.myAccess),
        ),
        SecondaryButton(
          'Resend code in 00:32',
          onPressed: () => showSinagSnack(context, 'A new code was sent'),
        ),

        // 4. Progress card
        const Panel(
          children: [
            PanelTitle('Two steps. One secure workspace.'),
            PanelText(
              '1  Password confirmed\n'
              '2  Verify identity\n'
              '3  Open your assigned building',
            ),
          ],
        ),

        // 5. Start over with another account
        TextLink(
          'Use a different account',
          onTap: () => nav.pushNamedAndRemoveUntil(Routes.signIn, (_) => false),
        ),
      ],
    );
  }
}
