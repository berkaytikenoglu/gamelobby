class PlayerModel {
  final int id;
  final String username;
  final String avatar;
  final bool isOnline;

  PlayerModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.isOnline,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] as int,
      username: json['username'] as String,
      avatar: json['avatar'] as String,
      isOnline: json['isOnline'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatar': avatar,
      'isOnline': isOnline,
    };
  }
}
