import 'package:flutter/material.dart';
import 'package:gamelobby/modules/loading/controllers/loading_controller.dart';
import 'package:get/get.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoadingController());

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: RadialGradient(
                      colors: [
                        Colors.grey,
                        Colors.black,
                        Colors.black,
                      ],
                      center: Alignment.center, // merkezden başlayacak
                      radius: 0.8, // ne kadar genişleyeceği
                      stops: [0.0, 0.5, 1.0], // renklerin konumu (isteğe bağlı)
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(seconds: 1), // Animasyon süresi
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      // Geçiş animasyonu: fade in/out veya diğer geçiş türlerini burada ayarlayabilirsin
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: ColorFiltered(
                      key: ValueKey<int>(controller.storyimageIndex.value),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0),
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        controller
                            .storyimagelist[controller.storyimageIndex.value],
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/keyboard/space.png",
                              height: 25,
                            ),
                            Text(
                              "Atla",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/keyboard/left.png",
                              height: 25,
                            ),
                            Text(
                              "Geri",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/keyboard/right.png",
                              height: 25,
                            ),
                            Text(
                              "İleri",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => Text(
                          "${controller.storyimageIndex.value + 1}/${controller.storyimagelist.length}",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => (!controller.isgameStarting.value)
                  ? SizedBox.shrink()
                  : Container(
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          "Oyun Başlıyor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
