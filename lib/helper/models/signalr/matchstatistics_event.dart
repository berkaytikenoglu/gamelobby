class MatchStatisticsEvent {
  DateTime? startDate;
  DateTime? endDate;
  MapInfo map;
  List<Statistic> statistics;

  MatchStatisticsEvent({
    this.startDate,
    this.endDate,
    required this.map,
    required this.statistics,
  });

  factory MatchStatisticsEvent.fromJson(Map<String, dynamic> json) {
    return MatchStatisticsEvent(
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      map: MapInfo.fromJson(json['map']),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) => Statistic.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'map': map.toJson(),
      'statistics': statistics.map((e) => e.toJson()).toList(),
    };
  }
}

class MapInfo {
  int id;
  String name;

  MapInfo({
    required this.id,
    required this.name,
  });

  factory MapInfo.fromJson(Map<String, dynamic> json) {
    return MapInfo(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Statistic {
  String teamType;
  int killCount;
  int hitCount;
  User user;

  Statistic({
    required this.teamType,
    required this.killCount,
    required this.hitCount,
    required this.user,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      teamType: json['teamType'],
      killCount: json['killCount'],
      hitCount: json['hitCount'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamType': teamType,
      'killCount': killCount,
      'hitCount': hitCount,
      'user': user.toJson(),
    };
  }
}

class User {
  String username;
  int id;
  int avatarId;

  User({
    required this.username,
    required this.id,
    required this.avatarId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      id: json['id'],
      avatarId: json['avatarId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'id': id,
      'avatarId': avatarId,
    };
  }
}
