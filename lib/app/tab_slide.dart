import 'package:flutter/material.dart';

/// Passed as the route's `arguments` when switching tabs, so the new screen
/// slides in from the side the user is moving towards.
class TabSlide {
  const TabSlide(this.direction);

  /// +1 = moving right (e.g. Bills → Review): slides in from the right.
  /// -1 = moving left (e.g. Alerts → Review): slides in from the left.
  final int direction;
}

/// Page transition for tab switches: the new screen slides in horizontally
/// from the side given by [direction] and covers the old one.
class TabSlideRoute<T> extends PageRouteBuilder<T> {
  TabSlideRoute({
    required WidgetBuilder builder,
    required this.direction,
    super.settings,
  }) : super(
         transitionDuration: const Duration(milliseconds: 280),
         reverseTransitionDuration: const Duration(milliseconds: 280),
         pageBuilder: (context, _, _) => builder(context),
         transitionsBuilder: (context, animation, _, child) => SlideTransition(
           position: Tween<Offset>(
             begin: Offset(direction.toDouble(), 0),
             end: Offset.zero,
           ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation),
           child: child,
         ),
       );

  /// +1 slides in from the right, -1 from the left.
  final int direction;
}
