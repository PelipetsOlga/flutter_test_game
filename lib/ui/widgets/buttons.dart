import 'package:flutter/material.dart';
import 'package:flutter_test_game/ui/app_theme.dart';

import '../gradients.dart';
import '../styles.dart';

class GamePrimaryButton extends StatelessWidget {
  final VoidCallback onClick;
  final String title;

  const GamePrimaryButton({
    super.key,
    required this.onClick,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(FigmaHelper.px(context, 37)),
        decoration: BoxDecoration(
          gradient: orangeVerticalGradient,
          borderRadius: BorderRadius.circular(
              FigmaHelper.px(context, 100)), // Optional: add border radius
          boxShadow: [
            // Bottom shadow (darker)
            BoxShadow(
              color: const Color(0xFF002038),
              offset: const Offset(0, -12),
              blurRadius: 65,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: AppTypography.primaryButtonTitle(context),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
