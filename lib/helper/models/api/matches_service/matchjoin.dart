class Matchjoin {
  final int matchId;
  final MapDTO map;

  Matchjoin({required this.map, required this.matchId});

  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'map': map.toJson(),
    };
  }

  factory Matchjoin.fromJson(Map<String, dynamic> json) {
    return Matchjoin(
      matchId: json['matchId'],
      map: MapDTO.fromJson(json['map']),
    );
  }
}

class MapDTO {
  final String name;

  MapDTO({required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory MapDTO.fromJson(Map<String, dynamic> json) {
    return MapDTO(
      name: json['name'],
    );
  }
}
