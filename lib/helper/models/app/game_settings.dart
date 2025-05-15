enum GameType {
  standard, // Standart Oyun
  deathmatch, // Ölüm Savaşı
}

class GameSettings {
  int startMoney; // Başlangıç parası
  int startHealth; // Başlangıç sağlığı
  double gravity; // Yer çekimi
  int waitTime; // Bekleme süresi (saniye)
  int respawnTime; // Yeniden doğma süresi (saniye)
  GameType gameType; // Oyun modu

  GameSettings({
    this.startMoney = 500,
    this.startHealth = 100,
    this.gravity = 1,
    this.waitTime = 5,
    this.respawnTime = 15,
    this.gameType = GameType.standard,
  });

  factory GameSettings.fromJson(Map<String, dynamic> json) {
    return GameSettings(
      startMoney: json['startMoney'] as int,
      startHealth: json['startHealth'] as int,
      gravity: (json['gravity'] as num).toDouble(),
      waitTime: json['waitTime'] as int,
      respawnTime: json['respawnTime'] as int,
      gameType: GameType.values.firstWhere(
        (e) => e.toString().split('.').last == json['gameType'],
        orElse: () => GameType.standard,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startMoney': startMoney,
      'startHealth': startHealth,
      'gravity': gravity,
      'waitTime': waitTime,
      'respawnTime': respawnTime,
      'gameType': gameType.toString().split('.').last,
    };
  }
}
