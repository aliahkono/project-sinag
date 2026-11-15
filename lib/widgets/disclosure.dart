import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';
import 'page_layout.dart';
import 'panel.dart';

// Widgets that keep screens light: secondary information stays available
// but only shows when the user asks for it.

/// "See details ▾" inside a card. The [children] (breakdowns, extra rows,
/// notes) stay hidden until tapped, then "Hide details ▴" folds them away.
///
///     Panel(children: [
///       PanelTitle('This month vs baseline'),
///       Text('5,100 kWh'),
///       MoreDetails(children: [KeyValue(...), KeyValue(...)]),
///     ])
class MoreDetails extends StatefulWidget {
  const MoreDetails({
    super.key,
    required this.children,
    this.label = 'See details',
    this.initiallyOpen = false,
  });

  final List<Widget> children;

  /// Text on the closed toggle, e.g. "See breakdown".
  final String label;
  final bool initiallyOpen;

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final onNavy = Panel.isOnNavy(context);
    final color = onNavy ? SinagColors.navOnNavy : SinagColors.navy;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          expanded: _open,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text(
                    _open ? 'Hide details' : widget.label,
                    style: SinagText.smallStrong.copyWith(color: color),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _open ? Icons.expand_less : Icons.expand_more,
                    size: 18,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Animate open/close so the card doesn't jump.
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: _open
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: withGaps(widget.children, 8),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

/// Small ⓘ button. Tapping it opens a panel from the bottom of the screen
/// with [title] and [lines] of explanation.
class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.title,
    required this.lines,
    this.size = 18,
  });

  final String title;
  final List<String> lines;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = Panel.isOnNavy(context)
        ? SinagColors.navOnNavy
        : SinagColors.muted;
    return IconButton(
      tooltip: title,
      onPressed: () => showInfoSheet(context, title: title, lines: lines),
      icon: Icon(Icons.info_outline, size: size, color: color),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: BoxConstraints.tightFor(width: size + 14, height: size + 14),
    );
  }
}

/// A card title with an ⓘ beside it that explains a term or figure.
class PanelTitleWithInfo extends StatelessWidget {
  const PanelTitleWithInfo(
    this.text, {
    super.key,
    required this.infoTitle,
    required this.info,
  });

  final String text;
  final String infoTitle;
  final List<String> info;

  @override
  Widget build(BuildContext context) {
    final style = Panel.isOnNavy(context)
        ? SinagText.panelTitle.copyWith(color: Colors.white)
        : SinagText.panelTitle;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: Text(text, style: style)),
        InfoButton(title: infoTitle, lines: info, size: 16),
      ],
    );
  }
}

/// Opens the explanation panel used by [InfoButton] and the page's ⓘ.
void showInfoSheet(
  BuildContext context, {
  required String title,
  required List<String> lines,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: SinagText.panelTitle),
            const SizedBox(height: 10),
            ...withGaps([
              for (final line in lines) Text(line, style: SinagText.body),
            ], 10),
          ],
        ),
      ),
    ),
  );
}
