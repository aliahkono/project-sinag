import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';

/// Shows a short navy message at the bottom of the screen. Used for demo
/// actions that don't open another screen yet (e.g. "Password reset link
/// sent").
void showSinagSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: SinagColors.navy,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
