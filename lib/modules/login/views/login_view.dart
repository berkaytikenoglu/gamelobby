import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/consts.dart';
import 'package:gamelobby/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          Consts.loginImage,
                        ),
                      ),
                      SizedBox(
                        height: 240,
                        child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            Column(
                              children: [
                                TextField(
                                  controller:
                                      controller.usernameController.value,
                                  focusNode: controller.usernamefocus,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "KULLANICI ADI",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller:
                                      controller.userpasswordController.value,
                                  focusNode: controller.userpassfocus,
                                  obscureText: true,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: "ŞİFRE",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: IconButton(
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.grey.shade300,
                                      ),
                                      onPressed: () async {
                                        await controller.login(
                                          controller
                                              .usernameController.value.text,
                                          controller.userpasswordController
                                              .value.text,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(
                                        "https://server.aramizdakioyuncu.com/spooky/addAccount");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url,
                                          mode: LaunchMode
                                              .externalApplication); // Tarayıcıda aç
                                    } else {
                                      if (kDebugMode) {
                                        print("URL açılamıyor.");
                                      }
                                    }
                                  },
                                  child: Text(
                                    "HESAP OLUŞTUR",
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                  ),
                                ),
                              ],
                            ),
                            // Icon(
                            //   Icons.qr_code_2,
                            //   size: 250,
                            // )
                          ],
                        ),
                      ),
                      Text("v1.0.0"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "BU UYGULAMA CUHURİYET ÜNİVERSİTESİ ÖĞRENCİLERİ TARAFINDAN GELİŞTİRİLMEYE ÇALIŞILMIŞTIR...",
                          style: TextStyle(
                            color: Colors.grey,
                            wordSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/wallpapers/login_image2.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment(0, -1),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onPanStart: (_) => windowManager.startDragging(),
                        child: Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.crisis_alert_rounded,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Erken Erişim",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black26,
                          ),
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.black38,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  Consts.gameName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Gecenin karanlığı içinden geçecek",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          controller.playermute();
                        },
                        icon: Obx(
                          () => Icon(
                            controller.playermuted.value
                                ? Icons.volume_mute_rounded
                                : Icons.volume_down_rounded,
                            color: controller.playermuted.value
                                ? Colors.red
                                : Colors.amber,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Obx(
              () => MouseRegion(
                onEnter: (_) {
                  // Fare butonun üzerine geldiğinde renk değişir
                  controller.isHovered.value = true;
                },
                onExit: (_) {
                  // Fare butondan çıkınca renk eski haline döner
                  controller.isHovered.value = false;
                },
                child: InkWell(
                  onTap: () {
                    exit(0);
                  },
                  child: Container(
                    color: controller.isHovered.value
                        ? Colors.red
                        : Colors.red.withValues(alpha: 0.0),
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
