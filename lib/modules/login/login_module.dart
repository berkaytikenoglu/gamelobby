import 'package:gamelobby/modules/login/views/login_view.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginModule {
  static const route = AppRoutes.LOGIN;

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const LoginView(),
    ),
  ];
}
