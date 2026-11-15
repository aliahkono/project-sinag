import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';
import 'panel.dart';

// Widgets that show numbers and readings.

/// Label on the left (grey), value on the right (semibold navy):
///
///     Last reading                     12 Nov · 09:40
class KeyValue extends StatelessWidget {
  const KeyValue(this.label, this.value, {super.key, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final onNavy = Panel.isOnNavy(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: SinagText.kvLabel.copyWith(
              color: onNavy ? SinagColors.navOnNavy : null,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: SinagText.kvValue.copyWith(
              color: valueColor ?? (onNavy ? Colors.white : null),
            ),
          ),
        ),
      ],
    );
  }
}

/// Thin 10px progress bar, e.g. savings towards the 20% target.
/// [fraction] goes from 0 (empty) to 1 (full).
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

/// Hourly load bar chart ("Metered load chart"): 132px tall, 4px between
/// bars, with an optional shaded window (e.g. office hours).
/// Bar heights are in pixels, measured up from 12px above the bottom.
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

  /// One colour per bar; navy if not given.
  final List<Color>? barColors;

  /// Shaded window, in bars (e.g. hours 8–18 of a 24-bar chart).
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

/// Time on the left (fixed width), description on the right:
///
///     18:00          Detected above 0.10 kW after office hours
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
