import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/functions/api_functions.dart';
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

  void matchsearchingDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Center(
            child: Row(
              children: [Text("Maç Aranıyor")],
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Obx(
                        () => Text(
                          matchsearchingtime.value.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text("En kısa zamanda uygun bir takımla yüzleşeceksiniz"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  bool result = await ApiFunctions.matchStopSearch();

                  if (result) {
                    Get.back();
                    stopTimer();
                    return;
                  }
                },
                child: Text(
                  "İPTAL ET",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
