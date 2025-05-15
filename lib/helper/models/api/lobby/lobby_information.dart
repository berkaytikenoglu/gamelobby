import 'package:gamelobby/helper/models/signalr/userdto.dart';

class LobbyInformation {
  final int lobbyId;
  final List<Userdto> users;
  final Userdto owner;

  LobbyInformation({
    required this.lobbyId,
    required this.users,
    required this.owner,
  });

  factory LobbyInformation.fromJson(Map<String, dynamic> json) {
    return LobbyInformation(
      lobbyId: json['id'],
      users: (json['users'] as List<dynamic>)
          .map((user) => Userdto.fromJson(user))
          .toList(),
      owner: Userdto.fromJson(json['owner']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': lobbyId,
      'users': users.map((user) => user.toJson()).toList(),
      'owner': owner.toJson(),
    };
  }
}
