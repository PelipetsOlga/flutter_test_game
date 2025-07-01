import 'package:flutter/material.dart';
import 'package:flutter_test_game/ui/widgets/svg_icon.dart';

import '../app_theme.dart';
import '../gradients.dart';
import '../styles.dart';
import 'team_selection_bottom_sheet.dart';

class TeamSpinner extends StatelessWidget {
  final List<String> teams;
  final String? selectedTeam;
  final Function(String) onTeamSelected;

  const TeamSpinner({
    super.key,
    required this.teams,
    this.selectedTeam,
    required this.onTeamSelected,
  });

  Widget _arrowDown(BuildContext context) => CustomSvgIcon(
        assetPath: 'assets/icons/triangle_arrow_down.svg',
        size: FigmaHelper.iconSize(context, 29),
        color: AppTheme.white,
        isSelected: true,
      );

  void _showTeamSelectionBottomSheet(BuildContext context) {
    showTeamSelectionBottomSheet(
      context: context,
      teams: teams,
      selectedTeam: selectedTeam,
      onTeamSelected: onTeamSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (teams.isEmpty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: spinnerGradient,
          borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: FigmaHelper.px(context, 34),
            vertical: FigmaHelper.px(context, 45),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Select...',
                  style: AppTypography.spinnerTitle(context),
                ),
              ),
              _arrowDown(context),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showTeamSelectionBottomSheet(context),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: spinnerGradient,
          borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: FigmaHelper.px(context, 45),
            vertical: FigmaHelper.px(context, 34),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  selectedTeam ?? 'Select...',
                  style: AppTypography.spinnerTitle(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _arrowDown(context),
            ],
          ),
        ),
      ),
    );
  }
} 