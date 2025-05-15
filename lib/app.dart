import 'package:flutter/material.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:gamelobby/theme/theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARMOYU GAME',
      theme: appLightThemeData,
      darkTheme: appDarkThemeData,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
