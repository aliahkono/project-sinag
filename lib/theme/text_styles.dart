import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Every text style used in the SINAG design (font: Inter).
///
/// Figma gives each style a font size and a fixed line height in pixels.
/// Flutter wants line height as a multiple of the font size, so `_inter`
/// converts it: `height = lineHeight / size`.
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

  // Page heading
  static TextStyle eyebrow = _inter(10, 15, _semi, SinagColors.eyebrow);
  static TextStyle pageTitle = _inter(28, 41, _semi, SinagColors.navy);
  static TextStyle sectionTitle = _inter(21, 30, _semi, SinagColors.navy);

  // Cards
  static TextStyle panelTitle = _inter(15, 22, _semi, SinagColors.navy);
  static TextStyle panelBody = _inter(13, 19, _reg, SinagColors.muted);
  static TextStyle tag = _inter(11, 16, _semi, SinagColors.navy);

  // Body text
  static TextStyle body = _inter(14, 20, _reg, SinagColors.muted);
  static TextStyle bodyStrong = _inter(14, 20, _reg, SinagColors.text);
  static TextStyle small = _inter(12, 17, _reg, SinagColors.muted);
  static TextStyle smallStrong = _inter(12, 17, _semi, SinagColors.navy);
  static TextStyle link = _inter(13, 19, _semi, SinagColors.navy);
  static TextStyle caption = _inter(11, 16, _reg, SinagColors.muted);

  // Label / value rows
  static TextStyle kvLabel = _inter(12, 17, _reg, SinagColors.muted);
  static TextStyle kvValue = _inter(13, 19, _semi, SinagColors.navy);

  // Buttons and fields
  static TextStyle button = _inter(14, 20, _semi, SinagColors.navy);
  static TextStyle smallButton = _inter(12, 17, _semi, SinagColors.navy);
  static TextStyle fieldLabel = _inter(11, 16, _semi, SinagColors.muted);
  static TextStyle fieldValue = _inter(14, 20, _reg, SinagColors.text);

  // Big numbers
  static TextStyle bigNumber = _inter(32, 46, _semi, Colors.white);
  static TextStyle mediumNumber = _inter(24, 35, _semi, Colors.white);
  static TextStyle alertFigure = _inter(22, 32, _semi, SinagColors.dangerText);
  static TextStyle code = _inter(30, 44, _semi, SinagColors.navy);

  // Navigation and brand
  static TextStyle navLabel = _inter(
    12,
    16,
    _semi,
    SinagColors.navInactive,
  ).copyWith(letterSpacing: 0.6);

  /// "SINAG" wordmark next to the logo symbol. Font: Cinzel (classic
  /// capitals; Figma used Inter). Change the font here to change it in both
  /// headers. [size] is the font size in pixels.
  static TextStyle brand(double size) => GoogleFonts.cinzel(
    fontSize: size,
    height: 1.0,
    fontWeight: FontWeight.w700,
    letterSpacing: size * 0.04,
    color: SinagColors.navy,
  );
}
