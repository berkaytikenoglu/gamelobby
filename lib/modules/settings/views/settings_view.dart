import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gamelobby/modules/settings/controllers/settings_controller.dart';
import 'package:gamelobby/widgets/settings_widget.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            key: ValueKey<int>(0), // Resmi değiştirdiğinde key değişecek
            colorFilter: ColorFilter.matrix([
              0.4, 0, 0, 0, 0, // Kırmızı kanalını artır
              0, 0.4, 0, 0, 0, // Yeşil kanalını artır
              0, 0, 0.4, 0, 0, // Mavi kanalını artır
              0, 0, 0, 1, 0, // Alfa kanalını koru
            ]),
            child: Image.asset(
              "assets/images/wallpapers/4.png",
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        controller: controller.tabController,
                        labelColor: Colors.red,
                        indicatorColor: Colors.red,
                        unselectedLabelColor: Colors.white,
                        onTap: (value) {
                          controller.pageController.value.jumpToPage(value);
                        },
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("GENEL"),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text("KONTROLLER"),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("GÖRÜNTÜ"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("SES"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController.value,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 200.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 60),
                                  SettingsWidget.categoryName("HESAP"),
                                  SettingsWidget.listtile1button(),
                                  SettingsWidget.categoryName("ERİŞEBİLİRLİK"),
                                  SettingsWidget.listTile(
                                    "Metin Dili",
                                    "Türkçe (Türkiye)",
                                    () {
                                      log("asd");
                                    },
                                  ),
                                  // SettingsWidget.categoryName("FARE"),
                                  // SettingsWidget.listtileslider(
                                  //   "Hassasiyet: Hedefleme",
                                  //   onChanged: (val) {},
                                  // ),
                                  // SettingsWidget.listtileslider(
                                  //   "Yakınlaştırma Hassasiyeti Çarpanı",
                                  //   onChanged: (val) {},
                                  // ),
                                  // SettingsWidget.listtilebuttons(
                                  //     "Fareyi Ters Çevir", "Açık", "Kapalı"),
                                  // SettingsWidget.listtilebuttons(
                                  //     "Saf Girdi Süresi", "Açık", "Kapalı"),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 200.0),
                          //   child: SingleChildScrollView(
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         SizedBox(height: 60),
                          //         SettingsWidget.categoryName("HAREKET"),
                          //         SettingsWidget.listtilebuttons(
                          //           "İleri",
                          //           "W",
                          //           "-",
                          //         ),
                          //         SettingsWidget.listtilebuttons(
                          //           "Geri",
                          //           "S",
                          //           "-",
                          //         ),
                          //         SettingsWidget.listtilebuttons(
                          //           "Sola Git",
                          //           "A",
                          //           "-",
                          //         ),
                          //         SettingsWidget.listtilebuttons(
                          //           "Sağa Git",
                          //           "D",
                          //           "-",
                          //         ),
                          //         SettingsWidget.listtilebuttons(
                          //           "Zıpla",
                          //           "Boşluk Düğmesi",
                          //           "-",
                          //         ),
                          //         SettingsWidget.listtilebuttons(
                          //           "Çömel",
                          //           "R",
                          //           "-",
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 200.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 60),
                                  SettingsWidget.categoryName("GENEL"),
                                  SettingsWidget.listTile(
                                    "Görüntü Modu",
                                    "Tam Ekran",
                                    () {
                                      log("asd");
                                    },
                                  ),
                                  SettingsWidget.listTile(
                                    "Çözünürlük",
                                    "1920 x 1080 16:9 (180Hz)",
                                    () {
                                      log("asd");
                                    },
                                  ),
                                  // SettingsWidget.listTile(
                                  //   "Ekran",
                                  //   "1. MNR2409 (1920 X 1080 16:9)",
                                  //   () {
                                  //     log("asd");
                                  //   },
                                  // ),
                                  // SettingsWidget.categoryName("GRAFİK"),
                                  // SettingsWidget.listtilebuttons(
                                  //   "Materyal Kalitesi",
                                  //   "Yüksek",
                                  //   "Düşük",
                                  // ),
                                  // SettingsWidget.listtilebuttons(
                                  //   "Doku Kalitesi",
                                  //   "Yüksek",
                                  //   "Düşük",
                                  // ),
                                  // SettingsWidget.listtilebuttons(
                                  //   "Arayüz Kalitesi",
                                  //   "Yüksek",
                                  //   "Düşük",
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 200.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 60),
                                  SettingsWidget.categoryName("GENEL"),
                                  SettingsWidget.listtileslider(
                                    "Müzik Sesi",
                                    value: controller
                                        .gameMenuController.player.value.volume,
                                    onChanged: (val) => controller
                                        .gameMenuController.player.value
                                        .setVolume(val),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "AYARLARDAN ÇIK",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
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
    );
  }
}
