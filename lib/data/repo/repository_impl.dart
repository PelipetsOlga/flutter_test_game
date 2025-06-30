import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/team_data.dart';
import '../../domain/repo/team_repository.dart';
import '../../domain/model/league.dart' as domain;

class RepositoryImpl implements TeamRepository {
  static const String _assetPath = 'assets/teams.json';
  TeamData? _cachedData;

  @override
  Future<List<domain.League>> getTeams() async {
    if (_cachedData == null) {
      await _loadData();
    }
    
    return _cachedData!.teams.map((league) => domain.League(
      league: league.league,
      country: league.country,
      teams: league.teams,
    )).toList();
  }

  @override
  Future<List<String>> getAllTeamNames() async {
    final leagues = await getTeams();
    final allTeams = <String>[];
    
    for (final league in leagues) {
      allTeams.addAll(league.teams);
    }
    
    return allTeams;
  }

  @override
  Future<List<domain.League>> getLeaguesByCountry(String country) async {
    final leagues = await getTeams();
    return leagues.where((league) => 
      league.country.toLowerCase() == country.toLowerCase()
    ).toList();
  }

  @override
  Future<List<String>> getTeamsByLeague(String leagueName) async {
    final leagues = await getTeams();
    final league = leagues.firstWhere(
      (league) => league.league.toLowerCase() == leagueName.toLowerCase(),
      orElse: () => domain.League(league: '', country: '', teams: []),
    );
    
    return league.teams;
  }

  Future<void> _loadData() async {
    try {
      final jsonString = await rootBundle.loadString(_assetPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      _cachedData = TeamData.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load teams data: $e');
    }
  }

  @override
  Future<List<domain.League>> getCountries() async {
    if (_cachedData == null) {
      await _loadData();
    }
    
    // Get unique countries from the data
    final countries = <String>{};
    for (final league in _cachedData!.teams) {
      countries.add(league.country);
    }
    
    // Convert to League objects with empty teams list
    return countries.map((country) => domain.League(
      league: '',
      country: country,
      teams: [],
    )).toList();
  }

  @override
  Future<List<String>> getLeaguesNamesByCountry(String country) async {
    if (_cachedData == null) {
      await _loadData();
    }
    
    // Get league names for the specified country
    final leagues = _cachedData!.teams.where((league) => 
      league.country.toLowerCase() == country.toLowerCase()
    ).map((league) => league.league).toList();
    
    return leagues;
  }
} 