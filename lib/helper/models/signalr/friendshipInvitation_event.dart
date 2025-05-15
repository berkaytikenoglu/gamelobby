import 'package:gamelobby/helper/models/signalr/userdto.dart';

class FriendshipInvitationEvent {
  final Userdto sender;
  final int invitationID;

  FriendshipInvitationEvent({required this.sender, required this.invitationID});

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'invitationId': invitationID,
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory FriendshipInvitationEvent.fromJson(Map<String, dynamic> json) {
    return FriendshipInvitationEvent(
      sender: Userdto.fromJson(json['sender']),
      invitationID: json['invitationId'],
    );
  }
}
