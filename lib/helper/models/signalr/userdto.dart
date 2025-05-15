class Userdto {
  final int userId;
  final String username;
  final int avatarId;
  final bool isOnline;

  Userdto(
      {required this.userId,
      required this.username,
      required this.avatarId,
      required this.isOnline});

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'username': username,
      'avatarId': avatarId,
      'isOnline': isOnline,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory Userdto.fromJson(Map<String, dynamic> json) {
    return Userdto(
      userId: json['id'],
      username: json['username'],
      avatarId: json['avatarId'],
      isOnline: json['isOnline'],
    );
  }
}
