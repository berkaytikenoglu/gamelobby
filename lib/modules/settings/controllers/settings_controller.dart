import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();
  late TabController tabController;
  var pageController = PageController(initialPage: 0).obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);

    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void onClose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    focusNode.dispose();
    super.onClose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape) {
      Get.back();
      return true;
    }
    return false;
  }
}
