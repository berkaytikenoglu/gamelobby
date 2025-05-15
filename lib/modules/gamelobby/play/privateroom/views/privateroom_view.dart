import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/modules/gamelobby/play/privateroom/controllers/privateroom_controller.dart';
import 'package:get/get.dart';

class PrivateroomView extends StatelessWidget {
  const PrivateroomView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivateroomController());
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100,
                width: 300,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: AppLists.mapList[0].img,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      onTap: () {
                        controller.showMapSelectDialog(context);
                      },
                      tileColor: Colors.grey.shade700,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text("HARİTA : ${AppLists.mapList[0].name}"),
                      trailing: Icon(Icons.arrow_drop_down_rounded),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      tileColor: Colors.grey.shade700,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text("SUNUCU : İstanbul"),
                      trailing: Icon(Icons.arrow_drop_down_rounded),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      tileColor: Colors.grey.shade700,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text(
                        AppLists.mapList[0].game.settings.gameType.name
                            .toUpperCase(),
                      ),
                      trailing: Icon(Icons.arrow_drop_down_rounded),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ListTile(
                      tileColor: Colors.grey.shade700,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text("SEÇENEKLER"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 50),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.red.withValues(alpha: 0.5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.game.value.teams.first.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ...List.generate(
                        5,
                        (index) {
                          return Material(
                            color: Colors.transparent,
                            child: ListTile(
                              onTap: () {},
                              title: Icon(Icons.arrow_drop_down_rounded),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue.withValues(alpha: 0.5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.game.value.teams.last.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ...List.generate(
                        5,
                        (index) {
                          return Material(
                            color: Colors.transparent,
                            child: ListTile(
                              onTap: () {},
                              title: Icon(Icons.arrow_drop_down_rounded),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "GÖZLEMCİLER",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () {},
                          title: Icon(Icons.arrow_drop_down_rounded),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () {},
                          title: Icon(Icons.arrow_drop_down_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
