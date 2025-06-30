import 'package:gamelobby/modules/gamelobby/_main/views/gamelobby_view.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';

class GamelobbyModule {
  static const route = AppRoutes.MENU;

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const GamelobbyView(),
    ),
  ];
}
