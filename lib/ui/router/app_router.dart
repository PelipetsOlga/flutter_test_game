import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../screens/base_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/add_new/add_game_screen.dart';
import 'bottom_bar.dart';

const route_splash = '/splash';
const route_calendar = "/";
const route_results = '/results';
const route_add_new_game = '/add_new';
const route_statistics = '/statistic';
const route_settings = '/settings';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: route_splash,
    routes: [
      GoRoute(
        path: route_splash,
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavigation(child: child);
        },
        routes: [
          GoRoute(
            path: route_calendar,
            name: 'calendar',
            builder: (context, state) => BaseWidget(title: "calendar"),
          ),
          GoRoute(
            path: route_results,
            name: 'results',
            builder: (context, state) => BaseWidget(title: "results"),
          ),
          GoRoute(
            path: route_add_new_game,
            name: 'add_new',
            builder: (context, state) => const AddGameScreenWidget(),
          ),
          GoRoute(
            path: route_statistics,
            name: 'statistic',
            builder: (context, state) => BaseWidget(title: "Statistics"),
          ),
          GoRoute(
            path: route_settings,
            name: 'settings',
            builder: (context, state) => BaseWidget(title: "Settings"),
          ),
        ],
      ),
    ],
  );
}

class ScaffoldWithBottomNavigation extends StatefulWidget {
  const ScaffoldWithBottomNavigation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ScaffoldWithBottomNavigation> createState() =>
      _ScaffoldWithBottomNavigationState();
}

class _ScaffoldWithBottomNavigationState
    extends State<ScaffoldWithBottomNavigation> {
  int _currentIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      svgAssetPath: 'assets/icons/calendar.svg',
      label: 'Calendar',
      route: route_calendar,
    ),
    NavigationItem(
      svgAssetPath: 'assets/icons/results.svg',
      label: 'Results',
      route: route_results,
    ),
    NavigationItem(
      svgAssetPath: 'assets/icons/add_game.svg',
      label: 'Add new Game',
      route: route_add_new_game,
    ),
    NavigationItem(
      svgAssetPath: 'assets/icons/statistics.svg',
      label: 'Statistics',
      route: route_statistics,
    ),
    NavigationItem(
      svgAssetPath: 'assets/icons/settings.svg',
      label: 'Settings',
      route: route_settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      backgroundColor: AppTheme.primaryBlue,
      bottomNavigationBar: GameBottomBar(navigationItems: _navigationItems),
    );
  }
}
