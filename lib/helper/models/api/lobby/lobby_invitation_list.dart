import 'package:gamelobby/helper/models/signalr/userdto.dart';

class LobbyinvatitionInformation {
  final int invtatitionId;
  final int lobbyID;
  final Userdto invitor;

  LobbyinvatitionInformation({
    required this.invtatitionId,
    required this.lobbyID,
    required this.invitor,
  });

  factory LobbyinvatitionInformation.fromJson(Map<String, dynamic> json) {
    return LobbyinvatitionInformation(
      invtatitionId: json['id'],
      lobbyID: json['lobbyId'],
      invitor: Userdto.fromJson(json['invitor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': invtatitionId,
      'lobbyId': lobbyID,
      'invitor': invitor.toJson(),
    };
  }
}
