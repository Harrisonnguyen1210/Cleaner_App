import 'package:cleaner_app/route_names.dart';
import 'package:flutter/material.dart';

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == RouteNames.overview) {
      return child;
    }
    return FadeTransition(opacity: animation, child: child);
  }
}
