import 'package:flutter/material.dart';

import '../app_theme.dart';

class BaseWidget extends StatelessWidget {
  final String title;

  const BaseWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForTitle(title),
              size: 80,
              color: AppTheme.accentOrange,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'calendar':
        return Icons.calendar_month;
      case 'results':
        return Icons.percent;
      case 'add new game':
        return Icons.add;
      case 'statistics':
        return Icons.leaderboard;
      case 'settings':
        return Icons.settings;
      default:
        return Icons.home;
    }
  }
}
