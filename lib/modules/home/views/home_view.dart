import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/helper/consts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  final Function(int menuIndex, String menuName) function;
  const HomeView({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Consts.gameName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 88,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    color: Colors.purple.withValues(alpha: 0.5),
                    width: 500,
                    child: Center(
                      child: Text(
                        "ERKEN ERİŞİM",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      function(1, "OYNA");
                                    },
                                    child: Text(
                                      "OYNA",
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      function(2, "KARAKTERLER");
                                    },
                                    child: Text(
                                      "KARAKTERLER",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                if (AppLists.newsList.value ==
                                                    null) {
                                                  return;
                                                }

                                                if (AppLists
                                                    .newsList.value!.isEmpty) {
                                                  return;
                                                }
                                                final Uri url = Uri.parse(
                                                    "https://server.aramizdakioyuncu.com/spooky/newsDetail/${AppLists.newsList.value!.first.id}");
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalApplication); // Tarayıcıda aç
                                                } else {
                                                  if (kDebugMode) {
                                                    print("URL açılamıyor.");
                                                  }
                                                }
                                              },
                                              child: Obx(
                                                () => Container(
                                                  width: 300,
                                                  height: 300,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 0.4),
                                                    image: AppLists.newsList
                                                                .value ==
                                                            null
                                                        ? null
                                                        : AppLists.newsList
                                                                .value!.isEmpty
                                                            ? null
                                                            : DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    CachedNetworkImageProvider(
                                                                  "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${AppLists.newsList.value!.first.bannerId}",
                                                                ),
                                                              ),
                                                  ),
                                                  child:
                                                      AppLists.newsList.value ==
                                                              null
                                                          ? Center(
                                                              child:
                                                                  CupertinoActivityIndicator(),
                                                            )
                                                          : AppLists
                                                                  .newsList
                                                                  .value!
                                                                  .isEmpty
                                                              ? Center(
                                                                  child:
                                                                      CupertinoActivityIndicator(),
                                                                )
                                                              : Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  child:
                                                                      Container(
                                                                    height: 50,
                                                                    width: double
                                                                        .infinity,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        192,
                                                                        10,
                                                                        9,
                                                                        65),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Obx(
                                                                        () =>
                                                                            Column(
                                                                          children: [
                                                                            Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Text(
                                                                                "HABER NOTU:",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              AppLists.newsList.value!.first.title,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 10,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () async {
                                                if (AppLists.updateList.value ==
                                                    null) {
                                                  return;
                                                }

                                                if (AppLists.updateList.value!
                                                    .isEmpty) {
                                                  return;
                                                }
                                                final Uri url = Uri.parse(
                                                    "https://server.aramizdakioyuncu.com/spooky/UpdateDetail/${AppLists.updateList.value!.first.id}");
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalApplication); // Tarayıcıda aç
                                                } else {
                                                  if (kDebugMode) {
                                                    print("URL açılamıyor.");
                                                  }
                                                }
                                              },
                                              child: Obx(
                                                () => Container(
                                                  width: 300,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 0.4),
                                                    image: AppLists.updateList
                                                                .value ==
                                                            null
                                                        ? null
                                                        : AppLists.updateList
                                                                .value!.isEmpty
                                                            ? null
                                                            : DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    CachedNetworkImageProvider(
                                                                  "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${AppLists.updateList.value!.first.bannerId}",
                                                                ),
                                                              ),
                                                  ),
                                                  child:
                                                      AppLists.updateList
                                                                  .value ==
                                                              null
                                                          ? Center(
                                                              child:
                                                                  CupertinoActivityIndicator(),
                                                            )
                                                          : AppLists
                                                                  .updateList
                                                                  .value!
                                                                  .isEmpty
                                                              ? Center(
                                                                  child:
                                                                      CupertinoActivityIndicator(),
                                                                )
                                                              : Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  child:
                                                                      Container(
                                                                    height: 50,
                                                                    width: double
                                                                        .infinity,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        192,
                                                                        10,
                                                                        9,
                                                                        65),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "GÜNCELLEME",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Obx(
                                                                            () =>
                                                                                Text(
                                                                              AppLists.updateList.value!.first.title,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 10,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () async {
                                                if (AppLists.newsList.value ==
                                                    null) {
                                                  return;
                                                }

                                                if (AppLists
                                                    .newsList.value!.isEmpty) {
                                                  return;
                                                }
                                                final Uri url = Uri.parse(
                                                    "https://server.aramizdakioyuncu.com/spooky/EventDetail/${AppLists.newsList.value!.first.id}");
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalApplication); // Tarayıcıda aç
                                                } else {
                                                  if (kDebugMode) {
                                                    print("URL açılamıyor.");
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: 300,
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.4),
                                                  image: AppLists.eventList
                                                              .value ==
                                                          null
                                                      ? null
                                                      : AppLists.eventList
                                                              .value!.isEmpty
                                                          ? null
                                                          : DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  CachedNetworkImageProvider(
                                                                "http://185.93.68.107/api/Documents/cd071d3d-b85e-4a4e-bf89-f411297b89d5/${AppLists.eventList.value!.first.bannerId}",
                                                              ),
                                                            ),
                                                ),
                                                child: Obx(
                                                  () =>
                                                      AppLists.eventList
                                                                  .value ==
                                                              null
                                                          ? Center(
                                                              child:
                                                                  CupertinoActivityIndicator(),
                                                            )
                                                          : AppLists
                                                                  .eventList
                                                                  .value!
                                                                  .isEmpty
                                                              ? Center(
                                                                  child:
                                                                      CupertinoActivityIndicator(),
                                                                )
                                                              : Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  child:
                                                                      Container(
                                                                    height: 100,
                                                                    width: double
                                                                        .infinity,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        192,
                                                                        10,
                                                                        9,
                                                                        65),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ETKİNLİK",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Obx(
                                                                            () =>
                                                                                Text(
                                                                              AppLists.eventList.value!.first.title,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () async {
                                                final Uri url = Uri.parse(
                                                    "https://www.google.com");
                                                if (await canLaunchUrl(url)) {
                                                  await launchUrl(url,
                                                      mode: LaunchMode
                                                          .externalApplication); // Tarayıcıda aç
                                                } else {
                                                  if (kDebugMode) {
                                                    print("URL açılamıyor.");
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.4),
                                                ),
                                                child: Container(
                                                  color: const Color.fromARGB(
                                                      192, 10, 9, 65),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "ERKEN ERİŞİM",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Material(
                                                          color: Colors
                                                              .transparent,
                                                          child: ListTile(
                                                            onTap: () {},
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            minVerticalPadding:
                                                                0,
                                                            minTileHeight: 40,
                                                            minLeadingWidth: 0,
                                                            tileColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    92,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            leading: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                Icons
                                                                    .flag_circle,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            ),
                                                            title: Text(
                                                              "CUMHURİYET ÜNİVERSİTESİ",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                            trailing: Container(
                                                              height: 40,
                                                              width: 60,
                                                              color: const Color
                                                                  .fromARGB(104,
                                                                  56, 55, 53),
                                                              child: Center(
                                                                child: Text(
                                                                  "8-10 DK.",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
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
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
