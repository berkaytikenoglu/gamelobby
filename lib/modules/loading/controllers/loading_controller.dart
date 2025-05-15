import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class LoadingController extends GetxController {
  final FocusNode focusNode = FocusNode();

  late final player = Player();
  AudioPlayer musicplayer = AudioPlayer();

  late final videoController = VideoController(player);

  var storyimageIndex = 0.obs;
  var storyimagelist = [
    "assets/images/story/h1.png",
    "assets/images/story/h2.png",
    "assets/images/story/h3.png",
    "assets/images/story/h4.png",
    "assets/images/story/h5.png",
    "assets/images/story/h6.png",
    "assets/images/story/h7.png",
    "assets/images/story/h8.png",
  ].obs;
  var isESC = false.obs;

  @override
  void onInit() {
    super.onInit();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    // loadingexiting();

    musicplayer.play(
      AssetSource("sounds/loading.wav"),
    );
  }

  @override
  void onClose() {
    super.onClose();
    player.dispose();
    musicplayer.dispose();
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.escape ||
            event.logicalKey == LogicalKeyboardKey.space) &&
        !isESC.value) {
      isESC.value = true;
      Get.offAndToNamed(AppRoutes.MENU);

      return true;
    }
    return false;
  }

  loadingexiting() async {
    player.open(Media('asset:///assets/videos/intro.mp4'));

    await Future.delayed(Duration(seconds: 30));

    if (isESC.value) {
      return;
    }
    Get.offAndToNamed(AppRoutes.MENU);
  }
}
