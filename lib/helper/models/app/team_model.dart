import 'package:flutter/material.dart';

class Team {
  final int id;
  final String name;
  final Color color;
  final String logoUrl; // Takım logosu URL
  final List<String> players; // Oyuncu isimleri listesi

  Team({
    required this.id,
    required this.name,
    required this.color,
    required this.logoUrl,
    required this.players,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      color: Color(json['color'] as int),
      logoUrl: json['logoUrl'] as String,
      players: List<String>.from(json['players'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.toARGB32(), // Color'ı int olarak saklıyoruz
      'logoUrl': logoUrl,
      'players': players,
    };
  }
}
