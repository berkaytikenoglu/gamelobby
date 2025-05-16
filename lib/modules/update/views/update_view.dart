import 'package:flutter/material.dart';
import 'package:gamelobby/modules/update/controllers/update_controller.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateController());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/wallpapers/1.png",
                ),
              ),
            ),
            // child: Column(
            //   children: [
            //     Expanded(
            //       child: SizedBox(
            //         height: 500,
            //         child: Video(
            //           controls: (state) {
            //             //Controlleri sildim
            //             return SizedBox.shrink();
            //           },
            //           fit: BoxFit.cover,
            //           controller: controller.videoController,
            //         ),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.bottomCenter,
            //       child: LinearProgressIndicator(
            //         color: Colors.red,
            //         backgroundColor: Colors.red.withValues(alpha: 0.5),
            //       ),
            //     ),
            //   ],
            // ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: GestureDetector(
              onPanStart: (_) => windowManager.startDragging(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
