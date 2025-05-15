import 'dart:developer';
import 'dart:math' as math;

import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/helper/functions/jwt.dart';
import 'package:gamelobby/helper/models/api/friendinvitations.dart';
import 'package:gamelobby/helper/models/api/friendship.dart';
import 'package:gamelobby/helper/models/api/lobby/lobby_information.dart';
import 'package:gamelobby/helper/models/api/lobby/lobby_invitation_list.dart';
import 'package:gamelobby/helper/models/signalr/userdto.dart';
import 'package:gamelobby/models/player.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/controllers/play_controller.dart';
import 'package:get/get.dart';

class ApiFunctions {
  static fetchfriends() async {
    APIService api = APIService.instance;

    List<APIFriendship>? response = await api.friendships();
    if (response == null) {
      log("Arkadaşlar Çekilemedi");
      return;
    }
    log("--->$response");

    AppLists.friendsList.value = [];
    AppLists.friendsList.value!.addAll(response);
    AppLists.friendsList.refresh();

    AppLists.onlinefriendsList.value = [];
    AppLists.onlinefriendsList.value!.addAll(response);
    AppLists.onlinefriendsList.refresh();

    AppLists.offlinefriendsList.value = [];
    AppLists.onlinefriendsList.value!.addAll(response);
    AppLists.onlinefriendsList.refresh();
  }

  static friendInvitationList() async {
    APIService api = APIService.instance;

    List<APIFriendinvitations>? response = await api.friendInvitations();
    if (response == null) {
      log("sadsad");
      return;
    }
    log("--->$response");

    AppLists.friendsInvitationList.value = [];
    AppLists.friendsInvitationList.value!.addAll(response);
    AppLists.friendsInvitationList.refresh();
  }

  static Future<bool> friendInvitationResponse({
    required int invitationId,
    required bool acceptState,
  }) async {
    APIService api = APIService.instance;

    bool response = await api.friendInviteResponse(
      invitationId: invitationId,
      acceptState: acceptState,
    );
    if (!response) {
      log("sadsad");
      return false;
    }

    log("--->$response");
    return true;
  }

  static Future<bool> lobbyInvitations() async {
    APIService api = APIService.instance;

    List<LobbyinvatitionInformation>? response =
        await api.lobbyinvitationList();
    if (response == null) {
      return false;
    }
    AppLists.lobbyInvitationList.value = [];
    for (LobbyinvatitionInformation element in response) {
      AppLists.lobbyInvitationList.value!.add(
        APIFriendinvitations(
          id: element.invtatitionId,
          invitor: APIFriendship(
            id: element.invitor.userId,
            username: element.invitor.username,
            avatarId: element.invitor.avatarId,
            isOnline: element.invitor.isOnline,
          ),
        ),
      );
    }
    AppLists.lobbyInvitationList.refresh();

    log("--->$response");
    return true;
  }

  static Future<bool> matchStopSearch() async {
    APIService api = APIService.instance;

    bool response = await api.matchStopSearch();

    return response;
  }

  static Future<bool> lobbyquit() async {
    APIService api = APIService.instance;

    LobbyInformation? response = await api.lobbyquit();
    if (response == null) {
      return false;
    }

    final playcontroller = Get.put(PlayController());

    AppLists.lobbyInvitationList.value = [];
    playcontroller.gameplayers.value = [];
    for (Userdto element in response.users) {
      int myid = Jwt.decodeJWTfetchID(api.getToken()!);
      if (element.userId == myid) {
        continue;
      }
      playcontroller.gameplayers.value!.add(
        Player(
          userid: element.userId,
          username: element.username,
          avatar:
              "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${element.avatarId}",
          banner: "assets/images/banners/${math.Random().nextInt(5) + 1}.jpg",
        ),
      );
    }
    AppLists.lobbyInvitationList.refresh();

    log("--->$response");
    return true;
  }
}
