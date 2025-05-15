import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsWidget {
  static Widget categoryName(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget listtile1button() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      child: Container(
        height: 45,
        color: Colors.white10,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Doğrulanma Durumu",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          Text(
                            "Doğrulanmadı",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          color: Colors.white12,
                          height: 60,
                          width: 100,
                          child: Center(
                            child: Text(
                              "Bağla",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget listTile(
    String title,
    String content,
    Function onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      child: Container(
        height: 45,
        color: Colors.white10,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Material(
                color: Colors.white12,
                child: InkWell(
                  onTap: () {
                    onTap();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            content,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget listtileslider(String title) {
    Rx<double> sliderValue = Rx<double>(0.1);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      child: Container(
        height: 45,
        color: Colors.white10,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white12,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Obx(
                            () => Text(
                              ((sliderValue.value * 100).round()).toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Obx(
                          () => Slider(
                            thumbColor: Colors.white,
                            activeColor: Colors.red,
                            inactiveColor: Colors.white12,
                            value: sliderValue.value,
                            onChanged: (value) {
                              sliderValue.value = value;
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget listtilebuttons(String title, String option1, String option2) {
    var selectedbuttonIndex = 1.obs;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      child: Container(
        height: 45,
        color: Colors.white10,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: Colors.transparent,
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            selectedbuttonIndex.value = 0;
                          },
                          child: Container(
                            color: selectedbuttonIndex.value == 0
                                ? Colors.white24
                                : Colors.white12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  option1,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1),
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: Colors.transparent,
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            selectedbuttonIndex.value = 1;
                          },
                          child: Container(
                            color: selectedbuttonIndex.value == 1
                                ? Colors.white24
                                : Colors.white12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  option2,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
