import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/injection_container.dart';
import '../../app_theme.dart';
import '../../styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/date_picker_spinner.dart';
import '../../widgets/svg_icon.dart';
import '../../widgets/text_spinner.dart';
import '../../widgets/toast.dart';
import 'add_game_bloc.dart';
import 'team_spinner.dart';

class AddGameScreenWidget extends StatelessWidget {
  const AddGameScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddGameBloc>()..add(LoadCountries()),
      child: const AddGameView(),
    );
  }
}

class AddGameView extends StatelessWidget {
  const AddGameView({super.key});

  void _showSaveToast(BuildContext context, AddGameLoaded state) {
    final List<String> gameParams = [];

    gameParams.add('Country: ${state.selectedCountry ?? 'Not selected'}');
    gameParams.add('League: ${state.selectedLeague ?? 'Not selected'}');
    gameParams.add('Team 1: ${state.selectedTeam1 ?? 'Not selected'}');
    gameParams.add('Team 2: ${state.selectedTeam2 ?? 'Not selected'}');
    gameParams.add('Date: ${state.selectedDate ?? 'Not selected'}');

    final message = 'Game is saved: ${gameParams.join(', ')}';

    showToast(message, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddGameBloc, AddGameState>(
        builder: (context, state) {
          if (state is AddGameLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (state is AddGameError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (state is AddGameLoaded) {
            return Column(
              children: [
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: FigmaHelper.px(context, 60),
                      right: FigmaHelper.px(context, 60),
                      top: FigmaHelper.px(context, 110),
                      bottom: FigmaHelper.px(context, 20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add New Matches',
                          style: AppTypography.rootTabScreenTitle(context),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Country',
                          style: AppTypography.formLabel(context),
                        ),
                        const SizedBox(height: 17),
                        TextSpinner(
                          items: state.countries,
                          selectedValue: state.selectedCountry,
                          onChanged: (value) {
                            context
                                .read<AddGameBloc>()
                                .add(CountrySelected(value));
                          },
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Leagues',
                          style: AppTypography.formLabel(context),
                        ),
                        const SizedBox(height: 17),
                        TextSpinner(
                          items: state.leagues,
                          selectedValue: state.selectedLeague,
                          onChanged: (value) {
                            context
                                .read<AddGameBloc>()
                                .add(LeagueSelected(value));
                          },
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Teams',
                          style: AppTypography.formLabel(context),
                        ),
                        const SizedBox(height: 17),
                        Stack(
                          children: [
                            Column(
                              children: [
                                TeamSpinner(
                                  teams: state.teams,
                                  selectedTeam: state.selectedTeam1,
                                  onTeamSelected: (value) {
                                    context
                                        .read<AddGameBloc>()
                                        .add(Team1Selected(value));
                                  },
                                ),
                                const SizedBox(height: 10),
                                TeamSpinner(
                                  teams: state.teams,
                                  selectedTeam: state.selectedTeam2,
                                  onTeamSelected: (value) {
                                    context
                                        .read<AddGameBloc>()
                                        .add(Team2Selected(value));
                                  },
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AddGameBloc>()
                                        .add(SwapTeamEvent(
                                          team1: state.selectedTeam1,
                                          team2: state.selectedTeam2,
                                        ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: FigmaHelper.px(context, 127)),
                                    child: CustomSvgIcon(
                                      assetPath:
                                          'assets/icons/change_team_btn.svg',
                                      size: FigmaHelper.iconSize(context, 68),
                                      color: null,
                                      isSelected: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Date',
                          style: AppTypography.formLabel(context),
                        ),
                        const SizedBox(height: 17),
                        DatePickerSpinner(
                          selectedDate: state.selectedDate,
                          onDateSelected: (date) {
                            context.read<AddGameBloc>().add(DateSelected(date));
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Save button pinned to bottom
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: FigmaHelper.px(context, 60),
                    right: FigmaHelper.px(context, 60),
                    top: 16,
                    bottom: FigmaHelper.px(context, 50),
                  ),
                  child: GamePrimaryButton(
                    onClick: () {
                      if (state.selectedCountry != null &&
                          state.selectedLeague != null &&
                          state.selectedTeam1 != null &&
                          state.selectedTeam2 != null &&
                          state.selectedDate != null) {
                        _showSaveToast(context, state);
                      }
                    },
                    title: "Save",
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
