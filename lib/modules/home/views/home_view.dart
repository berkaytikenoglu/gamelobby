import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
                    "WARS OF CIVIL",
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
                        "CAPTURE : 1",
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
                                      function(1, "PLAY");
                                    },
                                    child: Text(
                                      "PLAY",
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
                                              onTap: () {},
                                              child: Container(
                                                width: 300,
                                                height: 350,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.4),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      "https://blog.monsternotebook.com.tr/wp-content/uploads/Valorant-Gece-Pazari.jpg",
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "GECE PAZARI",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        "14/02/25 /// 05/03/25",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: 300,
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 0.4),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      "https://cmsassets.rgpub.io/sanity/images/dsfx7636/news_live/452d4b51b39911fc6ca97c997fb189b3bb27e800-1920x1080.jpg?auto=format&fit=fill&q=80&w=1082",
                                                    ),
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 50,
                                                    color: const Color.fromARGB(
                                                        192, 10, 9, 65),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "VALORANT MASTERS BANGKOK FİNALİ BU HAFTA SONU",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () {},
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
                                                          "YAMA  NOTLARI",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "10.03 > Güvenlik",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        Text(
                                                          "10.02 > Yanıt Verme Süresi",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            InkWell(
                                              onTap: () {},
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
                                                          "ÖNE ÇIKAN MODLAR",
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
                                                              "TAKIMLI ÖLÜM KALIM SAVAŞI",
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
