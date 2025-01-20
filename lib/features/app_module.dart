import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_devs/features/home/home_page.dart';
import 'package:search_devs/features/profile/profile_page.dart';

class AppModule extends Module {

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => HomePage(),
        ),
        ChildRoute(
          '/profile',
          child: (_, args) => ProfilePage(user: args.data),
        ),
      ];
}
