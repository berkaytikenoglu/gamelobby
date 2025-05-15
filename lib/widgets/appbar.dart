import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appbar {
  static Widget appbarBack(
    String moduleName,
    Function(int page) onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              onTap(0);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.amber,
            ),
          ),
          Text(
            "BACK // ",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            moduleName,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget appbar(
    Function(int page) onTap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.crisis_alert_rounded,
            color: Colors.amber,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.circle_outlined,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "0/4",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.circle_outlined,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "0/3",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.circle_outlined,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "0",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.circle_outlined,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "110",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.circle_outlined,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                "8.62",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            onTap(6);
          },
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }

  static lobbyappbar(
    selectedmenuIndex,
    Function(int page) pageChange,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ClipPath(
        // clipper: TriangleClipper(), // Üçgen şekli
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25), // Alt sol köşe yuvarlak
              bottomRight: Radius.circular(25), // Alt sağ köşe yuvarlak
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => IconButton(
                    onPressed: () {
                      selectedmenuIndex.value = 0;
                      pageChange(0);
                    },
                    icon: Icon(
                      Icons.home,
                      color: selectedmenuIndex.value == 0
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed: () {
                      selectedmenuIndex.value = 1;
                      pageChange(1);
                    },
                    child: Text(
                      "OYNA",
                      style: TextStyle(
                        fontSize: 35,
                        color: selectedmenuIndex.value == 1
                            ? Colors.red
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed: () {
                      selectedmenuIndex.value = 2;
                      pageChange(2);
                    },
                    child: Icon(
                      Icons.star,
                      size: 30,
                      color: selectedmenuIndex.value == 2
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(50, 50);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Üst sol noktaya dön
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
