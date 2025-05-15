import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/helper/models/api/login.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  FocusNode usernamefocus = FocusNode();
  FocusNode userpassfocus = FocusNode();
  var rememberMe = false.obs;
  var usernameController = TextEditingController().obs;
  var userpasswordController = TextEditingController().obs;
  var isHovered = false.obs;

  var player = AudioPlayer().obs;

  var playermuted = false.obs;
  @override
  void onInit() {
    tabController = TabController(length: 1, vsync: this);
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    startloginmusic();
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose(); // Bellek sızıntısını önlemek için
    player.value.dispose();
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.onClose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
      if (usernameController.value.text == "") {
        FocusScope.of(Get.context!).requestFocus(usernamefocus);
        return true;
      }

      if (userpasswordController.value.text == "") {
        FocusScope.of(Get.context!).requestFocus(userpassfocus);
        return true;
      }

      login(usernameController.value.text, userpasswordController.value.text);
      return true;
    }
    return false;
  }

  startloginmusic() async {
    await player.value.play(
      AssetSource("sounds/wellcome.mp3"),
      volume: playermuted.value ? 0.0 : 0.3,
    );

    player.value.onPlayerComplete.listen((event) {
      // Müzik bittiğinde yeni müziği çal
      startloginmusic();
    });
  }

  playermute() async {
    if (playermuted.value) {
      await player.value.setVolume(0.3);
      playermuted.value = false;
    } else {
      await player.value.setVolume(0);
      playermuted.value = true;
    }
  }

  login(String username, String password) async {
    APIService api = APIService.instance;
    APILogin? response = await api.login(
      username: username,
      password: password,
    );

    if (response == null) {
      return;
    }

    await windowManager.hide();
    await Future.delayed(Duration(seconds: 1));

    Get.offAndToNamed(AppRoutes.LOADING);
    await Future.delayed(Duration(milliseconds: 500));

    await windowManager.setFullScreen(true);

    await Future.delayed(Duration(seconds: 1));
    await windowManager.show();
  }
}
