import 'package:flutter/material.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/controllers/play_controller.dart';
import 'package:gamelobby/modules/gamelobby/play/lobby/views/unrated_view.dart';
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
            Expanded(
              child: UnratedView(),
            ),
          ],
        ),
      ),
    );
  }
}
