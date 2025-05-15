import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AgentsView extends StatelessWidget {
  const AgentsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(WarticketController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "https://cmsassets.rgpub.io/sanity/images/dsfx7636/news/51e62f3c74356a7501d06feba42ac643133257d7-616x822.png?auto=format&fit=fill&q=80&w=352",
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          "Öncü",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "GEKKO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          """
                    Los Atweles çoc"u Gekkö yaratıklardan oluşan
                    tayfasma atm•kta. Gekko•nun
                    tayfası İleri atılarak başına
                    olur. Sonrasırda Gekko onları toplar ve Hrllkte
                    tekrar olacak düşrnan aramaya koyulurlar.

                    ÖNCÜ
                    Öncüler, ilerlemesi tehlikeli köşeleri aşabilmeleri
                    için takımlarına olanaklar yaratır,
                    """,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: LinearBorder(),
                  padding: EdgeInsets.all(0),
                ),
                onPressed: () {},
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue.withValues(alpha: 0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("SAFLARINA KAT"),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white30,
                      child: Center(
                        child: Text(
                          "GEKKO",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                  5,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    "https://cmsassets.rgpub.io/sanity/images/dsfx7636/news/51e62f3c74356a7501d06feba42ac643133257d7-616x822.png?auto=format&fit=fill&q=80&w=352",
                              ),
                            ),
                            LinearProgressIndicator(
                              value: 0.4,
                              color: Colors.amber,
                              backgroundColor: Colors.amber.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
