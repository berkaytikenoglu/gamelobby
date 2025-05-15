import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/helper/functions/api_functions.dart';
import 'package:gamelobby/helper/functions/jwt.dart';
import 'package:gamelobby/helper/models/api/friendinvitations.dart';
import 'package:gamelobby/helper/models/api/lobby/lobby_information.dart';
import 'package:gamelobby/helper/models/signalr/userdto.dart';
import 'package:gamelobby/models/player.dart';
import 'package:gamelobby/modules/gamelobby/_main/controllers/gamemenu_controller.dart';
import 'package:gamelobby/modules/gamelobby/agents/views/agents_view.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/controllers/play_controller.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/views/play_view.dart';
import 'package:gamelobby/modules/home/views/home_view.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:gamelobby/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class GamemenuView extends StatelessWidget {
  const GamemenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GameMenuController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(seconds: 1), // Animasyon süresi
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // Geçiş animasyonu: fade in/out veya diğer geçiş türlerini burada ayarlayabilirsin
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: ColorFiltered(
                  key: ValueKey<int>(controller.selectedmenuIndex
                      .value), // Resmi değiştirdiğinde key değişecek
                  colorFilter: ColorFilter.matrix([
                    0.4, 0, 0, 0, 0, // Kırmızı kanalını artır
                    0, 0.4, 0, 0, 0, // Yeşil kanalını artır
                    0, 0, 0.4, 0, 0, // Mavi kanalını artır
                    0, 0, 0, 1, 0, // Alfa kanalını koru
                  ]),
                  child: Image.asset(
                    AppLists
                        .backgroundImages[controller.selectedmenuIndex.value],
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 80),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 60,
                child: PageView(
                  controller: controller.pageController.value,
                  children: [
                    HomeView(
                      function: (menuIndex, menuName) {
                        controller.selectedmenuIndex.value = menuIndex;
                        controller.selectedmenu.value = menuName;

                        controller.pageController.value.jumpToPage(menuIndex);
                      },
                    ),
                    PlayView(),
                    AgentsView(),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.selectedmenuIndex.value == 0
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.topLeft,
                      child: Appbar.appbarBack(
                        controller.selectedmenu.value,
                        (page) {
                          controller.selectedmenuIndex.value = 0;
                          controller.pageController.value.jumpToPage(0);
                          controller.selectedmenu.value = "HOME";
                        },
                      ),
                    ),
            ),
            Obx(
              () => controller.selectedmenuIndex.value == 0
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Appbar.lobbyappbar(
                        controller.selectedmenuIndex,
                        (page) {
                          controller.pageController.value.jumpToPage(page);
                          if (page == 0) {
                            controller.selectedmenu.value = "HOME";
                          } else if (page == 1) {
                            controller.selectedmenu.value = "SAVAŞ BİLETİ";
                          } else if (page == 2) {
                            controller.selectedmenu.value = "AJANLAR";
                          } else if (page == 3) {
                            controller.selectedmenu.value = "KARAKTERLER";
                          }
                        },
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Appbar.appbar(
                (page) {
                  if (page == 6) {
                    controller.popupSettingsController.value = true;
                  }
                },
              ),
            ),
            Obx(
              () => AnimatedContainer(
                duration: Duration(milliseconds: 1000), // Animasyon süresi
                child: Positioned(
                  right: controller.hoveredfriends.value == true ? 0 : 0,
                  width: controller.hoveredfriends.value == true ? 250 : 250,
                  top: 50,
                  bottom: 0,
                  child: Container(
                    color: Colors.black26,
                    child: MouseRegion(
                      onEnter: (_) {
                        controller.hoveredfriends.value = true;
                      },
                      onExit: (_) {
                        controller.hoveredfriends.value = false;
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Material(
                                color: Colors.transparent,
                                child: Obx(
                                  () => AppLists.friendsList.value == null
                                      ? CupertinoActivityIndicator()
                                      : Column(
                                          children: [
                                            AppLists.friendsInvitationList
                                                        .value ==
                                                    null
                                                ? SizedBox.shrink()
                                                : Column(
                                                    children: List.generate(
                                                      AppLists
                                                          .friendsInvitationList
                                                          .value!
                                                          .length,
                                                      (index) {
                                                        return Column(
                                                          children: [
                                                            ListTile(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              minLeadingWidth:
                                                                  0,
                                                              minTileHeight: 0,
                                                              minVerticalPadding:
                                                                  5,
                                                              leading: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                  4.0,
                                                                ),
                                                                child:
                                                                    CircleAvatar(
                                                                  foregroundImage:
                                                                      CachedNetworkImageProvider(
                                                                    AppLists.imgURL +
                                                                        AppLists
                                                                            .friendsInvitationList
                                                                            .value![index]
                                                                            .invitor
                                                                            .avatarId
                                                                            .toString(),
                                                                  ),
                                                                ),
                                                              ),
                                                              title: Text(
                                                                AppLists
                                                                    .friendsInvitationList
                                                                    .value![
                                                                        index]
                                                                    .invitor
                                                                    .username,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              subtitle: Text(
                                                                "Arkadaşlık İsteği Gönderdi",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Spacer(),
                                                                IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool
                                                                        response =
                                                                        await ApiFunctions
                                                                            .friendInvitationResponse(
                                                                      invitationId: AppLists
                                                                          .friendsInvitationList
                                                                          .value![
                                                                              index]
                                                                          .id,
                                                                      acceptState:
                                                                          true,
                                                                    );
                                                                    if (response) {
                                                                      AppLists
                                                                          .friendsList
                                                                          .value!
                                                                          .add(
                                                                        AppLists
                                                                            .friendsInvitationList
                                                                            .value![index]
                                                                            .invitor,
                                                                      );

                                                                      AppLists
                                                                          .friendsList
                                                                          .refresh();

                                                                      AppLists
                                                                          .friendsInvitationList
                                                                          .value!
                                                                          .removeAt(
                                                                              index);
                                                                      AppLists
                                                                          .friendsInvitationList
                                                                          .refresh();
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 30,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    bool
                                                                        response =
                                                                        await ApiFunctions
                                                                            .friendInvitationResponse(
                                                                      invitationId: AppLists
                                                                          .friendsInvitationList
                                                                          .value![
                                                                              index]
                                                                          .id,
                                                                      acceptState:
                                                                          false,
                                                                    );
                                                                    if (response) {
                                                                      AppLists
                                                                          .friendsInvitationList
                                                                          .value!
                                                                          .removeAt(
                                                                              index);
                                                                      AppLists
                                                                          .friendsInvitationList
                                                                          .refresh();
                                                                    }
                                                                  },
                                                                  icon: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 30,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                            Obx(
                                              () => AppLists.lobbyInvitationList
                                                          .value ==
                                                      null
                                                  ? SizedBox.shrink()
                                                  : AppLists.lobbyInvitationList
                                                          .value!.isEmpty
                                                      ? SizedBox.shrink()
                                                      : SizedBox(
                                                          height: 150,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                ...List
                                                                    .generate(
                                                                  AppLists
                                                                      .lobbyInvitationList
                                                                      .value!
                                                                      .length,
                                                                  (index) {
                                                                    APIFriendinvitations
                                                                        user =
                                                                        AppLists
                                                                            .lobbyInvitationList
                                                                            .value![index];

                                                                    return Container(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade600,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          ListTile(
                                                                            contentPadding:
                                                                                EdgeInsets.all(0),
                                                                            minLeadingWidth:
                                                                                0,
                                                                            minTileHeight:
                                                                                0,
                                                                            minVerticalPadding:
                                                                                5,
                                                                            leading:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(
                                                                                4.0,
                                                                              ),
                                                                              child: CircleAvatar(),
                                                                            ),
                                                                            title:
                                                                                Text(
                                                                              user.invitor.username,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            subtitle:
                                                                                Text(
                                                                              "SENİ GRUBUNA DAVET ETTİ",
                                                                              style: TextStyle(
                                                                                fontSize: 11,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  shape: LinearBorder(),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  APIService api = APIService.instance;

                                                                                  LobbyInformation? response = await api.lobbyinviteResponse(
                                                                                    answer: true,
                                                                                    invitationID: user.id,
                                                                                  );
                                                                                  if (response == null) {
                                                                                    return;
                                                                                  }

                                                                                  AppLists.lobbyInvitationList.value!.removeAt(index);
                                                                                  AppLists.lobbyInvitationList.refresh();

                                                                                  // response.users

                                                                                  final playcontroller = Get.put(PlayController());

                                                                                  playcontroller.gameplayers.value = [];
                                                                                  for (Userdto element in response.users) {
                                                                                    if (Jwt.decodeJWTfetchID(api.getToken()!) == element.userId) {
                                                                                      continue;
                                                                                    }
                                                                                    playcontroller.gameplayers.value!.add(
                                                                                      Player(
                                                                                        userid: element.userId,
                                                                                        username: element.username,
                                                                                        avatar: "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${element.avatarId}",
                                                                                        banner: "assets/images/banners/${math.Random().nextInt(5) + 1}.jpg",
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                  log("Grup Oyuncuları: ${playcontroller.gameplayers.value}");
                                                                                },
                                                                                child: Text(
                                                                                  "GRUBA KATIL",
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 5),
                                                                              IconButton(
                                                                                onPressed: () async {
                                                                                  APIService api = APIService.instance;

                                                                                  await api.lobbyinviteResponse(
                                                                                    answer: false,
                                                                                    invitationID: user.id,
                                                                                  );
                                                                                  AppLists.lobbyInvitationList.value!.removeAt(index);
                                                                                  AppLists.lobbyInvitationList.refresh();
                                                                                  return;
                                                                                },
                                                                                icon: Icon(
                                                                                  Icons.close,
                                                                                  color: Colors.white,
                                                                                  size: 30,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                            ),
                                            SizedBox(height: 5),
                                            ExpansionTile(
                                              tilePadding: EdgeInsets.all(0),
                                              childrenPadding:
                                                  EdgeInsets.all(0),
                                              minTileHeight: 0,
                                              backgroundColor:
                                                  Colors.grey.shade600,
                                              leading: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  AppLists.onlinefriendsList
                                                      .value!.length
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                "ÇEVRİMİÇİ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              children: [
                                                ...List.generate(
                                                  AppLists.friendsList.value!
                                                      .length,
                                                  (index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Container(
                                                        color: Colors.black38,
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CachedNetworkImage(
                                                                height: 40,
                                                                width: 40,
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl:
                                                                    "https://picsum.photos/200/200",
                                                              ),
                                                              AnimatedOpacity(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                opacity: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? 1.0
                                                                    : 0.0,
                                                                child: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? SizedBox(
                                                                        width:
                                                                            8)
                                                                    : SizedBox
                                                                        .shrink(),
                                                              ),
                                                              AnimatedOpacity(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                opacity: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? 1.0
                                                                    : 0.0,
                                                                child: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? Row(
                                                                        children: [
                                                                          Text(
                                                                            AppLists.friendsList.value![index].username,
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            AppLists.friendsList.value![index].isOnline
                                                                                ? "Online"
                                                                                : "Offline",
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppLists.friendsList.value![index].isOnline ? Colors.green : Colors.red,
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              APIService api = APIService.instance;

                                                                              bool? response = await api.deletefriend(userId: AppLists.friendsList.value![index].id);
                                                                              if (!response) {
                                                                                return;
                                                                              }
                                                                              AppLists.friendsList.value!.removeAt(index);
                                                                              AppLists.friendsList.refresh();
                                                                            },
                                                                            icon:
                                                                                Icon(Icons.delete),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : SizedBox
                                                                        .shrink(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            ExpansionTile(
                                              tilePadding: EdgeInsets.all(0),
                                              childrenPadding:
                                                  EdgeInsets.all(0),
                                              minTileHeight: 0,
                                              backgroundColor:
                                                  Colors.grey.shade600,
                                              leading: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  AppLists.offlinefriendsList
                                                      .value!.length
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                "ÇEVRİMDIŞI",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              children: [
                                                ...List.generate(
                                                  AppLists.offlinefriendsList
                                                      .value!.length,
                                                  (index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Container(
                                                        color: Colors.black38,
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CachedNetworkImage(
                                                                height: 40,
                                                                width: 40,
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl:
                                                                    "https://picsum.photos/200/200",
                                                              ),
                                                              AnimatedOpacity(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                opacity: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? 1.0
                                                                    : 0.0,
                                                                child: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? SizedBox(
                                                                        width:
                                                                            8)
                                                                    : SizedBox
                                                                        .shrink(),
                                                              ),
                                                              AnimatedOpacity(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                opacity: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? 1.0
                                                                    : 0.0,
                                                                child: controller
                                                                        .hoveredfriends
                                                                        .value
                                                                    ? Row(
                                                                        children: [
                                                                          Text(
                                                                            AppLists.offlinefriendsList.value![index].username,
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                            AppLists.offlinefriendsList.value![index].isOnline
                                                                                ? "Online"
                                                                                : "Offline",
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppLists.offlinefriendsList.value![index].isOnline ? Colors.green : Colors.red,
                                                                            ),
                                                                          ),
                                                                          IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              APIService api = APIService.instance;

                                                                              bool? response = await api.deletefriend(userId: AppLists.offlinefriendsList.value![index].id);
                                                                              if (!response) {
                                                                                return;
                                                                              }
                                                                              AppLists.offlinefriendsList.value!.removeAt(index);
                                                                              AppLists.offlinefriendsList.refresh();
                                                                            },
                                                                            icon:
                                                                                Icon(Icons.delete),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : SizedBox
                                                                        .shrink(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller:
                                        controller.searchuserController.value,
                                    keyboardType: TextInputType.text,
                                    maxLength: 64,
                                    cursorColor: Colors.red,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "Kullanıcı Adı",
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white38,
                                  ),
                                  onPressed: () async {
                                    APIService api = APIService.instance;

                                    bool? response = await api.addfriend(
                                      username: controller
                                          .searchuserController.value.text,
                                    );
                                    if (!response) {
                                      return;
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                left: controller.isVisible.value
                    ? 0
                    : -420, // Ekrana kayma efekti
                bottom: 20,
                child: MouseRegion(
                  onEnter: (event) {
                    controller.isVisible.value = true;
                  },
                  onExit: (event) async {
                    controller.isVisible.value = false;
                  },
                  child: Container(
                    height: 80,
                    width: 440,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black,
                          Colors.purple,
                          Colors.red,
                          Colors.orange,
                        ],
                      ),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 20),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  AppLists
                                      .musicList[controller.musicIndex.value]
                                      .img,
                                ),
                              ),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: AnimatedIcon(
                                icon: AnimatedIcons.play_pause,
                                progress: controller.musicController,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (controller.playingmusic.value) {
                                  controller.player.value.pause();
                                  controller.musicController.reverse();
                                  controller.playingmusic.value = false;
                                } else {
                                  controller.player.value.resume();
                                  controller.musicController.forward();
                                  controller.playingmusic.value = true;
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    AppLists
                                        .musicList[controller.musicIndex.value]
                                        .name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    AppLists
                                        .musicList[controller.musicIndex.value]
                                        .owner,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      Text(
                                        "${controller.musicCurrentPosition.value.toString().split('.').first.split(':')[1]}:${controller.musicCurrentPosition.value.toString().split('.').first.split(':')[2]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 150,
                                          height: 5,
                                          child: Obx(
                                            () => Slider(
                                              min: 0,
                                              max: controller.musicmaxPosition
                                                  .value.inMilliseconds
                                                  .toDouble(), // Maksimum süre
                                              value: controller
                                                  .musicCurrentPosition
                                                  .value
                                                  .inMilliseconds
                                                  .toDouble()
                                                  .clamp(
                                                      0.0,
                                                      controller
                                                          .musicmaxPosition
                                                          .value
                                                          .inMilliseconds
                                                          .toDouble()), // Geçerli süre
                                              activeColor: Colors.orange,
                                              inactiveColor: Colors.red
                                                  .withValues(alpha: 0.5),

                                              onChanged: (double value) {
                                                controller.musicCurrentPosition
                                                        .value =
                                                    Duration(
                                                        milliseconds:
                                                            value.toInt());
                                                controller.player.value.seek(
                                                    controller
                                                        .musicCurrentPosition
                                                        .value); // Müziği ilgili süreye atla
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${controller.musicmaxPosition.value.toString().split('.').first.split(':')[1]}:${controller.musicmaxPosition.value.toString().split('.').first.split(':')[2]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.playBackMusic(force: true);
                                },
                                icon: Icon(
                                  Icons.navigate_before_rounded,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.playNextMusic(force: true);
                                },
                                icon: Icon(
                                  Icons.navigate_next_rounded,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.popupSettingsController.value
                  ? Container(
                      color: Colors.black87,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 400,
                          width: 400,
                          color: const Color.fromARGB(209, 0, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      controller.popupSettingsController.value =
                                          false;
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: ListTile(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.SETTINGS);
                                      },
                                      tileColor: const Color.fromARGB(
                                          122, 255, 255, 255),
                                      title: Text(
                                        "AYARLAR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: ListTile(
                                      onTap: () {},
                                      tileColor: const Color.fromARGB(
                                          122, 255, 255, 255),
                                      title: Text(
                                        "OYUNCU DESTEK",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: ListTile(
                                      onTap: () {},
                                      tileColor: const Color.fromARGB(
                                          122, 255, 255, 255),
                                      title: Text(
                                        "HAKKINDA",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: ListTile(
                                      onTap: () async {
                                        await windowManager.hide();
                                        await Future.delayed(
                                            Duration(milliseconds: 500));

                                        await windowManager
                                            .setFullScreen(false);

                                        await windowManager
                                            .setAlignment(Alignment.center);

                                        Get.offAndToNamed(AppRoutes.LOGIN);
                                        await Future.delayed(
                                            Duration(milliseconds: 500));
                                        await windowManager.show();
                                      },
                                      tileColor:
                                          const Color.fromARGB(255, 255, 0, 0),
                                      title: Text(
                                        "MASAÜSTÜNE DÖN",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "1.00.00.1",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
