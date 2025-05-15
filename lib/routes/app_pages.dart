import 'package:gamelobby/modules/gamelobby/_main/gamemenu_module.dart';
import 'package:gamelobby/modules/loading/loading_module.dart';
import 'package:gamelobby/modules/login/login_module.dart';
import 'package:gamelobby/modules/settings/settings_module.dart';
import 'package:gamelobby/modules/update/update_module.dart';

class AppRoutes {
  // ignore: constant_identifier_names
  static const MENU = "/MENU";
  // ignore: constant_identifier_names
  static const LOGIN = "/login";
  // ignore: constant_identifier_names
  static const UPDATE = "/update";
  // ignore: constant_identifier_names
  static const SETTINGS = "/settings";
  // ignore: constant_identifier_names
  static const LOADING = "/loading";
}

class AppPages {
  static const initial = UpdateModule.route;

  static final routes = [
    ...UpdateModule.routes,
    ...LoadingModule.routes,
    ...LoginModule.routes,
    ...GamemenuModule.routes,
    ...SettingsModule.routes,
  ];
}
