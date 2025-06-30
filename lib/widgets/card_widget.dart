import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/models/player.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/controllers/play_controller.dart';
import 'package:get/get.dart';

class CardWidget {
  static Widget playercard(
      {required BuildContext context,
      required PlayController controller,
      double height = 450,
      Player? player}) {
    var userping = 20.obs;
    Timer.periodic(const Duration(seconds: 4), (timer) {
      final random = Random();

      if (random.nextDouble() < 0.2) {
        // %20 ihtimal
        userping.value = 50 + random.nextInt(60); // 50–60 arası
      } else {
        // %80 ihtimal
        userping.value = 20 + random.nextInt(11); // 20–30 arası
      }
    });

    return Padding(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                player == null
                    ? SizedBox.shrink()
                    : player.lobbyowner
                        ? SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              APIService api = APIService.instance;

                              api.lobbykick(userID: player.userid);
                            },
                            child: Text(
                              "At ",
                              style: TextStyle(
                                color: Colors.amber,
                              ),
                            ),
                          ),
                Spacer(),
                player == null
                    ? SizedBox.shrink()
                    : Obx(
                        () => Text(
                          "${userping.value}ms",
                          style: TextStyle(
                            color: userping.value > 100
                                ? Colors.red
                                : userping.value > 80
                                    ? Colors.orange
                                    : Colors.greenAccent,
                          ),
                        ),
                      ),
                player == null
                    ? SizedBox.shrink()
                    : Obx(
                        () => Icon(
                          color: userping.value > 100
                              ? Colors.red
                              : userping.value > 80
                                  ? Colors.orange
                                  : Colors.greenAccent,
                          userping.value > 100
                              ? Icons.signal_cellular_alt_1_bar_rounded
                              : userping.value > 100
                                  ? Icons.signal_cellular_alt_2_bar_rounded
                                  : Icons.signal_cellular_alt_rounded,
                        ),
                      )
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: player != null
                    ? null
                    : () {
                        controller.showInviteDialog(context);
                      },
                child: Obx(
                  () => controller.gameplayers.value == null
                      ? CupertinoActivityIndicator()
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900.withValues(alpha: 0.7),
                            image: player == null
                                ? null
                                : DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withValues(alpha: 0.5),
                                      BlendMode.dstATop,
                                    ),
                                    image: AssetImage(
                                      player.banner,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          height: height,
                          width: double.infinity,
                          child: controller.gameplayers.value == null
                              ? CupertinoActivityIndicator()
                              : player == null
                                  ? Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Container(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                "HAZIR",
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
                                          child: Text(
                                            player.username,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
