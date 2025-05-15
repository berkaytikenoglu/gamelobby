import 'package:gamelobby/modules/gamelobby/_main/views/gamemenu_view.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';

class GamemenuModule {
  static const route = AppRoutes.MENU;

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const GamemenuView(),
    ),
  ];
}
