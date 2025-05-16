import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/helper/functions/api_functions.dart';
import 'package:gamelobby/helper/functions/jwt.dart';
import 'package:gamelobby/modules/gamelobby/play/_main/controllers/play_controller.dart';
import 'package:gamelobby/modules/gamelobby/play/lobby/controllers/unrated_controller.dart';
import 'package:gamelobby/widgets/card_widget.dart';
import 'package:get/get.dart';

class UnratedView extends StatelessWidget {
  const UnratedView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayController());
    final unratedcontroller = Get.put(UnratedController());
    APIService api = APIService.instance;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => CardWidget.playercard(
                context: context,
                controller: controller,
                player: controller.gameplayers.value == null
                    ? null
                    : controller.gameplayers.value!.isNotEmpty
                        ? controller.gameplayers.value![0]
                        : null,
              ),
            ),
            Obx(
              () => CardWidget.playercard(
                context: context,
                controller: controller,
                height: 475,
                player: controller.gameplayers.value == null
                    ? null
                    : controller.gameplayers.value!.length > 1
                        ? controller.gameplayers.value![1]
                        : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: SizedBox(
                width: 200,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text(
                          "20",
                          style: TextStyle(color: Colors.greenAccent),
                        ),
                        Icon(
                          color: Colors.greenAccent,
                          Icons.signal_cellular_alt_rounded,
                        )
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Obx(
                        () => controller.gameplayers.value == null
                            ? CupertinoActivityIndicator()
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900
                                      .withValues(alpha: 0.7),
                                  image: 1 != 1
                                      ? null
                                      : DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                            Colors.black.withValues(alpha: 0.5),
                                            BlendMode.dstATop,
                                          ),
                                          image: AssetImage(
                                            "assets/images/banners/1.png",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                height: 500,
                                width: double.infinity,
                                child: controller.gameplayers.value == null
                                    ? CupertinoActivityIndicator()
                                    : 1 == 1
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Spacer(),
                                              Container(
                                                color: Colors.green,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  Jwt.decodeJWTfetchname(
                                                      api.getToken()!),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => CardWidget.playercard(
                context: context,
                controller: controller,
                height: 475,
                player: controller.gameplayers.value == null
                    ? null
                    : controller.gameplayers.value!.length > 2
                        ? controller.gameplayers.value![2]
                        : null,
              ),
            ),
            Obx(
              () => CardWidget.playercard(
                context: context,
                controller: controller,
                height: 450,
                player: controller.gameplayers.value == null
                    ? null
                    : controller.gameplayers.value!.length > 3
                        ? controller.gameplayers.value![3]
                        : null,
              ),
            ),
          ],
        ),
        Text(
          "Unutma, hayaletler intikamını sessizce alır, bugün tam zamanı!",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: LinearBorder()),
                onPressed: () async {
                  APIService api = APIService.instance;
                  bool response = await api.matchStartSearch();
                  if (!response) {
                    log("Maç araması başlatılamadı!");
                    return;
                  }
                  unratedcontroller.startTimer();
                  showDialog(
                    barrierDismissible: false,
                    context: Get.context!,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: Center(
                          child: Row(
                            children: [Text("Maç Aranıyor")],
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Center(
                                    child: Obx(
                                      () => Text(
                                        unratedcontroller
                                            .matchsearchingtime.value
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "En kısa zamanda uygun bir takımla yüzleşeceksiniz"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: LinearBorder(),
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                bool result =
                                    await ApiFunctions.matchStopSearch();

                                if (result) {
                                  Get.back();
                                  unratedcontroller.stopTimer();
                                  return;
                                }
                              },
                              child: Text(
                                "İPTAL ET",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text("OYNA"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  await ApiFunctions.lobbyquit();
                },
                child: Text(
                  "Lobiden ÇIK",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
