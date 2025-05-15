class APIFriendsearch {
  int id;
  String username;
  int avatarId;

  APIFriendsearch({
    required this.id,
    required this.username,
    required this.avatarId,
  });

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatarId': avatarId,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory APIFriendsearch.fromJson(Map<String, dynamic> json) {
    return APIFriendsearch(
      id: json['id'],
      username: json['username'],
      avatarId: json['avatarId'],
    );
  }
}
