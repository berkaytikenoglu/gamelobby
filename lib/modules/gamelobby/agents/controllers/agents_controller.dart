import 'dart:async';
import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cube/flutter_cube.dart';

class AgentsController extends GetxController {
  var rotationY = 0.0.obs;
  Object? carObject;
  Scene? scene;
  void rotate(double deltaX) {
    rotationY.value += deltaX * 0.5; // Döndürme hızı
  }

  void setScene(Scene scene) {
    this.scene = scene;
  }

  ScrollController scrollController = ScrollController();
  double angle = 0;

  late Timer tt;
  @override
  void onInit() {
    super.onInit();
    // carObject = Object(fileName: 'assets/obj/car.obj');
    carObject = Object(fileName: 'assets/obj/Ghost2.obj');

    tt = Timer.periodic(
      Duration(milliseconds: 100),
      (timer) {
        log.log("Rotation Y: ${rotationY.value}");
        rotate(1.0); // Her 100 ms'de 1.0 derece döndür
        if (scene != null) {
          angle += 0.01; // küçük adımlarla artır
          if (angle > 2 * pi) angle = 0;
          double x = 10 * cos(angle);
          double z = 10 * sin(angle);
          double y = 3; // yüksekliği sabit tut
          scene!.camera.position.setValues(x, y, z);
          scene!.update();
        }
      },
    );
  }

  @override
  void onClose() {
    tt.cancel();

    super.onClose();
  }
}
