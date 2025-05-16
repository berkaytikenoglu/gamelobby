import 'package:flutter/material.dart';
import 'package:gamelobby/modules/loading/controllers/loading_controller.dart';
import 'package:get/get.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoadingController());

    return MouseRegion(
      // cursor: SystemMouseCursors.none,
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
                  // child: Obx(
                  //   () => Image.asset(
                  //     controller
                  //         .storyimagelist[controller.storyimageIndex.value],
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Obx(
                    () => Image.asset(
                      controller
                          .storyimagelist[controller.storyimageIndex.value],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     height: 200,
            //     width: 100,
            //     decoration: BoxDecoration(
            //       boxShadow: [BoxShadow(blurRadius: 100)],
            //       gradient: LinearGradient(
            //         colors: [
            //           Colors.black45,
            //           Colors.black,
            //           Colors.black,
            //           Colors.black,
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //       borderRadius: BorderRadiusDirectional.only(
            //         bottomEnd: Radius.circular(80),
            //         topEnd: Radius.circular(80),
            //       ),
            //     ),
            //     child: InkWell(
            //       onTap: () {
            //         if (controller.storyimageIndex > 0) {
            //           controller.storyimageIndex--;
            //         }
            //       },
            //       child: Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(
            //             "Önceki",
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Container(
            //     height: 200,
            //     width: 100,
            //     decoration: BoxDecoration(
            //       boxShadow: [BoxShadow(blurRadius: 100)],
            //       gradient: LinearGradient(
            //         colors: [
            //           Colors.black45,
            //           Colors.black,
            //           Colors.black,
            //           Colors.black,
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //       borderRadius: BorderRadiusDirectional.only(
            //         bottomStart: Radius.circular(80),
            //         topStart: Radius.circular(80),
            //       ),
            //     ),
            //     child: InkWell(
            //       onTap: () {
            //         if (controller.storyimageIndex < 7) {
            //           controller.storyimageIndex++;
            //         }
            //       },
            //       child: Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(
            //             "Sonraki",
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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

            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       boxShadow: [BoxShadow(blurRadius: 100)],
            //       gradient: LinearGradient(
            //         colors: [
            //           Colors.black45,
            //           Colors.black,
            //           Colors.black,
            //           Colors.black,
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //       borderRadius: BorderRadiusDirectional.only(
            //         topStart: Radius.circular(80),
            //         topEnd: Radius.circular(80),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: SizedBox(
            //         width: 300,
            //         child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             shape: LinearBorder(),
            //             backgroundColor: Colors.transparent,
            //             shadowColor: Colors.black26,
            //           ),
            //           onPressed: () {},
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Text(
            //               "Geç",
            //               style: TextStyle(fontSize: 38),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   child: Video(
            //     controls: (state) {
            //       return SizedBox.shrink();
            //     },
            //     fit: BoxFit.cover,
            //     controller: controller.videoController,
            //   ),
            // ),
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
          ],
        ),
      ),
    );
  }
}
