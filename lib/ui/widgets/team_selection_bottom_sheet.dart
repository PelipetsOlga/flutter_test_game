import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../gradients.dart';
import 'buttons.dart';

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
  State<TeamSelectionBottomSheet> createState() =>
      _TeamSelectionBottomSheetState();
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

          // Toolbar
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: FigmaHelper.px(context, 60),
              vertical: FigmaHelper.px(context, 20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Select a program from the list',
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
                Padding(
                  padding: EdgeInsets.only(right: FigmaHelper.px(context, 50)),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: FigmaHelper.px(context, 27),
                      height: FigmaHelper.px(context, 27),
                      decoration: BoxDecoration(
                        color: const Color(0xFF699AD0),
                        borderRadius: BorderRadius.circular(
                            FigmaHelper.px(context, 13.5)),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Teams list
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: FigmaHelper.px(context, 60),
              ),
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
                      margin: EdgeInsets.only(
                        bottom: FigmaHelper.px(context, 8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: FigmaHelper.px(context, 20),
                        vertical: FigmaHelper.px(context, 15),
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(FigmaHelper.px(context, 22)),
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
          ),

          // Apply button - pinned to bottom
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: FigmaHelper.px(context, 60),
              right: FigmaHelper.px(context, 60),
              top: FigmaHelper.px(context, 16),
              bottom: FigmaHelper.px(context, 50),
            ),
            child: GamePrimaryButton(
              onClick: _tempSelectedTeam != null
                  ? () {
                      if (_tempSelectedTeam != null) {
                        widget.onTeamSelected(_tempSelectedTeam!);
                        Navigator.of(context).pop();
                      }
                    }
                  : () {},
              title: "Apply",
            ),
          ),
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
