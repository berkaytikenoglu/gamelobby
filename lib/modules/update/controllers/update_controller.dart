import 'package:flutter/material.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:window_manager/window_manager.dart';

class UpdateController extends GetxController {
  late final player = Player();
  late final videoController = VideoController(player);

  var isESC = false.obs;

  @override
  void onInit() {
    super.onInit();
    // HardwareKeyboard.instance.addHandler(_handleKeyEvent);

    player.open(Media('asset:///assets/videos/intro2.mp4'));
    updateControl();
  }

  @override
  void onClose() {
    super.onClose();
    // HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    player.dispose();
  }

  // bool _handleKeyEvent(KeyEvent event) {
  //   if (event is KeyDownEvent &&
  //       event.logicalKey == LogicalKeyboardKey.escape &&
  //       !isESC.value) {
  //     isESC.value = true;
  //     Get.offAndToNamed(AppRoutes.LOGIN);

  //     return true;
  //   }
  //   return false;
  // }

  updateControl() async {
    await Future.delayed(Duration(seconds: 2));

    await windowManager.hide();
    await Future.delayed(Duration(milliseconds: 500));

    await windowManager.setSize(Size(1000, 600));
    await windowManager.setAlignment(Alignment.center);

    if (!isESC.value) {
      Get.offAndToNamed(AppRoutes.LOGIN);
    }

    await Future.delayed(Duration(milliseconds: 500));

    await windowManager.show();
  }
}
