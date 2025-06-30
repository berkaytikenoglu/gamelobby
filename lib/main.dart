import 'package:flutter/material.dart';
import 'package:gamelobby/app.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //WindowsManager
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(600, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false, //Görev Çubuğunda Gözükmesin ise true
    titleBarStyle: TitleBarStyle.hidden,

    fullScreen: false,
  );

  windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );
  windowManager.setResizable(false);

  runApp(const MyApp());
}
