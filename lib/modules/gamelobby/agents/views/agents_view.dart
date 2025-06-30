import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:gamelobby/modules/gamelobby/agents/controllers/agents_controller.dart';
import 'package:get/get.dart';

class AgentsView extends StatelessWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentsController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            SizedBox(
              height: 500,
              child: Row(
                children: [
                  Expanded(flex: 1, child: SizedBox.shrink()),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 500,
                          child: Container(
                            color: Colors.black38,
                            child: Column(
                              children: [
                                SizedBox(height: 100),
                                Expanded(
                                  child: Cube(
                                    onObjectCreated: (object) {},
                                    interactive: false,
                                    onSceneCreated: (Scene scene) {
                                      controller.setScene(scene);
                                      scene.world.add(controller.carObject!);
                                      scene.camera.zoom = 12;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "HAYALET",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              """
                      Bedenine gömülen yeşil, fosforlu kimyasal sıvı; sadece derisini değil, ruhunu da çürüttü. Artık yaşam enerjisine ihtiyacı yoktu – ruh arıyordu.
                      İnsanların içinde saklı olan o titreyen, sıcak varlığı birer birer içine çekmeye başladı.
                      
                                              """,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          StatRow(
                              icon: Icons.local_fire_department,
                              label: 'Güç',
                              value: 85),
                          StatRow(
                              icon: Icons.favorite,
                              label: 'Sağlık',
                              value: 100),
                          StatRow(
                              icon: Icons.visibility,
                              label: 'Görüş',
                              value: 60),
                          StatRow(icon: Icons.speed, label: 'Hız', value: 70),
                          StatRow(
                              icon: Icons.psychology, label: 'Zeka', value: 90),
                          StatRow(
                              icon: Icons.shield, label: 'Direnç', value: 80),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox.shrink()),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScrollbarTheme(
                data: ScrollbarThemeData().copyWith(
                    thumbColor: WidgetStateProperty.all(Colors.red),
                    trackColor: WidgetStateProperty.all(Colors.black),
                    thickness: WidgetStatePropertyAll(4.0)),
                child: Scrollbar(
                  controller: controller.scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                      1,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.red, // border rengi
                                      width: 3, // border kalınlığı
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/character/ch1.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;

  const StatRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.greenAccent),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(
            value.toString(),
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
