class APIFriendship {
  int id;
  String username;
  int avatarId;
  bool isOnline;

  APIFriendship({
    required this.id,
    required this.username,
    required this.avatarId,
    required this.isOnline,
  });

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatarId': avatarId,
      'isOnline': isOnline,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory APIFriendship.fromJson(Map<String, dynamic> json) {
    return APIFriendship(
      id: json['id'],
      username: json['username'],
      avatarId: json['avatarId'],
      isOnline: json['isOnline'],
    );
  }
}
