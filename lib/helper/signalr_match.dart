import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/helper/functions/app_functions.dart';
import 'package:gamelobby/helper/models/signalr/matchstatistics_event.dart';
import 'package:gamelobby/helper/signalr.dart';
import 'package:gamelobby/modules/gamelobby/_main/controllers/gamelobby_controller.dart';
import 'package:get/get.dart';

import 'package:signalr_netcore/signalr_client.dart';
import 'package:window_manager/window_manager.dart';

class SignalRMatchService {
  late HubConnection hubConnection;
  final String serverUrl = "http://185.93.68.107/InMatchHub";
  final String token;

  final AudioPlayer audioPlayer = AudioPlayer();

  SignalRMatchService({required this.token}) {
    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => token,
              // headers:
              //     MessageHeaders(), // Alternatif olarak header içinde gönderebilirsin
            ))
        .withAutomaticReconnect() // Bağlantı koparsa otomatik bağlanır
        .build();

    matchStatistics();
  }

  /// SignalR bağlantısını başlat
  Future<void> startConnection() async {
    try {
      await hubConnection.start();
      if (kDebugMode) {
        print("SignalR bağlantısı başarılı!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Bağlantı hatası: $e");
      }
    }
  }

  /// SignalR bağlantısını kapat
  Future<void> stopConnection() async {
    await hubConnection.stop();

    if (kDebugMode) {
      print("SignalR bağlantısı kapatıldı.");
    }
  }

  Future<void> killProcessBypid(String pid) async {
    log("killProcessBypid: $pid");
    try {
      await Process.run('taskkill', ['/PID', pid, '/F']);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> fetchmatchStatistic(int? matchID) async {
    if (matchID == null) {
      log("(fetchmatchStatistic) Match ID is null, cannot fetch match statistics.");
      return;
    }
    APIService api = APIService.instance;
    MatchStatisticsEvent? response = await api.matchStatistic(matchID);
    if (response == null) {
      log("(fetchmatchStatistic) Match statistics response is null.");
      return;
    }
    AppFunctions.showMatchStatistics(
      matchStatistics: response,
      imagePath: "assets/images/character/ch1.png",
    );
  }

  void matchStatistics() {
    hubConnection.on("MatchEnd", (arguments) async {
      if (arguments != null && arguments.isNotEmpty) {
        log("Lobby MatchEnd! ${arguments[0]}");
        // Veri tipinin string olduğundan emin ol

        try {
          // JSON string'ini decode et
          final String jsonString = jsonEncode(arguments[0]);
          Map<String, dynamic> json = jsonDecode(jsonString);

          if (GameContex.game != null) {
            log("GameContex.game is not null, killing process with pid: ${GameContex.game!.pid}");
            await killProcessBypid(GameContex.game!.pid.toString());

            await windowManager.show();
            final playercontroller = Get.put(GamelobbyController());

            playercontroller.player.value.resume();
          }

          fetchmatchStatistic(json['matchId']);
          // JSON verisini modele dönüştür

          log("-----------MatchEnd-----------");
        } catch (e) {
          // JSON çözme hatası durumunda logla
          log("JSON çözme hatası (MatchEnd): ${e.toString()}");
        }
      }
    });
  }
}
