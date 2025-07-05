import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../gradients.dart';
import '../../styles.dart';
import '../../widgets/buttons.dart';

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
  String _searchQuery = '';
  List<String> _filteredTeams = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedTeam = widget.selectedTeam;
    _filteredTeams = widget.teams;
  }

  void _filterTeams(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredTeams = widget.teams;
      } else {
        _filteredTeams = widget.teams
            .where((team) => team.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.75;

    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        gradient: spinnerGradient,
      ),
      child: Column(
        children: [
          _getToolbar(context),

          // Search widget
          _getSearchWidget(context),

          // Teams list
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTeams.length,
              itemBuilder: (context, index) {
                final team = _filteredTeams[index];
                final isSelected = team == _tempSelectedTeam;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _tempSelectedTeam = team;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    // margin: EdgeInsets.symmetric(
                    //   horizontal: FigmaHelper.px(context, 20),
                    //   vertical: FigmaHelper.px(context, 4),
                    // ),
                    padding: EdgeInsets.symmetric(
                      horizontal: FigmaHelper.px(context, 63),
                      vertical: FigmaHelper.px(context, 23),
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppTheme.darkBlue : AppTheme.lightBlue,
                      // borderRadius:
                      //     BorderRadius.circular(FigmaHelper.px(context, 22)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: FigmaHelper.px(context, 50),
                          ),
                          child: Container(
                            width: FigmaHelper.px(context, 40),
                            height: FigmaHelper.px(context, 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF699AD0),
                                width: FigmaHelper.px(context, 5),
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: FigmaHelper.px(context, 21),
                                      height: FigmaHelper.px(context, 21),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF54524),
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            team,
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w400,
                              fontSize: FigmaHelper.px(context, 38.6),
                              height: 48.25 / 38.6,
                              // line-height: 48.25px
                              letterSpacing: 0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Apply button
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
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

          // Bottom padding for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Container _getSearchWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.lightBlue,
      padding: EdgeInsets.symmetric(
        horizontal: FigmaHelper.px(context, 60),
        vertical: FigmaHelper.px(context, 60),
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                TextField(
                  onChanged: _filterTeams,
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                    fontSize: FigmaHelper.px(context, 28.95),
                    letterSpacing: 0.24,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: const Color(0xFFDFE3EA),
                      size: FigmaHelper.px(context, 44),
                    ),
                    hintText: '',
                    filled: true,
                    fillColor: AppTheme.darkBlue,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(FigmaHelper.px(context, 150)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(FigmaHelper.px(context, 150)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(FigmaHelper.px(context, 150)),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(FigmaHelper.px(context, 150)),
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(FigmaHelper.px(context, 150)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: FigmaHelper.px(context, 72),
                      vertical: FigmaHelper.px(context, 38),
                    ),
                  ),
                ),
                if (_searchQuery.isEmpty)
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: FigmaHelper.px(context, 72),
                        vertical: FigmaHelper.px(context, 52),
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                            fontSize: FigmaHelper.px(context, 28.95),
                            letterSpacing: 0.24,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(text: 'Type it in manually, for example "'),
                            TextSpan(
                              text: 'Arsenal',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            TextSpan(text: '"'),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: FigmaHelper.px(context, 15)),
        ],
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return Container(
      color: AppTheme.darkBlue,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: FigmaHelper.px(context, 41),
                  horizontal: FigmaHelper.px(context, 60)),
              child: Text(
                'Select a program from the list',
                style: AppTypography.toolbarText(context),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.close,
                color: const Color(0xFF699AD0),
                size: 16,
              ),
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
