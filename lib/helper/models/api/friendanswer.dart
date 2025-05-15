import 'package:gamelobby/helper/models/signalr/userdto.dart';

class Friendanswer {
  final Userdto invitedUser;
  final bool acceptState;

  Friendanswer({required this.invitedUser, required this.acceptState});
  factory Friendanswer.fromJson(Map<String, dynamic> json) {
    return Friendanswer(
      invitedUser: Userdto.fromJson(json['invitedUser']),
      acceptState: json['acceptState'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitedUser': invitedUser.toJson(),
      'acceptState': acceptState,
    };
  }
}
