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
                    : InkWell(
                        onTap: () {
                          APIService api = APIService.instance;

                          api.lobbykick(userID: player.userid);
                        },
                        child: Text(
                          "Kick",
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
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
                                      controller.gameplayers.value![0].banner,
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
                                                "READY",
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
                                            controller
                                                .gameplayers.value![0].username,
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
