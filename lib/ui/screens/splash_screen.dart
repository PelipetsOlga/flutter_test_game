import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_theme.dart';
import '../router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go(route_calendar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Image.asset(
            'assets/test_game_splash.png',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
} 