import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';
import 'back_button.dart';
import 'wordmark.dart';

/// Figma component "AuthHeader" (101:68): 91px bar with the SINAG logo
/// and wordmark centred. Shown on the sign-in screens (01–04).
/// A back arrow appears on the left when there is a previous screen.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91,
      width: double.infinity, // full screen width
      decoration: const BoxDecoration(
        color: SinagColors.lightBlueTint, // light blue (Figma: white)
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          // Logo, centred. Symbol ~56px tall as in Figma; "SINAG" in Cinzel.
          const Center(
            child: SinagWordmark(symbolHeight: 56, fontSize: 24, gap: 8),
          ),
          // Back arrow, left side (hidden on the first screen). Listed last
          // so it sits on top and is always tappable.
          const Positioned(left: 8, child: SinagBackButton()),
        ],
      ),
    );
  }
}
