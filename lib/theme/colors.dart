import 'package:flutter/material.dart';

/// Every colour used in the SINAG design, taken from the Figma "revised" page.
///
/// Always use these names instead of writing hex values in a screen, so a
/// colour change only has to be made here.
class SinagColors {
  SinagColors._();

  // Backgrounds
  static const background = Color(0xFFF3F4F5); // page behind the cards
  static const appBar = Color(0xFFF8F9FA); // top app bar
  static const surface = Colors.white; // cards, fields, buttons

  // Brand navy
  static const navy = Color(0xFF002046); // titles, primary buttons
  static const navyActive = Color(0xFF1B365D); // active bottom-nav pill
  static const navyActiveLabel = Color(0xFF87A0CD); // label on that pill
  static const navOnNavy = Color(0xFFC7D5E9); // soft text on navy cards

  // Text
  static const text = Color(0xFF191C1F); // field values, strong body
  static const muted = Color(0xFF586477); // secondary text
  static const eyebrow = Color(0xFF555F70); // small label above page titles
  static const navInactive = Color(0xFF44474E); // inactive bottom-nav tabs

  // Borders
  static const border = Color(0xFFDDE2E8); // fields and outlined buttons
  static const panelBorder = Color(0x4DC4C6CF); // white cards (30% opacity)

  // Status colours (text)
  static const success = Color(0xFF1B6D24);
  static const warning = Color(0xFF815500);
  static const danger = Color(0xFFBA1A1A);
  static const dangerText = Color(0xFF94000A);
  static const warningBorder = Color(0xFFC89B3C);
  static const chartBackground = Color(0xFFF7F9FC);

  // Status colours (card backgrounds)
  static const tintDanger = Color(0xFFFCECE9); // red: alert
  static const tintInfo = Color(0xFFEAF0F9); // blue: information
  static const tintSuccess = Color(0xFFEAF4EC); // green: saved / resolved
  static const tintWarning = Color(0xFFFFF3D9); // amber: needs review

  // Light blue accent (not in Figma; added for variety): header bars behind
  // the logo, and the intro card on the Sign in screen.
  // Decorative only: it never means a status like the colours above.
  static const lightBlueTint = Color(0xFFE3EEFA); // header / card background
  static const lightBlueBorder = Color(0xFFC3D7EE); // card border
  static const lightBlueText = Color(0xFF2E5C8A); // labels on light backgrounds
}
