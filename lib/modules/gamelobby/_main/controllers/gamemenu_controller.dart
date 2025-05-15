import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamelobby/helper/api/api_service.dart';
import 'package:gamelobby/helper/applists.dart';
import 'package:gamelobby/helper/functions/api_functions.dart';
import 'package:gamelobby/helper/signalr.dart';
import 'package:get/get.dart';

class GameMenuController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxBool isVisible = false.obs;
  var selectedmenuIndex = 0.obs;
  var selectedmenu = "HOME".obs;
  var pageController = PageController(initialPage: 0).obs;
  var popupSettingsController = false.obs;
  final FocusNode focusNode = FocusNode();

  late AnimationController musicController;

  var searchuserController = TextEditingController().obs;
  Timer? _timer;
  var playingmusic = false.obs;
  var musicIndex = 0.obs;
  var musicCurrentPosition = Duration.zero.obs;
  var musicmaxPosition = Duration.zero.obs;

  var player = AudioPlayer().obs;

  var hoveredfriends = false.obs;

  late APIService api;
  late SignalRService signalRService;

  signalR() async {
    //Signal R //
    api = APIService.instance;
    signalRService = SignalRService(token: api.getToken()!);
    await signalRService.startConnection();
    //Signal R //
  }

  signalRSTOP() async {
    //Signal R //
    await signalRService.stopConnection();
    //Signal R //
  }

  @override
  void onInit() {
    super.onInit();

    signalR();

    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    musicService();
    ApiFunctions.fetchfriends();
    ApiFunctions.friendInvitationList();
    ApiFunctions.lobbyInvitations();

    // ApiFunctions

    musicController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    musicController.forward();
    // Player completion event listener
    player.value.onPlayerComplete.listen((event) {
      // Müzik bittiğinde yeni müziği çal
      playingmusic.value = false; // Döngüyü kes
      playNextMusic();
    });

    updateCurrentPosition(); // Sürekli güncelle
  }

  @override
  void onClose() {
    super.onClose();
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    focusNode.dispose();

    signalRSTOP();
    _timer?.cancel();
    player.value.stop(); // Müzik çalmayı durdur
    player.value.dispose();

    musicController.stop();
    musicController.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape) {
      popupSettingsController.value = false;
      return true;
    }
    return false;
  }

  Future<void> updateCurrentPosition({bool onlyFirst = false}) async {
    if (onlyFirst) {
      musicCurrentPosition.value =
          (await player.value.getCurrentPosition()) ?? Duration.zero;

      musicmaxPosition.value =
          (await player.value.getDuration()) ?? Duration.zero;
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      musicCurrentPosition.value =
          (await player.value.getCurrentPosition()) ?? Duration.zero;

      musicmaxPosition.value =
          (await player.value.getDuration()) ?? Duration.zero;
    });
  }

  musicService() async {
    if (playingmusic.value) {
      return;
    }
    playmusic();
  }

  showmusicInfo() async {
    isVisible.value = true;
    await Future.delayed(Duration(seconds: 10));
    isVisible.value = false;
  }

  playmusic() async {
    if (playingmusic.value) {
      return;
    }

    playingmusic.value = true;

    showmusicInfo();
    await player.value.play(
      AssetSource(AppLists.musicList[musicIndex.value].path),
      volume: 0.3,
    );
  }

  playNextMusic({bool force = false}) async {
    musicIndex.value++; // Bir sonraki müziğe geç
    if (AppLists.musicList.length <= musicIndex.value) {
      musicIndex.value = 0; // Liste sonunda tekrar başa dön
    }
    if (force) {
      await player.value.stop();
      playingmusic.value = false;
    }
    // Yeni müziği çalmaya başla
    await playmusic();
  }

  playBackMusic({bool force = false}) async {
    musicIndex.value--; // Bir sonraki müziğe geç
    if (0 > musicIndex.value) {
      musicIndex.value =
          AppLists.musicList.length - 1; // Liste sonunda tekrar başa dön
    }
    if (force) {
      await player.value.stop();
      playingmusic.value = false;
    }
    // Yeni müziği çalmaya başla
    await playmusic();
  }
}
