import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../styles.dart';
import '../../widgets/text_spinner.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: FigmaHelper.px(context, 12),
                  height: FigmaHelper.px(context, 62),
                  color: AppTheme.accentOrange,
                ),
                SizedBox(width: FigmaHelper.px(context, 31)),
                Text(
                  'Add New Matches',
                  style: AppTypography.rootTabScreenTitle(context),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              'Country',
              style: AppTypography.formLabel(context),
            ),
            const SizedBox(height: 17),
            TextSpinner(
              items: ['England', 'Spain', 'Germany', 'Italy', 'France', 'Netherlands'],
              selectedValue: 'England',
              onChanged: (value) {
                print('Selected country: $value');
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Leagues',
              style: AppTypography.formLabel(context),
            ),
            const SizedBox(height: 17),
            TextSpinner(
              items: ['England', 'Spain', 'Germany', 'Italy', 'France', 'Netherlands'],
              selectedValue: 'England',
              onChanged: (value) {
                print('Selected country: $value');
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Teams',
              style: AppTypography.formLabel(context),
            ),
            const SizedBox(height: 17),
            TextSpinner(
              items: ['England', 'Spain', 'Germany', 'Italy', 'France', 'Netherlands'],
              selectedValue: 'England',
              onChanged: (value) {
                print('Selected country: $value');
              },
            ),
            const SizedBox(height: 10),
            TextSpinner(
              items: ['England', 'Spain', 'Germany', 'Italy', 'France', 'Netherlands'],
              selectedValue: 'England',
              onChanged: (value) {
                print('Selected country: $value');
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Date',
              style: AppTypography.formLabel(context),
            ),
            const SizedBox(height: 17),
            TextSpinner(
              items: ['England', 'Spain', 'Germany', 'Italy', 'France', 'Netherlands'],
              selectedValue: 'England',
              onChanged: (value) {
                print('Selected country: $value');
              },
            ),
            // More content will be added here
          ],
        ),
      ),
    );
  }
}
