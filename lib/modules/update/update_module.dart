import 'package:gamelobby/modules/update/views/update_view.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';

class UpdateModule {
  static const route = AppRoutes.UPDATE;

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const UpdateView(),
    ),
  ];
}
