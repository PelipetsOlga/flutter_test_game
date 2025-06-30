import '../model/league.dart';

abstract class TeamRepository {
  Future<List<League>> getCountries();

  Future<List<League>> getTeams();
  Future<List<String>> getAllTeamNames();
  Future<List<String>> getLeaguesNamesByCountry(String country);
  Future<List<League>> getLeaguesByCountry(String country);
  Future<List<String>> getTeamsByLeague(String leagueName);
} 