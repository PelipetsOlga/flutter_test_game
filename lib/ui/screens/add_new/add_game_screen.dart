import 'package:flutter/material.dart';
import '../../app_theme.dart';

class AddGameScreenWidget extends StatelessWidget {
  const AddGameScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        padding: EdgeInsets.only(
          left: FigmaHelper.px(context, 60),
          right: FigmaHelper.px(context, 60),
          top: FigmaHelper.px(context, 110),
          bottom: FigmaHelper.px(context, 50),
        ),
        child: const Center(
          child: Text(
            'Add new matches screen content will go here',
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
