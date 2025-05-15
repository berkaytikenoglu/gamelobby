import 'dart:async';
import 'package:get/get.dart';

class UnratedController extends GetxController {
  var matchsearchingtime = 0.obs;
  Timer? _timer;

  void startTimer() {
    stopTimer(); // önceki timer varsa iptal et
    matchsearchingtime.value = 0; // sıfırla

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      matchsearchingtime.value++;
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}
