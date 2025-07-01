import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repo/team_repository.dart';

// Events
abstract class AddGameEvent extends Equatable {
  const AddGameEvent();

  @override
  List<Object?> get props => [];
}

class LoadCountries extends AddGameEvent {}

class CountrySelected extends AddGameEvent {
  final String country;

  const CountrySelected(this.country);

  @override
  List<Object?> get props => [country];
}

class LeagueSelected extends AddGameEvent {
  final String league;

  const LeagueSelected(this.league);

  @override
  List<Object?> get props => [league];
}

class Team1Selected extends AddGameEvent {
  final String team;

  const Team1Selected(this.team);

  @override
  List<Object?> get props => [team];
}

class Team2Selected extends AddGameEvent {
  final String team;

  const Team2Selected(this.team);

  @override
  List<Object?> get props => [team];
}

class SwapTeamEvent extends AddGameEvent {
  final String? team1;
  final String? team2;

  const SwapTeamEvent({this.team1, this.team2});

  @override
  List<Object?> get props => [team1, team2];
}

class DateSelected extends AddGameEvent {
  final String date;

  const DateSelected(this.date);

  @override
  List<Object?> get props => [date];
}

// States
abstract class AddGameState extends Equatable {
  const AddGameState();

  @override
  List<Object?> get props => [];
}

class AddGameInitial extends AddGameState {}

class AddGameLoading extends AddGameState {}

class AddGameLoaded extends AddGameState {
  final List<String> countries;
  final List<String> leagues;
  final List<String> teams;
  final String? selectedCountry;
  final String? selectedLeague;
  final String? selectedTeam1;
  final String? selectedTeam2;
  final String? selectedDate;

  const AddGameLoaded({
    required this.countries,
    required this.leagues,
    required this.teams,
    this.selectedCountry,
    this.selectedLeague,
    this.selectedTeam1,
    this.selectedTeam2,
    this.selectedDate,
  });

  AddGameLoaded copyWith({
    required List<String> countries,
    required List<String> leagues,
    required List<String> teams,
    String? selectedCountry,
    String? selectedLeague,
    String? selectedTeam1,
    String? selectedTeam2,
    String? selectedDate,
  }) {
    return AddGameLoaded(
      countries: countries,
      leagues: leagues,
      teams: teams,
      selectedCountry: selectedCountry,
      selectedLeague: selectedLeague,
      selectedTeam1: selectedTeam1,
      selectedTeam2: selectedTeam2,
      selectedDate: selectedDate,
    );
  }

  @override
  List<Object?> get props => [
        countries,
        leagues,
        teams,
        selectedCountry,
        selectedLeague,
        selectedTeam1,
        selectedTeam2,
        selectedDate,
      ];
}

class AddGameError extends AddGameState {
  final String message;

  const AddGameError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AddGameBloc extends Bloc<AddGameEvent, AddGameState> {
  final TeamRepository _repository;

  AddGameBloc(this._repository) : super(AddGameInitial()) {
    on<LoadCountries>(_onLoadCountries);
    on<CountrySelected>(_onCountrySelected);
    on<LeagueSelected>(_onLeagueSelected);
    on<Team1Selected>(_onTeam1Selected);
    on<Team2Selected>(_onTeam2Selected);
    on<SwapTeamEvent>(_onSwapTeamClicked);
    on<DateSelected>(_onDateSelected);
  }

  Future<void> _onLoadCountries(
      LoadCountries event, Emitter<AddGameState> emit) async {
    emit(AddGameLoading());
    try {
      final countryLeagues = await _repository.getCountries();
      final countries = countryLeagues.map((league) => league.country).toList();
      emit(AddGameLoaded(
        countries: countries,
        leagues: [],
        teams: [],
      ));
    } catch (e) {
      emit(AddGameError(e.toString()));
    }
  }

  Future<void> _onCountrySelected(
      CountrySelected event, Emitter<AddGameState> emit) async {
    if (state is AddGameLoaded) {
      final currentState = state as AddGameLoaded;
      emit(AddGameLoading());
      try {
        final leagues =
            await _repository.getLeaguesNamesByCountry(event.country);
        emit(currentState.copyWith(
          countries: currentState.countries,
          selectedCountry: event.country,
          leagues: leagues,
          teams: [],
                  selectedLeague: null,
        selectedTeam1: null,
        selectedTeam2: null,
        selectedDate: currentState.selectedDate,
        ));
      } catch (e) {
        emit(AddGameError(e.toString()));
      }
    }
  }

  Future<void> _onLeagueSelected(
      LeagueSelected event, Emitter<AddGameState> emit) async {
    if (state is AddGameLoaded) {
      final currentState = state as AddGameLoaded;
      emit(AddGameLoading());
      try {
        final teams = await _repository.getTeamsByLeague(event.league);
        emit(currentState.copyWith(
          countries: currentState.countries,
          selectedCountry: currentState.selectedCountry,
          leagues: currentState.leagues,
          selectedLeague: event.league,
          teams: teams,
          selectedTeam1: null,
          selectedTeam2: null,
          selectedDate: currentState.selectedDate,
        ));
      } catch (e) {
        emit(AddGameError(e.toString()));
      }
    }
  }

  void _onTeam1Selected(Team1Selected event, Emitter<AddGameState> emit) {
    if (state is AddGameLoaded) {
      final currentState = state as AddGameLoaded;
      emit(currentState.copyWith(
        countries: currentState.countries,
        leagues: currentState.leagues,
        teams: currentState.teams,
        selectedCountry: currentState.selectedCountry,
        selectedLeague: currentState.selectedLeague,
        selectedTeam1: event.team,
        selectedTeam2: currentState.selectedTeam1,
        selectedDate: currentState.selectedDate,
      ));
    }
  }

  void _onTeam2Selected(Team2Selected event, Emitter<AddGameState> emit) {
    if (state is AddGameLoaded) {
      final currentState = state as AddGameLoaded;
      emit(currentState.copyWith(
        countries: currentState.countries,
        leagues: currentState.leagues,
        teams: currentState.teams,
        selectedCountry: currentState.selectedCountry,
        selectedLeague: currentState.selectedLeague,
        selectedTeam1: currentState.selectedTeam1,
        selectedTeam2: event.team,
        selectedDate: currentState.selectedDate,
      ));
    }
  }

  void _onSwapTeamClicked(
      SwapTeamEvent event, Emitter<AddGameState> emit) {
    if (state is AddGameLoaded) {
      final currentState = state as AddGameLoaded;
      emit(currentState.copyWith(
        countries: currentState.countries,
        leagues: currentState.leagues,
        teams: currentState.teams,
        selectedCountry: currentState.selectedCountry,
        selectedLeague: currentState.selectedLeague,
        selectedTeam1: event.team2,
        selectedTeam2: event.team1,
        selectedDate: currentState.selectedDate,
      ));
    }
  }

  void _onDateSelected(DateSelected event, Emitter<AddGameState> emit) {
    if (state is AddGameLoaded) {
      final currentState = state as AddGameLoaded;
      emit(currentState.copyWith(
        countries: currentState.countries,
        leagues: currentState.leagues,
        teams: currentState.teams,
        selectedCountry: currentState.selectedCountry,
        selectedLeague: currentState.selectedLeague,
        selectedTeam1: currentState.selectedTeam1,
        selectedTeam2: currentState.selectedTeam2,
        selectedDate: event.date,
      ));
    }
  }
}
