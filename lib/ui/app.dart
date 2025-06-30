import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Football Game',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
