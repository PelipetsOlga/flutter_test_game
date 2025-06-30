import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_theme.dart';
import '../../styles.dart';
import '../../widgets/text_spinner.dart';
import '../../../di/injection_container.dart';
import 'add_game_bloc.dart';

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
        child: BlocBuilder<AddGameBloc, AddGameState>(
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
                      context.read<AddGameBloc>().add(CountrySelected(value));
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
                      context.read<AddGameBloc>().add(LeagueSelected(value));
                    },
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Teams',
                    style: AppTypography.formLabel(context),
                  ),
                  const SizedBox(height: 17),
                  TextSpinner(
                    items: state.teams,
                    selectedValue: state.selectedTeam1,
                    onChanged: (value) {
                      context.read<AddGameBloc>().add(Team1Selected(value));
                    },
                  ),
                  const SizedBox(height: 10),
                  TextSpinner(
                    items: state.teams,
                    selectedValue: state.selectedTeam2,
                    onChanged: (value) {
                      context.read<AddGameBloc>().add(Team2Selected(value));
                    },
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Date',
                    style: AppTypography.formLabel(context),
                  ),
                  const SizedBox(height: 17),
                  TextSpinner(
                    items: ['Today', 'Tomorrow', 'Next Week'],
                    selectedValue: null,
                    onChanged: (value) {
                      print('Selected date: $value');
                    },
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
      ),
    );
  }
}
