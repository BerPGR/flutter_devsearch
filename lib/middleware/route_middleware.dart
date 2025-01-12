import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveRouteMiddleware extends RouteGuard {
  SaveRouteMiddleware() : super(redirectTo: '/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final prefs = await SharedPreferences.getInstance();
    // Salva a rota e os argumentos no local storage
    await prefs.setString('last_route', route.uri.toString());
    if (route.args != null) {
      await prefs.setString('last_args', route.args?.toJson().toString() ?? '');
    }
    return true;
  }
}

extension on ModularRoute {
  get args => null;
}
