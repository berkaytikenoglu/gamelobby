import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/helper/functions/jwt.dart';
import 'package:gamelobby/helper/models/api/friendanswer.dart';
import 'package:gamelobby/helper/models/api/friendinvitations.dart';
import 'package:gamelobby/helper/models/api/friendship.dart';
import 'package:gamelobby/helper/models/api/lobby/lobby_information.dart';
import 'package:gamelobby/helper/models/api/matches_service/matchedsearch.dart';
import 'package:gamelobby/helper/models/signalr/friendshipInvitation_event.dart';
import 'package:gamelobby/helper/models/signalr/invitetolobby_event.dart';
import 'package:gamelobby/helper/models/signalr/userdto.dart';
import 'package:gamelobby/models/player.dart';
import 'package:gamelobby/modules/gamelobby/_main/controllers/gamemenu_controller.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/controllers/play_controller.dart';
import 'package:get/get.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:window_manager/window_manager.dart';

class SignalRService {
  late HubConnection hubConnection;
  final String serverUrl = "http://185.93.68.107/NotificationHub";
  final String token;

  final AudioPlayer audioPlayer = AudioPlayer();

  SignalRService({required this.token}) {
    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => token,
              // headers:
              //     MessageHeaders(), // Alternatif olarak header içinde gönderebilirsin
            ))
        .withAutomaticReconnect() // Bağlantı koparsa otomatik bağlanır
        .build();

    // listenForAudio();

    invitationFriendship();
    matchedSearch();
    joinmatch();

    invitationAnswerFriendship();
    deleteFriendship();

    lobby();
    invitetoLobby();
  }

  /// SignalR bağlantısını başlat
  Future<void> startConnection() async {
    try {
      await hubConnection.start();
      if (kDebugMode) {
        print("SignalR bağlantısı başarılı!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Bağlantı hatası: $e");
      }
    }
  }

//LOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBY//

  void lobby() {
    hubConnection.on("Lobby", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        log("Lobby tetiklendi! ${arguments[0]}");
        // Veri tipinin string olduğundan emin ol

        try {
          // JSON string'ini decode et
          final String jsonString = jsonEncode(arguments[0]);
          Map<String, dynamic> json = jsonDecode(jsonString);

          // JSON verisini modele dönüştür
          LobbyInformation response = LobbyInformation.fromJson(json);

          final playcontroller = Get.put(PlayController());

          playcontroller.gameplayers.value = [];
          for (Userdto element in response.users) {
            int myid = Jwt.decodeJWTfetchID(token);
            if (element.userId == myid) {
              continue;
            }
            playcontroller.gameplayers.value!.add(
              Player(
                userid: element.userId,
                username: element.username,
                avatar:
                    "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${element.avatarId}",
                banner:
                    "assets/images/banners/${math.Random().nextInt(5) + 1}.jpg",
              ),
            );
          }
          AppLists.lobbyInvitationList.refresh();
          log("----------------------");
        } catch (e) {
          // JSON çözme hatası durumunda logla
          log("JSON çözme hatası 123: ${e.toString()}");
        }
      }
    });
  }

  void invitetoLobby() {
    hubConnection.on("InviteToLobby", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        log("InviteToLobby! ${arguments[0]}");
        // Veri tipinin string olduğundan emin ol

        try {
          // JSON string'ini decode et
          final String jsonString = jsonEncode(arguments[0]);
          Map<String, dynamic> json = jsonDecode(jsonString);

          // JSON verisini modele dönüştür
          InvitetolobbyEvent response = InvitetolobbyEvent.fromJson(json);

          log("SignalR! Maç Bulundu  ${response.invitationId}  ${response.invitor.userId}");

          AppLists.lobbyInvitationList.value!.add(
            APIFriendinvitations(
              id: response.invitationId,
              invitor: APIFriendship(
                id: response.invitor.userId,
                username: response.invitor.username,
                avatarId: response.invitor.avatarId,
                isOnline: response.invitor.isOnline,
              ),
            ),
          );
          AppLists.lobbyInvitationList.refresh();
        } catch (e) {
          // JSON çözme hatası durumunda logla
          log("JSON çözme hatası: ${e.toString()}");
        }
      }
    });
  }

  void matchedSearch() {
    hubConnection.on("MatchedSearch", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        log("MatchedSearch! ${arguments[0]}");
        // Veri tipinin string olduğundan emin ol

        try {
          // JSON string'ini decode et
          final String jsonString = jsonEncode(arguments[0]);
          Map<String, dynamic> json = jsonDecode(jsonString);

          // JSON verisini modele dönüştür
          Matchedsearch response = Matchedsearch.fromJson(json);

          log("SignalR! Maç Bulundu  ${response.matchedSearchId}  ${response.maximumTimeOfRespond}");

          // PlayController içinde işlemi başlat
          final playcontroller = Get.put(PlayController());
          playcontroller.showmatchesfound(
            context: Get.context!,
            matchedSearchID: response.matchedSearchId,
            countdown: response.maximumTimeOfRespond,
          );
        } catch (e) {
          // JSON çözme hatası durumunda logla
          log("JSON çözme hatası: ${e.toString()}");
        }
      }
    });
  }

  void joinmatch() {
    hubConnection.on("JoinMatch", (arguments) async {
      if (arguments != null && arguments.isNotEmpty) {
        log("JoinMatch! ${arguments[0]}");
        // Veri tipinin string olduğundan emin ol

        try {
          // JSON string'ini decode et
          final String jsonString = jsonEncode(arguments[0]);
          log(jsonString);
          try {
            // Oyun uygulamasının adı (örneğin 'My project.exe')
            String gameName = 'My project.exe';

            // Sistem işlemlerini kontrol et
            ProcessResult result = await Process.run('tasklist', []);

            if (result.stdout.toString().contains(gameName)) {
              // Oyun zaten çalışıyorsa, işlem yapılmasın
              log("Oyun zaten çalışıyor, tekrar başlatılmıyor.");
            } else {
              // Oyun çalışmıyorsa, başlat
              final playercontroller = Get.put(GameMenuController());
              playercontroller.player.value.pause();

              await windowManager.hide();
              await Process.run(
                'deneme\\My project.exe',
                ['--param1', jsonString],
              );

              await windowManager.show();
              playercontroller.player.value.resume();
            }
          } catch (e) {
            // Hata durumunda loglama yap
            log("Hata oluştu: ${e.toString()}");
          }
        } catch (e) {
          // JSON çözme hatası durumunda logla
          log("JSON çözme hatası: ${e.toString()}");
        }
      }
    });
  }

//LOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBYLOBBY//

  /// SignalR bağlantısını kapat
  Future<void> stopConnection() async {
    await hubConnection.stop();

    if (kDebugMode) {
      print("SignalR bağlantısı kapatıldı.");
    }
  }

  /// Server'dan mesaj alma
  void onReceiveMessage(Function(String) callback) {
    hubConnection.on("ReceiveMessage", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        callback(arguments[0].toString());
      }
    });
  }

  /// Server'dan mesaj alma
  // void invitetoLobby() {
  //   hubConnection.on("InvitationFriendship", (arguments) {
  //     if (arguments != null && arguments.isNotEmpty) {
  //       try {
  //         final String jsonString = jsonEncode(arguments[0]);
  //         Map<String, dynamic> json = jsonDecode(jsonString);

  //         FriendshipInvitationEvent aa =
  //             FriendshipInvitationEvent.fromJson(json);

  //         AppLists.friendsInvitationList.value ??= [];
  //         AppLists.friendsInvitationList.value!.add(
  //           APIFriendinvitations(
  //             id: aa.invitationID,
  //             invitor: APIFriendship(
  //               id: aa.sender.userId,
  //               username: aa.sender.username,
  //               avatarId: aa.sender.avatarId,
  //               isOnline: aa.sender.isOnline,
  //             ),
  //           ),
  //         );
  //         AppLists.friendsInvitationList.refresh();
  //       } catch (e) {
  //         log(e.toString());
  //       }
  //     }
  //   });
  // }

  /// Server'dan mesaj alma
  void invitationFriendship() {
    hubConnection.on("InvitationFriendship", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        try {
          final String jsonString = jsonEncode(arguments[0]);
          Map<String, dynamic> json = jsonDecode(jsonString);

          FriendshipInvitationEvent aa =
              FriendshipInvitationEvent.fromJson(json);

          AppLists.friendsInvitationList.value ??= [];
          AppLists.friendsInvitationList.value!.add(
            APIFriendinvitations(
              id: aa.invitationID,
              invitor: APIFriendship(
                id: aa.sender.userId,
                username: aa.sender.username,
                avatarId: aa.sender.avatarId,
                isOnline: aa.sender.isOnline,
              ),
            ),
          );
          AppLists.friendsInvitationList.refresh();
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }

  void invitationAnswerFriendship() {
    hubConnection.on("InvitationAnswerFriendship", (arguments) async {
      if (arguments != null && arguments.isNotEmpty) {
        log("InvitationAnswerFriendship! ${arguments[0]}");
        // Veri tipinin string olduğundan emin ol

        try {
          // JSON string'ini decode et
          final String jsonString = jsonEncode(arguments[0]);
          Map<String, dynamic> json = jsonDecode(jsonString);

          Friendanswer friendanswer = Friendanswer.fromJson(json);

          if (friendanswer.acceptState) {
            AppLists.friendsList.value!.add(
              APIFriendship(
                id: friendanswer.invitedUser.userId,
                username: friendanswer.invitedUser.username,
                avatarId: friendanswer.invitedUser.avatarId,
                isOnline: friendanswer.invitedUser.isOnline,
              ),
            );
            AppLists.friendsList.refresh();
          }
        } catch (e) {
          // JSON çözme hatası durumunda logla
          log("JSON çözme hatası: ${e.toString()}");
        }
      }
    });
  }

  void deleteFriendship() {
    hubConnection.on("DeleteFriendship", (arguments) async {
      if (arguments != null && arguments.isNotEmpty) {
        log("DeleteFriendship! ${arguments[0]}");
        // Veri tipinin string olduğundan emin ol

        try {
          // JSON string'ini decode et
          final String jsonString = jsonEncode(arguments[0]);
          Map<String, dynamic> json = jsonDecode(jsonString);

          AppLists.friendsList.value!.removeWhere(
            (element) => element.id == json['userId'],
          );
          AppLists.friendsList.refresh();
        } catch (e) {
          // JSON çözme hatası durumunda logla
          log("JSON çözme hatası: ${e.toString()}");
        }
      }
    });
  }

  /// Server'a mesaj gönderme
  Future<void> sendMessage(String message) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      await hubConnection.invoke("SendMessage", args: [message]);
    } else {
      if (kDebugMode) {
        print("SignalR bağlantısı yok.");
      }
    }
  }
}
