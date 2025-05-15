import 'package:gamelobby/helper/models/api/friendship.dart';

class APIFriendinvitations {
  int id;
  APIFriendship invitor;

  APIFriendinvitations({
    required this.id,
    required this.invitor,
  });

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invitor': invitor.toJson(),
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory APIFriendinvitations.fromJson(Map<String, dynamic> json) {
    return APIFriendinvitations(
      id: json['id'],
      invitor: APIFriendship.fromJson(json['invitor']),
    );
  }
}
