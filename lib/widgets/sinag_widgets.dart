import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/routes.dart';
import '../theme/sinag_theme.dart';

// ---------------------------------------------------------------------------
// Page scaffold
// ---------------------------------------------------------------------------

enum SinagHeader { auth, app }

/// Shared screen layout: header, "Page heading" (eyebrow + title), a column of
/// feature panels (gap 14) inside a 22px padded body, and an optional bottom bar.
class SinagPage extends StatelessWidget {
  const SinagPage({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.children,
    this.header = SinagHeader.app,
    this.bottomBar,
  });

  final String eyebrow;
  final String title;
  final List<Widget> children;
  final SinagHeader header;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SinagColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            header == SinagHeader.auth
                ? const AuthHeader()
                : const SinagTopAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(eyebrow, style: SinagText.eyebrow),
                    const SizedBox(height: 6),
                    Text(title, style: SinagText.pageTitle),
                    const SizedBox(height: 16),
                    ..._gap(children, 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar == null
          ? null
          : SafeArea(top: false, child: bottomBar!),
    );
  }
}

List<Widget> _gap(List<Widget> children, double gap) {
  final out = <Widget>[];
  for (var i = 0; i < children.length; i++) {
    if (i > 0) out.add(SizedBox(height: gap));
    out.add(children[i]);
  }
  return out;
}

// ---------------------------------------------------------------------------
// Headers
// ---------------------------------------------------------------------------

/// Figma component "AuthHeader" (101:68): centred SINAG logo + wordmark.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 138,
        height: 67,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Logo frame 74x67; the image is cropped at 139.67% x 139.2%,
            // offset -19.44% from the top, exactly as in the design.
            Positioned(
              left: 0,
              top: 0,
              width: 74,
              height: 67,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topLeft,
                  maxWidth: 74 * 1.3967,
                  maxHeight: 67 * 1.392,
                  child: Transform.translate(
                    offset: const Offset(0, -67 * 0.1944),
                    child: Image.asset(
                      'assets/images/sinag_logo.png',
                      width: 74 * 1.3967,
                      height: 67 * 1.392,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 61,
              top: 0,
              bottom: 3,
              child: Center(child: Text('SINAG', style: SinagText.brand)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Figma component "TopAppBar" (101:54): logo, jurisdiction picker,
/// notifications and settings.
class SinagTopAppBar extends StatelessWidget {
  const SinagTopAppBar({
    super.key,
    this.jurisdiction = 'City Hall Complex – Building A',
  });

  final String jurisdiction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: SinagColors.appBar,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 1),
          GestureDetector(
            onTap: () =>
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.dashboard, (_) => false),
            child: Image.asset(
              'assets/images/sinag_logo_bar.png',
              width: 98,
              height: 68,
              fit: BoxFit.fill,
            ),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.of(context).pushNamed(Routes.buildings),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Figma clips the name inside a 120px box, showing whole
                  // words only ("City Hall Complex").
                  // Figma caps this at ~120-124px; 132 leaves room for Inter metrics that
                  // differ slightly by platform. One wrapped line keeps whole words and re-measures
                  // automatically once the Inter font has loaded.
                  Tooltip(
                    message: jurisdiction,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 132),
                      child: Text(
                        jurisdiction,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        textWidthBasis: TextWidthBasis.longestLine,
                        style: SinagText.button,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/images/chevron_down.svg',
                    width: 10,
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Routes.alerts),
            child: SizedBox(
              width: 16,
              height: 20,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_bell.svg',
                    width: 16,
                    height: 20,
                  ),
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: SinagColors.danger,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Routes.myAccess),
            child: SvgPicture.asset(
              'assets/images/ic_settings.svg',
              width: 20.1,
              height: 20,
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom navigation
// ---------------------------------------------------------------------------

enum SinagTab { dashboard, scanner, reports }

/// Figma component "BotNavBar" (1:2364).
class SinagBottomNav extends StatelessWidget {
  const SinagBottomNav({super.key, this.current = SinagTab.dashboard});

  final SinagTab current;

  void _go(BuildContext context, SinagTab tab) {
    if (tab == current) return;
    final route = switch (tab) {
      SinagTab.dashboard => Routes.dashboard,
      SinagTab.scanner => Routes.scanBill,
      SinagTab.reports => Routes.reports,
    };
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(left: 23, right: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D1B365D),
            offset: Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Figma has distinct active/inactive icon artwork for these tabs.
          current == SinagTab.dashboard
              ? _NavItem(
                  label: 'Dashboard',
                  icon: 'assets/images/nav_dashboard.svg',
                  iconSize: const Size(17.1, 21.1),
                  active: true,
                  onTap: () {},
                )
              : _NavItem(
                  label: 'Dashboard',
                  icon: 'assets/images/nav_dashboard_inactive.svg',
                  iconSize: const Size(18, 18),
                  labelTopPadding: 4,
                  active: false,
                  onTap: () => _go(context, SinagTab.dashboard),
                ),
          _NavItem(
            label: 'Scanner',
            icon: 'assets/images/nav_scanner.svg',
            iconSize: const Size(20, 22),
            labelTopPadding: 4,
            active: current == SinagTab.scanner,
            onTap: () => _go(context, SinagTab.scanner),
          ),
          current == SinagTab.reports
              ? _NavItem(
                  label: 'Reports',
                  icon: 'assets/images/nav_reports_active.svg',
                  iconSize: const Size(18, 18),
                  labelTopPadding: 4,
                  active: true,
                  onTap: () {},
                )
              : _NavItem(
                  label: 'Reports',
                  icon: 'assets/images/nav_reports.svg',
                  iconSize: const Size(18, 22),
                  active: false,
                  onTap: () => _go(context, SinagTab.reports),
                ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.iconSize,
    required this.active,
    required this.onTap,
    this.labelTopPadding = 0,
  });

  final String label;
  final String icon;
  final Size iconSize;
  final bool active;
  final VoidCallback onTap;
  final double labelTopPadding;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? SinagColors.navyActiveLabel
        : SinagColors.navInactive;
    // Flexible + scaleDown keeps the three tabs on one row on narrow phones.
    return Flexible(
      child: FittedBox(fit: BoxFit.scaleDown, child: _content(color)),
    );
  }

  Widget _content(Color color) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? SinagColors.navyActive.withValues(alpha: 0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: iconSize.width,
              height: iconSize.height,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(height: labelTopPadding),
            Text(label, style: SinagText.navLabel.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

/// "Role-specific navigation" bar (white strip with three small tabs).
class RoleNav extends StatelessWidget {
  const RoleNav({super.key, required this.items, required this.selected});

  /// Label → route.
  final List<(String, String)> items;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(
              child: SmallButton(
                label: items[i].$1,
                primary: i == selected,
                onPressed: i == selected
                    ? null
                    : () =>
                          Navigator.of(context)
                              .pushReplacementNamed(items[i].$2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Panels
// ---------------------------------------------------------------------------

enum PanelTone { white, navy, info, success, warning, danger }

extension on PanelTone {
  Color get background => switch (this) {
    PanelTone.white => Colors.white,
    PanelTone.navy => SinagColors.navy,
    PanelTone.info => SinagColors.tintInfo,
    PanelTone.success => SinagColors.tintSuccess,
    PanelTone.warning => SinagColors.tintWarning,
    PanelTone.danger => SinagColors.tintDanger,
  };
}

class _PanelScope extends InheritedWidget {
  const _PanelScope({required this.tone, required super.child});
  final PanelTone tone;

  static PanelTone of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_PanelScope>()?.tone ??
      PanelTone.white;

  @override
  bool updateShouldNotify(_PanelScope old) => old.tone != tone;
}

/// Card used for every "feature panel" in the design: 18px padding, 8px gap,
/// 8px radius. White panels have a hairline border and a soft shadow;
/// tinted panels only a 1px shadow.
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

  @override
  Widget build(BuildContext context) {
    final isWhite = tone == PanelTone.white;
    final content = Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _gap(children, gap),
      ),
    );
    return _PanelScope(
      tone: tone,
      child: Container(
        decoration: BoxDecoration(
          color: tone.background,
          borderRadius: BorderRadius.circular(8),
          border: isWhite ? Border.all(color: SinagColors.panelBorder) : null,
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

/// Panel heading (15/22 semibold). White on navy panels.
class PanelTitle extends StatelessWidget {
  const PanelTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final navy = _PanelScope.of(context) == PanelTone.navy;
    return Text(
      text,
      style: navy
          ? SinagText.panelTitle.copyWith(color: Colors.white)
          : SinagText.panelTitle,
    );
  }
}

/// Panel supporting text (13/19 regular muted).
class PanelText extends StatelessWidget {
  const PanelText(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final navy = _PanelScope.of(context) == PanelTone.navy;
    return Text(
      text,
      style: SinagText.panelBody.copyWith(
        color: color ?? (navy ? SinagColors.navOnNavy : null),
      ),
    );
  }
}

/// Uppercase status label (11/16 semibold).
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key, this.color = SinagColors.navy});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: SinagText.tag.copyWith(color: color));
}

/// 12/17 regular note text.
class Note extends StatelessWidget {
  const Note(this.text, {super.key, this.color, this.strong = false});
  final String text;
  final Color? color;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final navy = _PanelScope.of(context) == PanelTone.navy;
    final base = strong ? SinagText.smallStrong : SinagText.small;
    return Text(
      text,
      style: base.copyWith(
        color: color ?? (navy && !strong ? SinagColors.navOnNavy : null),
      ),
    );
  }
}

/// 11/16 regular caption text.
class Caption extends StatelessWidget {
  const Caption(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final navy = _PanelScope.of(context) == PanelTone.navy;
    return Text(
      text,
      style: SinagText.caption.copyWith(
        color: color ?? (navy ? SinagColors.navOnNavy : null),
      ),
    );
  }
}

/// 14/20 regular body copy.
class BodyText extends StatelessWidget {
  const BodyText(this.text, {super.key, this.strong = false});
  final String text;
  final bool strong;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: strong ? SinagText.bodyStrong : SinagText.body);
}

/// Label (left, muted) / value (right, semibold) row.
class KeyValue extends StatelessWidget {
  const KeyValue(this.label, this.value, {super.key, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final navy = _PanelScope.of(context) == PanelTone.navy;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: SinagText.kvLabel.copyWith(
              color: navy ? SinagColors.navOnNavy : null,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: SinagText.kvValue.copyWith(
              color: valueColor ?? (navy ? Colors.white : null),
            ),
          ),
        ),
      ],
    );
  }
}

/// Thin horizontal progress bar ("Target progress").
class SinagProgressBar extends StatelessWidget {
  const SinagProgressBar({
    super.key,
    required this.fraction,
    this.color = SinagColors.success,
    this.track = SinagColors.tintInfo,
  });

  final double fraction;
  final Color color;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 10,
        child: Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: track)),
            FractionallySizedBox(
              widthFactor: fraction.clamp(0, 1),
              heightFactor: 1,
              child: ColoredBox(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hourly metered-load bar chart ("Metered load chart"): 132px tall, bars
/// separated by 4px, with an optional shaded window. Bar heights are in design
/// pixels measured up from a baseline 12px above the bottom edge.
class LoadBarChart extends StatelessWidget {
  const LoadBarChart({
    super.key,
    required this.barHeights,
    this.barColors,
    this.shadeFrom = 8,
    this.shadeTo = 18,
    this.shadeColor = SinagColors.tintInfo,
  });

  final List<double> barHeights;

  /// Per-bar colours; defaults to navy.
  final List<Color>? barColors;

  /// Shaded window in bar-index units (e.g. hours 8–18 of a 24-bar chart).
  final double shadeFrom;
  final double shadeTo;
  final Color shadeColor;

  static const _height = 132.0;
  static const _baseline = 120.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final slot = c.maxWidth / barHeights.length;
        final barW = slot - 4;
        return Container(
          height: _height,
          color: SinagColors.chartBackground,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                left: slot * shadeFrom,
                width: slot * (shadeTo - shadeFrom),
                top: 0,
                bottom: 0,
                child: ColoredBox(color: shadeColor),
              ),
              for (var i = 0; i < barHeights.length; i++)
                Positioned(
                  left: 2 + slot * i,
                  top: _baseline - barHeights[i],
                  width: barW,
                  height: barHeights[i],
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: barColors?[i] ?? SinagColors.navy,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Fixed-width label column + description row ("Timing 18:00" rows).
class TimelineRow extends StatelessWidget {
  const TimelineRow(this.time, this.text, {super.key, this.labelWidth = 84});
  final String time;
  final String text;
  final double labelWidth;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: labelWidth,
        child: Text(time, style: SinagText.smallStrong),
      ),
      const SizedBox(width: 10),
      Expanded(child: Text(text, style: SinagText.small)),
    ],
  );
}

/// Single-choice option row (e.g. grace period "15 / 30 / 60 min").
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

/// In-page segmented tabs (e.g. "Open (2) / Resolved (8)"). Each tab is a
/// route; tapping an unselected tab replaces the current screen.
class PageTabs extends StatelessWidget {
  const PageTabs({super.key, required this.tabs, required this.selected});
  final List<(String, String)> tabs;
  final int selected;

  @override
  Widget build(BuildContext context) => SmallButtonRow(
    children: [
      for (var i = 0; i < tabs.length; i++)
        SmallButton(
          label: tabs[i].$1,
          primary: i == selected,
          onPressed: i == selected
              ? null
              : () => Navigator.of(context).pushReplacementNamed(tabs[i].$2),
        ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Buttons & inputs
// ---------------------------------------------------------------------------

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.primary,
    required this.onPressed,
    required this.padding,
    required this.radius,
    required this.style,
    this.danger = false,
  });

  final String label;
  final bool primary;
  final bool danger;
  final VoidCallback? onPressed;
  final double padding;
  final double radius;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final bg = primary
        ? (danger ? SinagColors.danger : SinagColors.navy)
        : Colors.white;
    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: primary
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
            style: style.copyWith(
              color: primary
                  ? Colors.white
                  : (danger ? SinagColors.danger : SinagColors.navy),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-width navy button (14px padding, 4px radius).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.label, {
    super.key,
    this.onPressed,
    this.danger = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool danger;

  @override
  Widget build(BuildContext context) => _Button(
    label: label,
    primary: true,
    danger: danger,
    onPressed: onPressed,
    padding: 14,
    radius: 4,
    style: SinagText.button,
  );
}

/// Full-width outlined button (14px padding, 4px radius).
class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
    this.label, {
    super.key,
    this.onPressed,
    this.danger = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool danger;

  @override
  Widget build(BuildContext context) => _Button(
    label: label,
    primary: false,
    danger: danger,
    onPressed: onPressed,
    padding: 14,
    radius: 4,
    style: SinagText.button,
  );
}

/// Compact button (12px padding, 8px radius, 12px label).
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
  Widget build(BuildContext context) => _Button(
    label: label,
    primary: primary,
    onPressed: onPressed,
    padding: 12,
    radius: 8,
    style: SinagText.smallButton,
  );
}

/// Two or more small buttons side by side.
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

/// Labelled input box (white, 1px border, 8px radius, 12px padding).
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
  final bool obscure;
  final bool readOnly;
  final TextInputType? keyboardType;

  /// Amber "check this" state used for low-confidence OCR fields.
  final bool highlight;

  /// Wraps long values onto several lines.
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

/// Inline tappable text link (13/19 semibold navy).
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

/// Shows a brief confirmation for demo actions that have no target screen.
void showSinagSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: SinagColors.navy,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
