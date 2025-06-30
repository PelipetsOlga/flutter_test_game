import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_theme.dart';
import '../screens/base_screen.dart';

const route_calendar = "/";
const route_results = '/results';
const route_add_new_game = '/add_new';
const route_statistics = '/statistic';
const route_settings = '/settings';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
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
            builder: (context, state) =>  BaseWidget(title: "results"),
          ),
          GoRoute(
            path: route_add_new_game,
            name: 'add_new',
            builder: (context, state) =>  BaseWidget(title: "Add new Game"),
          ),
          GoRoute(
            path: route_statistics,
            name: 'statistic',
            builder: (context, state) =>  BaseWidget(title: "Statistics"),
          ),
          GoRoute(
            path: route_settings,
            name: 'settings',
            builder: (context, state) =>  BaseWidget(title: "Settings"),
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
      icon: Icons.calendar_month,
      label: 'Calendar',
      route: route_calendar,
    ),
    NavigationItem(
      icon: Icons.percent,
      label: 'Results',
      route: route_results,
    ),
    NavigationItem(
      icon: Icons.add,
      label: 'Add new Game',
      route: route_add_new_game,
    ),
    NavigationItem(
      icon: Icons.leaderboard,
      label: 'Statistics',
      route: route_statistics,
    ),
    NavigationItem(
      icon: Icons.settings,
      label: 'Settings',
      route: route_settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.warmOrange,
              AppTheme.brightOrange,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navigationItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected =
                    GoRouterState.of(context).uri.path == item.route;

                return GestureDetector(
                  onTap: () {
                    if (!isSelected) {
                      context.go(item.route);
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
