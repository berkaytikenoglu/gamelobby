import 'package:gamelobby/helper/models/app/game_settings.dart';
import 'package:gamelobby/helper/models/app/team_model.dart';

class Game {
  final String name; // Oyun adı
  final GameSettings settings; // Oyun ayarları
  final List<Team> teams; // Takımlar listesi

  Game({
    required this.name,
    required this.settings,
    required this.teams,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'] as String,
      settings: GameSettings.fromJson(json['settings'] as Map<String, dynamic>),
      teams: (json['teams'] as List)
          .map((teamJson) => Team.fromJson(teamJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'settings': settings.toJson(),
      'teams': teams.map((team) => team.toJson()).toList(),
    };
  }
}
