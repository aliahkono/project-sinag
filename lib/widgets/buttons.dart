import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';

// The three button sizes in the design:
//
//   PrimaryButton    full width, navy        (the main action of a screen)
//   SecondaryButton  full width, outlined    (other actions)
//   SmallButton      compact, outlined/navy  (shortcuts, tabs, option rows)

/// Full-width navy button (14px padding, 4px corners).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.label, {
    super.key,
    this.onPressed,
    this.danger = false,
  });
  final String label;
  final VoidCallback? onPressed;

  /// Red instead of navy.
  final bool danger;

  @override
  Widget build(BuildContext context) => _SinagButton(
    label: label,
    filled: true,
    danger: danger,
    onPressed: onPressed,
    padding: 14,
    radius: 4,
    style: SinagText.button,
  );
}

/// Full-width white button with a grey border (14px padding, 4px corners).
class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
    this.label, {
    super.key,
    this.onPressed,
    this.danger = false,
  });
  final String label;
  final VoidCallback? onPressed;

  /// Red text instead of navy.
  final bool danger;

  @override
  Widget build(BuildContext context) => _SinagButton(
    label: label,
    filled: false,
    danger: danger,
    onPressed: onPressed,
    padding: 14,
    radius: 4,
    style: SinagText.button,
  );
}

/// Compact button (12px padding, 8px corners, 12px label).
/// [primary] makes it navy, e.g. the selected tab.
class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.label,
    this.primary = false,
    this.onPressed,
  });

  final String label;
  final bool primary;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => _SinagButton(
    label: label,
    filled: primary,
    onPressed: onPressed,
    padding: 12,
    radius: 8,
    style: SinagText.smallButton,
  );
}

/// Two or more small buttons side by side, sharing the width equally.
class SmallButtonRow extends StatelessWidget {
  const SmallButtonRow({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var i = 0; i < children.length; i++) ...[
        if (i > 0) const SizedBox(width: 8),
        Expanded(child: children[i]),
      ],
    ],
  );
}

/// Shared drawing for all buttons above.
class _SinagButton extends StatelessWidget {
  const _SinagButton({
    required this.label,
    required this.filled,
    required this.onPressed,
    required this.padding,
    required this.radius,
    required this.style,
    this.danger = false,
  });

  final String label;
  final bool filled;
  final bool danger;
  final VoidCallback? onPressed;
  final double padding;
  final double radius;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final accent = danger ? SinagColors.danger : SinagColors.navy;
    return Material(
      color: filled ? accent : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: filled
            ? BorderSide.none
            : const BorderSide(color: SinagColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed ?? () {},
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: style.copyWith(color: filled ? Colors.white : accent),
          ),
        ),
      ),
    );
  }
}
