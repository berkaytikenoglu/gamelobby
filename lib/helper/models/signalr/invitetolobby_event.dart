import 'package:gamelobby/helper/models/signalr/userdto.dart';

class InvitetolobbyEvent {
  final int invitationId;
  final Userdto invitor;

  InvitetolobbyEvent({
    required this.invitationId,
    required this.invitor,
  });

  // Story nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'invitationId': invitationId,
      'invitor': invitor.toJson(),
    };
  }

  // JSON'dan Story nesnesine dönüşüm
  factory InvitetolobbyEvent.fromJson(Map<String, dynamic> json) {
    return InvitetolobbyEvent(
      invitationId: json['invitationId'],
      invitor: Userdto.fromJson(json['invitor']),
    );
  }
}
