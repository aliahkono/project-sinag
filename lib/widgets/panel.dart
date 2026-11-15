import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';
import 'page_layout.dart';

/// Card colours. The colour tells the user what kind of card it is.
enum PanelTone {
  white, // normal card
  navy, // key number (e.g. "This month vs baseline")
  info, // blue: information
  success, // green: saved / resolved / savings
  warning, // amber: needs review
  danger, // red: open alert
  lightBlue, // light blue: decorative highlight (no status meaning)
}

extension PanelToneColor on PanelTone {
  Color get background => switch (this) {
    PanelTone.white => Colors.white,
    PanelTone.navy => SinagColors.navy,
    PanelTone.info => SinagColors.tintInfo,
    PanelTone.success => SinagColors.tintSuccess,
    PanelTone.warning => SinagColors.tintWarning,
    PanelTone.danger => SinagColors.tintDanger,
    PanelTone.lightBlue => SinagColors.lightBlueTint,
  };

  /// Only white and light-blue cards have a visible border.
  Color? get border => switch (this) {
    PanelTone.white => SinagColors.panelBorder,
    PanelTone.lightBlue => SinagColors.lightBlueBorder,
    _ => null,
  };
}

/// The card used for every "feature panel" in the design:
/// 18px padding, 8px between items, 8px rounded corners.
/// White cards have a faint border and soft shadow; coloured cards only a
/// 1px shadow.
///
///     Panel(
///       tone: PanelTone.info,
///       children: [
///         PanelTitle('Permissions are assigned'),
///         PanelText('Contact your LGU administrator…'),
///       ],
///     )
class Panel extends StatelessWidget {
  const Panel({
    super.key,
    required this.children,
    this.tone = PanelTone.white,
    this.padding = 18,
    this.gap = 8,
    this.onTap,
  });

  final List<Widget> children;
  final PanelTone tone;
  final double padding;
  final double gap;
  final VoidCallback? onTap;

  /// The tone of the nearest [Panel] above [context] (white if none).
  /// Text widgets use this to switch to light text on navy cards.
  static PanelTone toneOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_PanelScope>()?.tone ??
      PanelTone.white;

  /// True inside a navy card, where text must be light.
  static bool isOnNavy(BuildContext context) =>
      toneOf(context) == PanelTone.navy;

  @override
  Widget build(BuildContext context) {
    final isWhite = tone == PanelTone.white;
    final content = Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: withGaps(children, gap),
      ),
    );
    return _PanelScope(
      tone: tone,
      child: Container(
        decoration: BoxDecoration(
          color: tone.background,
          borderRadius: BorderRadius.circular(8),
          border: tone.border == null ? null : Border.all(color: tone.border!),
          boxShadow: [
            isWhite
                ? const BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  )
                : const BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 1),
                    blurRadius: 1,
                  ),
          ],
        ),
        child: onTap == null
            ? content
            : Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: onTap,
                  child: content,
                ),
              ),
      ),
    );
  }
}

/// Passes a panel's tone down to the text inside it.
class _PanelScope extends InheritedWidget {
  const _PanelScope({required this.tone, required super.child});
  final PanelTone tone;

  @override
  bool updateShouldNotify(_PanelScope old) => old.tone != tone;
}
