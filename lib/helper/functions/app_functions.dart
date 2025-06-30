import 'package:flutter/material.dart';
import 'package:gamelobby/helper/models/signalr/matchstatistics_event.dart';
import 'package:get/get.dart';

class TeamUser {
  final User user;
  final int killCount;
  final int hitCount;

  TeamUser({
    required this.user,
    required this.killCount,
    required this.hitCount,
  });
}

class AppFunctions {
  static void showMatchStatistics({
    required MatchStatisticsEvent matchStatistics,
    required String imagePath,
  }) {
    List<TeamUser> team1 = [];
    List<TeamUser> team2 = [];

    for (var element in matchStatistics.statistics) {
      if (element.teamType == "Team1") {
        team1.add(
          TeamUser(
            user: element.user,
            killCount: element.killCount,
            hitCount: element.hitCount,
          ),
        );
      }
      if (element.teamType == "Team2") {
        team2.add(
          TeamUser(
            user: element.user,
            killCount: element.killCount,
            hitCount: element.hitCount,
          ),
        );
      }
    }
    Get.defaultDialog(
      backgroundColor: Colors.black,
      title: "Maç Sonu İstatistik",
      content: SizedBox(
        width: 1000,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Image.asset(imagePath, width: 100, height: 100),
                SizedBox(height: 10),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Table(
                    border: TableBorder.all(color: Colors.white),
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FixedColumnWidth(50),
                      2: FixedColumnWidth(50),
                    },
                    children: [
                      // Başlık satırı
                      TableRow(
                        decoration: BoxDecoration(color: Colors.red),
                        children: [
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Takım 1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Kill',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Hit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ],
                      ),
                      ...List.generate(
                        team1.length,
                        (index) {
                          return TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(team1[index].user.username,
                                    style: TextStyle(color: Colors.white)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  team1[index].killCount.toString(),
                                  style: TextStyle(color: Colors.greenAccent),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  team1[index].hitCount.toString(),
                                  style: TextStyle(color: Colors.greenAccent),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                Expanded(
                  child: Table(
                    border: TableBorder.all(color: Colors.white),
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FixedColumnWidth(50),
                      2: FixedColumnWidth(50),
                    },
                    children: [
                      // Başlık satırı
                      TableRow(
                        decoration: BoxDecoration(color: Colors.blue),
                        children: [
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Takım 2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )),
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Kill',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          TableCell(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Hit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ],
                      ),
                      ...List.generate(
                        team2.length,
                        (index) {
                          return TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(team2[index].user.username,
                                    style: TextStyle(color: Colors.white)),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  team2[index].killCount.toString(),
                                  style: TextStyle(color: Colors.greenAccent),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  team2[index].hitCount.toString(),
                                  style: TextStyle(color: Colors.greenAccent),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back(); // Dialog'ı kapat
        },
        child: Text('OK'),
      ),
    );
  }
}
