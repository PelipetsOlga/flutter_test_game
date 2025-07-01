import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../gradients.dart';
import '../styles.dart';
import 'svg_icon.dart';

class TeamSelectionBottomSheet extends StatefulWidget {
  final List<String> teams;
  final String? selectedTeam;
  final Function(String) onTeamSelected;

  const TeamSelectionBottomSheet({
    super.key,
    required this.teams,
    this.selectedTeam,
    required this.onTeamSelected,
  });

  @override
  State<TeamSelectionBottomSheet> createState() => _TeamSelectionBottomSheetState();
}

class _TeamSelectionBottomSheetState extends State<TeamSelectionBottomSheet> {
  String? _tempSelectedTeam;

  @override
  void initState() {
    super.initState();
    _tempSelectedTeam = widget.selectedTeam;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.75;
    
    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        gradient: spinnerGradient,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Title
          Padding(
            padding: EdgeInsets.only(
              top: FigmaHelper.px(context, 24),
              bottom: FigmaHelper.px(context, 20),
            ),
            child: Text(
              'Select Team',
              style: AppTypography.formLabel(context),
            ),
          ),
          
          // Teams list
          Expanded(
            child: ListView.builder(
              itemCount: widget.teams.length,
              itemBuilder: (context, index) {
                final team = widget.teams[index];
                final isSelected = team == _tempSelectedTeam;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _tempSelectedTeam = team;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: FigmaHelper.px(context, 20),
                      vertical: FigmaHelper.px(context, 4),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: FigmaHelper.px(context, 20),
                      vertical: FigmaHelper.px(context, 15),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(FigmaHelper.px(context, 22)),
                    ),
                    child: Text(
                      team,
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                        fontSize: FigmaHelper.px(context, 52),
                        height: 1.0,
                        letterSpacing: -0.02,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Apply button
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(FigmaHelper.px(context, 20)),
            child: GestureDetector(
              onTap: _tempSelectedTeam != null
                  ? () {
                      if (_tempSelectedTeam != null) {
                        widget.onTeamSelected(_tempSelectedTeam!);
                        Navigator.of(context).pop();
                      }
                    }
                  : null,
              child: CustomSvgIcon(
                assetPath: 'assets/icons/apply_btn.svg',
                size: FigmaHelper.iconSize(context, 120),
                color: null,
                isSelected: false,
              ),
            ),
          ),
          
          // Bottom padding for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

// Helper function to show the bottom sheet
void showTeamSelectionBottomSheet({
  required BuildContext context,
  required List<String> teams,
  String? selectedTeam,
  required Function(String) onTeamSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => TeamSelectionBottomSheet(
      teams: teams,
      selectedTeam: selectedTeam,
      onTeamSelected: onTeamSelected,
    ),
  );
} 