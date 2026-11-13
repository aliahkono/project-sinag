import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour tokens taken from the SINAG Figma file ("revised" page).
class SinagColors {
  SinagColors._();

  static const background = Color(0xFFF3F4F5);
  static const appBar = Color(0xFFF8F9FA);
  static const surface = Colors.white;

  static const navy = Color(0xFF002046);
  static const navyActive = Color(0xFF1B365D);
  static const navyActiveLabel = Color(0xFF87A0CD);
  static const navOnNavy = Color(0xFFC7D5E9);

  static const text = Color(0xFF191C1F);
  static const muted = Color(0xFF586477);
  static const eyebrow = Color(0xFF555F70);
  static const navInactive = Color(0xFF44474E);

  static const border = Color(0xFFDDE2E8);
  static const panelBorder = Color(0x4DC4C6CF); // rgba(196,198,207,0.3)

  static const success = Color(0xFF1B6D24);
  static const warning = Color(0xFF815500);
  static const danger = Color(0xFFBA1A1A);
  static const dangerText = Color(0xFF94000A);
  static const warningBorder = Color(0xFFC89B3C);
  static const chartBackground = Color(0xFFF7F9FC);

  static const tintDanger = Color(0xFFFCECE9);
  static const tintInfo = Color(0xFFEAF0F9);
  static const tintSuccess = Color(0xFFEAF4EC);
  static const tintWarning = Color(0xFFFFF3D9);
}

/// Text styles. Figma uses Inter with fixed line heights; `height` here is
/// line-height / font-size so rendering matches the design.
class SinagText {
  SinagText._();

  static TextStyle _inter(
    double size,
    double lineHeight,
    FontWeight weight,
    Color color,
  ) => GoogleFonts.inter(
    fontSize: size,
    height: lineHeight / size,
    fontWeight: weight,
    color: color,
  );

  static const _semi = FontWeight.w600;
  static const _reg = FontWeight.w400;

  static TextStyle eyebrow = _inter(10, 15, _semi, SinagColors.eyebrow);
  static TextStyle pageTitle = _inter(28, 41, _semi, SinagColors.navy);
  static TextStyle sectionTitle = _inter(21, 30, _semi, SinagColors.navy);
  static TextStyle panelTitle = _inter(15, 22, _semi, SinagColors.navy);
  static TextStyle panelBody = _inter(13, 19, _reg, SinagColors.muted);
  static TextStyle tag = _inter(11, 16, _semi, SinagColors.navy);
  static TextStyle body = _inter(14, 20, _reg, SinagColors.muted);
  static TextStyle bodyStrong = _inter(14, 20, _reg, SinagColors.text);
  static TextStyle small = _inter(12, 17, _reg, SinagColors.muted);
  static TextStyle smallStrong = _inter(12, 17, _semi, SinagColors.navy);
  static TextStyle link = _inter(13, 19, _semi, SinagColors.navy);
  static TextStyle caption = _inter(11, 16, _reg, SinagColors.muted);
  static TextStyle kvLabel = _inter(12, 17, _reg, SinagColors.muted);
  static TextStyle kvValue = _inter(13, 19, _semi, SinagColors.navy);
  static TextStyle button = _inter(14, 20, _semi, SinagColors.navy);
  static TextStyle smallButton = _inter(12, 17, _semi, SinagColors.navy);
  static TextStyle fieldLabel = _inter(11, 16, _semi, SinagColors.muted);
  static TextStyle fieldValue = _inter(14, 20, _reg, SinagColors.text);
  static TextStyle bigNumber = _inter(32, 46, _semi, Colors.white);
  static TextStyle mediumNumber = _inter(24, 35, _semi, Colors.white);
  static TextStyle alertFigure = _inter(22, 32, _semi, SinagColors.dangerText);
  static TextStyle code = _inter(30, 44, _semi, SinagColors.navy);
  static TextStyle navLabel = _inter(
    12,
    16,
    _semi,
    SinagColors.navInactive,
  ).copyWith(letterSpacing: 0.6);
  static TextStyle brand = GoogleFonts.inter(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    color: SinagColors.navy,
  );
}

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
