class TeamData {
  final List<League> teams;

  TeamData({required this.teams});

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      teams: (json['teams'] as List)
          .map((leagueJson) => League.fromJson(leagueJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teams': teams.map((league) => league.toJson()).toList(),
    };
  }
}

class League {
  final String league;
  final String country;
  final List<String> teams;

  League({
    required this.league,
    required this.country,
    required this.teams,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      league: json['league'] as String,
      country: json['country'] as String,
      teams: List<String>.from(json['teams']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'league': league,
      'country': country,
      'teams': teams,
    };
  }
} 