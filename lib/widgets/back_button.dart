import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';

/// "‹" back arrow shown at the left of the header bars.
///
/// It only appears when there is a previous screen to go back to. Screens
/// opened as a fresh start (e.g. the Dashboard right after sign-in, or a
/// bottom-nav tab) have nothing behind them, so no arrow is shown there.
class SinagBackButton extends StatelessWidget {
  const SinagBackButton({super.key});

  /// True when the current screen has a screen behind it.
  static bool isAvailable(BuildContext context) =>
      ModalRoute.of(context)?.canPop ?? false;

  @override
  Widget build(BuildContext context) {
    if (!isAvailable(context)) return const SizedBox.shrink();
    return IconButton(
      tooltip: 'Back',
      onPressed: () => Navigator.of(context).maybePop(),
      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
      color: SinagColors.navy,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
    );
  }
}
