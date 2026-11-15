import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/roles.dart';
import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 07 · Review bill — Figma frame 97:174
///
/// Focal person checks the fields read from the bill (highlighted ones are
/// low-confidence) and confirms them. Warns when the bill and the meter differ
/// by more than 3%.
class ReviewBillScreen extends StatelessWidget {
  const ReviewBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return SinagPage(
      eyebrow: 'FOCAL PERSON · CONFIRM',
      title: 'Review bill',
      role: SinagRole.focalPerson,
      bottomBar: const RoleNav(items: focalNav),
      about: const [
        'SINAG read these numbers from your bill photo (OCR). Amber fields '
            'are ones it is less sure about.',
        'How sure it is: account number 99%, billing period 72%, '
            'consumption 98%, amount 79%. Lower confidence doesn’t mean '
            'wrong; just check it against the bill.',
        'If the bill and the meter differ by more than 3%, the bill is '
            'still saved, but the month stays incomplete until the EEC '
            'Officer reviews it.',
      ],
      children: [
        const Tag('UPLOADED · READ FROM PHOTO'),
        const BodyText(
          'Check the 2 amber fields against the bill. Tap a field to fix it.',
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _BillPreview()),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SinagField(
                    label: 'Account number',
                    initialValue: '123-45678-90',
                  ),
                  SizedBox(height: 10),
                  SinagField(
                    label: 'Billing period · check',
                    initialValue: '01–31 Oct 2026',
                    highlight: true,
                  ),
                  SizedBox(height: 10),
                  SinagField(label: 'Consumption', initialValue: '14,250 kWh'),
                  SizedBox(height: 10),
                  SinagField(
                    label: 'Amount · check',
                    initialValue: '₱110,571.50',
                    highlight: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        PrimaryButton(
          'Confirm bill',
          onPressed: () {
            showSinagSnack(context, 'October bill confirmed and saved');
          },
        ),
        Panel(
          tone: PanelTone.danger,
          children: [
            const PanelTitle('Bill and meter differ by 3.8%'),
            const PanelText('The bill shows 522 kWh more than the meter.'),
            SecondaryButton(
              'Open data review queue',
              onPressed: () => nav.pushNamed(Routes.dataReview),
            ),
            const MoreDetails(
              children: [
                PanelText(
                  'Measured bill: 14,250 kWh\nMeasured main meter: 13,728 '
                  'kWh\nComputed difference: 522 kWh / 3.8%',
                ),
                Note(
                  'Over the 3% limit. Confirmation saves the bill, but '
                  'October stays incomplete until the review queue is '
                  'cleared.',
                  color: SinagColors.dangerText,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// "Bill image preview" — a typeset stand-in for the scanned demo bill.
class _BillPreview extends StatelessWidget {
  const _BillPreview();

  @override
  Widget build(BuildContext context) {
    TextStyle s(double size, double lh, FontWeight w, Color c) =>
        GoogleFonts.inter(
          fontSize: size,
          height: lh / size,
          fontWeight: w,
          color: c,
        );
    const semi = FontWeight.w600;
    const reg = FontWeight.w400;
    return Panel(
      padding: 12,
      gap: 12,
      children: [
        Text('CITY ELECTRIC', style: s(12, 17, semi, SinagColors.navy)),
        Text('STATEMENT\nOF ACCOUNT', style: s(10, 15, semi, SinagColors.text)),
        Text(
          '123-45678-90\nCITY HALL\nBUILDING A',
          style: s(10, 15, reg, SinagColors.text),
        ),
        Text('01–31 OCT 2026', style: s(10, 15, semi, SinagColors.text)),
        Text(
          'CONSUMPTION\n14,250 kWh',
          style: s(11, 16, semi, SinagColors.text),
        ),
        Text(
          'TOTAL DUE\n₱110,571.50',
          style: s(11, 16, semi, SinagColors.text),
        ),
        Text(
          'Bill preview\nDemo document',
          style: s(10, 15, reg, SinagColors.muted),
        ),
      ],
    );
  }
}
