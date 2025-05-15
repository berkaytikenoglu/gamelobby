import 'package:gamelobby/helper/models/app/game_model.dart';

class MapModel {
  final int id;
  final String name;
  final String img;
  final int playerLimit;
  final Game game;

  MapModel({
    required this.id,
    required this.name,
    required this.img,
    required this.playerLimit,
    required this.game,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      id: json['id'] as int,
      name: json['name'] as String,
      img: json['img'] as String,
      playerLimit: json['playerLimit'] as int,
      game: Game.fromJson(json['game']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'playerLimit': playerLimit,
      'game': game.toJson(),
    };
  }
}
