import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/helper/functions/api_functions.dart';
import 'package:gamelobby/helper/models/app/game_model.dart';
import 'package:gamelobby/helper/models/app/game_settings.dart';
import 'package:gamelobby/helper/models/app/team_model.dart';
import 'package:get/get.dart';

class PrivateroomController extends GetxController {
  late Rx<Game> game;
  @override
  void onInit() {
    super.onInit();

    game = Rx<Game>(
      Game(
        name: "Özel Oyun",
        settings: GameSettings(),
        teams: [
          Team(
            id: 1,
            name: "SALDIRANLAR",
            color: Colors.red,
            logoUrl: "logoUrl",
            players: [],
          ),
          Team(
            id: 1,
            name: "SAVUNUCULAR",
            color: Colors.blue,
            logoUrl: "logoUrl",
            players: [],
          ),
        ],
      ),
    );
  }

  //MAP SELECT
  void showMapSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape: LinearBorder(),
          title: Center(
            child: Row(
              children: [
                Text(
                  "HARİTA SEÇ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: AppLists.mapList[0].img,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                AppLists.mapList.length,
                                (index) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: ListTile(
                                      selected: index == 0 ? true : false,
                                      onTap: () {},
                                      tileColor: Colors.black26,
                                      title: Text(
                                        AppLists.mapList[index].name,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            AppLists.mapList[index].playerLimit
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
