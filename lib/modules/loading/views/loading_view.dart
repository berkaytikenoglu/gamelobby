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
                    gradient: RadialGradient(
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.grey,
                      ],
                      center: Alignment.center, // merkezden başlayacak
                      radius: 0.8, // ne kadar genişleyeceği
                      stops: [0.0, 0.5, 1.0], // renklerin konumu (isteğe bağlı)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(90.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.asset(
                      "assets/images/loading/2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 200,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 100)],
                  gradient: LinearGradient(
                    colors: [
                      Colors.black45,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(80),
                    topEnd: Radius.circular(80),
                  ),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Önceki",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 200,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 100)],
                  gradient: LinearGradient(
                    colors: [
                      Colors.black45,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(80),
                    topStart: Radius.circular(80),
                  ),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Sonraki",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Geçmek için",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      "assets/images/keyboard/space.png",
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 100)],
                  gradient: LinearGradient(
                    colors: [
                      Colors.black45,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(80),
                    topEnd: Radius.circular(80),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: LinearBorder(),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.black26,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Geç",
                          style: TextStyle(fontSize: 38),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

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
                      child: Text(
                        "Loading",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        strokeWidth: 5,
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
