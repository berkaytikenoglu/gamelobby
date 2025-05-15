import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/helper/functions/api_functions.dart';
import 'package:gamelobby/helper/functions/jwt.dart';
import 'package:gamelobby/helper/models/api/friendship.dart';
import 'package:gamelobby/helper/models/api/lobby/lobby_information.dart';
import 'package:gamelobby/helper/models/signalr/userdto.dart';
import 'package:gamelobby/models/player.dart';
import 'package:get/get.dart';

class PlayController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Rxn<TabController> tabController;
  var pageController = PageController(initialPage: 0).obs;

  Rxn<List<Player>> gameplayers = Rxn();
  @override
  void onInit() {
    tabController = Rxn<TabController>(TabController(length: 3, vsync: this));
    super.onInit();

    gameplayers.value ??= [];
    setuplobby();
  }

  @override
  void onClose() {
    tabController.value!.dispose(); // Bellek sızıntısını önlemek için
    super.onClose();
  }

  setuplobby() async {
    APIService api = APIService.instance;
    LobbyInformation? response = await api.lobbyInformation();
    if (response == null) {
      return;
    }
    gameplayers.value = [];

    int myid = Jwt.decodeJWTfetchID(api.getToken()!);

    for (Userdto element in response.users) {
      if (element.userId == myid) {
        log("-------------benimmmm");
        continue;
      }
      gameplayers.value!.add(
        Player(
          userid: element.userId,
          username: element.username,
          avatar:
              "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${element.avatarId}",
          banner: "assets/images/banners/${math.Random().nextInt(5) + 1}.jpg",
        ),
      );
    }
    log(gameplayers.value!.length.toString());
    gameplayers.refresh();
  }

  //INVITE
  void showInviteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Center(
            child: Row(
              children: [
                Text(
                  "DAVET ET",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    await ApiFunctions.fetchfriends();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          content: SizedBox(
            width: 400,
            height: 500,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Ara",
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey.shade800,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: LinearBorder(),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          log("sad");
                        },
                        child: Text("Davet Et"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: AppLists.friendsList.value == null
                      ? CupertinoActivityIndicator()
                      : SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              AppLists.friendsList.value!.length,
                              (index) {
                                APIFriendship userInfo =
                                    AppLists.friendsList.value![index];
                                return Material(
                                  color: Colors.transparent,
                                  child: ListTile(
                                    tileColor: Colors.black26,
                                    leading:
                                        Icon(Icons.person, color: Colors.white),
                                    title: Text(
                                      userInfo.username,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: TextButton(
                                      onPressed: () async {
                                        APIService api = APIService.instance;

                                        bool? response =
                                            await api.lobbyinviteplayer(
                                                userID: userInfo.id);
                                        if (!response) {
                                          return;
                                        }

                                        Get.back();
                                      },
                                      child: Text(
                                        "Davet Et",
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showmatchesfound(
      {required BuildContext context,
      required String matchedSearchID,
      int countdown = 10}) {
    log("111111111111111111111111111111111111111111111");
    Timer? timer;

    var countdownobx = countdown.obs;

    void stopTimer() {
      timer?.cancel(); // Timer'ı durdur
      timer = null;
      if (kDebugMode) {
        print("Timer durduruldu.");
      }
    }

    void startTimer() {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (countdownobx.value > 0) {
          countdownobx.value--;

          if (kDebugMode) {
            print("Sayaç: ${countdownobx.value}");
          }
        } else {
          stopTimer();
        }
      });
    }

    startTimer();

    var matchAcceptDeclineProccess = false.obs;
    matchAccept() async {
      if (matchAcceptDeclineProccess.value) {
        return;
      }
      matchAcceptDeclineProccess.value = true;

      APIService api = APIService.instance;
      bool response = await api.matchSearchRespond(
        matchedSearchId: matchedSearchID,
        accepted: true,
      );
      Get.back();
      if (!response) {
        log("bilinmeyen hata");
        matchAcceptDeclineProccess.value = false;
        return;
      }
      log("Kabul edildi.");
    }

    matchDecline() async {
      if (matchAcceptDeclineProccess.value) {
        return;
      }
      matchAcceptDeclineProccess.value = true;
      APIService api = APIService.instance;
      bool response = await api.matchSearchRespond(
        matchedSearchId: matchedSearchID,
        accepted: false,
      );

      if (!response) {
        log("bilinmeyen hata");
        matchAcceptDeclineProccess.value = false;
        return;
      }
      log("Reddedildi.");
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Center(
            child: Row(
              children: [Text(matchedSearchID)],
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => CircularProgressIndicator(
                  value: (1 - (countdownobx.value / 10)),
                  semanticsValue: "1",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Text(
                    countdownobx.value.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: LinearBorder(),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: matchAcceptDeclineProccess.value
                            ? null
                            : () async => matchAccept(),
                        child: Text("KABUL ET"),
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: LinearBorder(),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: matchAcceptDeclineProccess.value
                            ? null
                            : () async => await matchDecline(),
                        child: Text("REDDET"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
