class FriendstatusEvent {
  final bool isOnline;
  final int userID;

  FriendstatusEvent({required this.isOnline, required this.userID});

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'isOnline': isOnline,
      'userId': userID,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory FriendstatusEvent.fromJson(Map<String, dynamic> json) {
    return FriendstatusEvent(
      isOnline: json['isOnline'],
      userID: json['userId'],
    );
  }
}
