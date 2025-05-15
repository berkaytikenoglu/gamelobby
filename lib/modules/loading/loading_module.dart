import 'package:gamelobby/modules/loading/views/loading_view.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';

class LoadingModule {
  static const route = AppRoutes.LOADING;

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const LoadingView(),
    ),
  ];
}
