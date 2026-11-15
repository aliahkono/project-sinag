import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';

/// The SINAG logo: the gold-and-navy sun symbol with "SINAG" beside it.
///
///     [☀] SINAG
///
/// Used by both header bars, at different sizes. The word is real text
/// (font set in SinagText.brand), so changing the font or colour there
/// changes it everywhere.
class SinagWordmark extends StatelessWidget {
  const SinagWordmark({
    super.key,
    required this.symbolHeight,
    required this.fontSize,
    this.gap = 6,
  });

  /// Height of the sun symbol in pixels.
  final double symbolHeight;

  /// Size of the "SINAG" text in pixels.
  final double fontSize;

  /// Space between the symbol and the text.
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'SINAG',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sun symbol with the gold outer network (transparent background).
          // Made from sinag_logo.png (original colours) with the outer network
          // recoloured gold.
          Image.asset(
            'assets/images/sinag_symbol_gold.png',
            height: symbolHeight,
            filterQuality: FilterQuality.medium,
          ),
          SizedBox(width: gap),
          Text('SINAG', style: SinagText.brand(fontSize)),
        ],
      ),
    );
  }
}
