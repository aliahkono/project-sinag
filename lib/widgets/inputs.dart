import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';
import 'buttons.dart';

/// Labelled text box: small grey label on top, editable value below.
/// White, 1px border, 8px corners, 12px padding.
///
///     SinagField(label: 'Work email', initialValue: 'eec.officer@…')
class SinagField extends StatelessWidget {
  const SinagField({
    super.key,
    required this.label,
    required this.initialValue,
    this.obscure = false,
    this.readOnly = false,
    this.keyboardType,
    this.highlight = false,
    this.multiline = false,
  });

  final String label;
  final String initialValue;

  /// Hide the value with dots (passwords).
  final bool obscure;
  final bool readOnly;
  final TextInputType? keyboardType;

  /// Amber "please check this" look, used for low-confidence OCR fields.
  final bool highlight;

  /// Let long values wrap onto several lines.
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlight ? SinagColors.tintWarning : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlight ? SinagColors.warningBorder : SinagColors.border,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: highlight
                ? SinagText.fieldLabel.copyWith(color: SinagColors.warning)
                : SinagText.fieldLabel,
          ),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: initialValue,
            obscureText: obscure,
            obscuringCharacter: '•',
            readOnly: readOnly,
            keyboardType: multiline ? TextInputType.multiline : keyboardType,
            maxLines: multiline ? null : 1,
            style: SinagText.fieldValue,
            cursorColor: SinagColors.navy,
            decoration: const InputDecoration.collapsed(hintText: ''),
          ),
        ],
      ),
    );
  }
}

/// A row of small buttons where exactly one is selected,
/// e.g. the grace period "15 min / 30 min / 60 min".
class OptionChips extends StatefulWidget {
  const OptionChips({
    super.key,
    required this.options,
    this.initial = 0,
    this.onChanged,
    this.gap = 6,
  });

  final List<String> options;
  final int initial;
  final ValueChanged<int>? onChanged;
  final double gap;

  @override
  State<OptionChips> createState() => _OptionChipsState();
}

class _OptionChipsState extends State<OptionChips> {
  late int _selected = widget.initial;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var i = 0; i < widget.options.length; i++) ...[
        if (i > 0) SizedBox(width: widget.gap),
        Expanded(
          child: SmallButton(
            label: widget.options[i],
            primary: i == _selected,
            onPressed: () {
              setState(() => _selected = i);
              widget.onChanged?.call(i);
            },
          ),
        ),
      ],
    ],
  );
}
