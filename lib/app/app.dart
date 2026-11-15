import 'package:flutter/material.dart';

import '../theme/sinag_theme.dart';
import 'route_table.dart';
import 'routes.dart';
import 'tab_slide.dart';

/// The SINAG app: theme + screens. Opens on 01 · Sign in.
class SinagApp extends StatelessWidget {
  const SinagApp({super.key, this.initialRoute = Routes.signIn});

  /// Screen to open first. Tests use this to open any screen directly.
  final String initialRoute;

  /// Builds the page for a route name. Tab switches (opened with a
  /// [TabSlide] argument) slide in sideways; everything else uses the
  /// normal page transition.
  static Route<dynamic>? _buildRoute(RouteSettings settings) {
    final builder = sinagRoutes[settings.name];
    if (builder == null) return null;
    final slide = settings.arguments;
    if (slide is TabSlide && slide.direction != 0) {
      return TabSlideRoute<dynamic>(
        builder: builder,
        direction: slide.direction,
        settings: settings,
      );
    }
    return MaterialPageRoute<dynamic>(builder: builder, settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SINAG',
      debugShowCheckedModeBanner: false,
      theme: buildSinagTheme(),
      initialRoute: initialRoute,
      onGenerateRoute: _buildRoute,
    );
  }
}
