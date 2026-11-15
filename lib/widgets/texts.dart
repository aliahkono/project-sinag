import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';
import 'panel.dart';

// Text pieces used inside screens and cards. Each one picks the right
// SinagText style and turns light automatically inside a navy card.

/// Card heading (15/22 semibold navy).
class PanelTitle extends StatelessWidget {
  const PanelTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Panel.isOnNavy(context)
        ? SinagText.panelTitle.copyWith(color: Colors.white)
        : SinagText.panelTitle,
  );
}

/// Card supporting text (13/19 regular grey).
class PanelText extends StatelessWidget {
  const PanelText(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: SinagText.panelBody.copyWith(
      color: color ?? (Panel.isOnNavy(context) ? SinagColors.navOnNavy : null),
    ),
  );
}

/// Small all-caps status label (11/16 semibold), e.g. "TIER 1 · BILL-ONLY".
/// Pass [color] for status: success (green), warning (amber), danger (red).
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key, this.color = SinagColors.navy});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: SinagText.tag.copyWith(color: color));
}

/// Small note (12/17 regular grey). [strong] makes it semibold navy.
class Note extends StatelessWidget {
  const Note(this.text, {super.key, this.color, this.strong = false});
  final String text;
  final Color? color;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final onNavy = Panel.isOnNavy(context);
    final base = strong ? SinagText.smallStrong : SinagText.small;
    return Text(
      text,
      style: base.copyWith(
        color: color ?? (onNavy && !strong ? SinagColors.navOnNavy : null),
      ),
    );
  }
}

/// Smallest text (11/16 regular grey), e.g. "Measured · latest reading 09:40".
class Caption extends StatelessWidget {
  const Caption(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: SinagText.caption.copyWith(
      color: color ?? (Panel.isOnNavy(context) ? SinagColors.navOnNavy : null),
    ),
  );
}

/// Body paragraph (14/20 regular). Grey by default; [strong] makes it dark.
class BodyText extends StatelessWidget {
  const BodyText(this.text, {super.key, this.strong = false});
  final String text;
  final bool strong;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: strong ? SinagText.bodyStrong : SinagText.body);
}

/// Tappable navy text (13/19 semibold, or 12/17 when [small]).
class TextLink extends StatelessWidget {
  const TextLink(this.text, {super.key, this.onTap, this.small = false});
  final String text;
  final VoidCallback? onTap;
  final bool small;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Text(text, style: small ? SinagText.smallStrong : SinagText.link),
  );
}
