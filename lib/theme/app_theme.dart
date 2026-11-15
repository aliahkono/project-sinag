import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// The app-wide Material theme: Inter font, navy as the main colour and the
/// light grey page background.
ThemeData buildSinagTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: SinagColors.navy,
      primary: SinagColors.navy,
      surface: SinagColors.surface,
      error: SinagColors.danger,
    ),
    scaffoldBackgroundColor: SinagColors.background,
  );
}
