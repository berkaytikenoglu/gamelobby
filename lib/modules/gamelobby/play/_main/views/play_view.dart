import 'package:flutter/material.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/controllers/play_controller.dart';
import 'package:gamelobby/modules/gamelobby/play/privateroom/views/privateroom_view.dart';
import 'package:gamelobby/modules/gamelobby/play/unrated/views/unrated_view.dart';
import 'package:get/get.dart';

class PlayView extends StatelessWidget {
  const PlayView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayController());

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 180.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TabBar(
                    controller: controller.tabController.value,
                    dividerColor: Colors.white60,
                    indicatorColor: Colors.greenAccent,
                    onTap: (value) {
                      controller.pageController.value.jumpToPage(value);
                    },
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "DERECESİZ",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "REKABETÇİ",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ÖZEL OYUN",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController.value,
                children: [
                  UnratedView(),
                  PrivateroomView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
