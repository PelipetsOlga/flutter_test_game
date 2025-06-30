import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const GameApp(title: 'Flutter Demo Home Page'),
    );
  }
}
