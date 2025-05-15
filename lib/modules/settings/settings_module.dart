import 'package:gamelobby/modules/settings/views/settings_view.dart';
import 'package:gamelobby/routes/app_pages.dart';
import 'package:get/get.dart';

class SettingsModule {
  static const route = AppRoutes.SETTINGS;

  static final List<GetPage> routes = [
    GetPage(
      name: route,
      page: () => const SettingsView(),
    ),
  ];
}
