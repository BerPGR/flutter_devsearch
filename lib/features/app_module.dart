import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_devs/features/home/home_page.dart';
import 'package:search_devs/features/profile/profile_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => HomePage()),
    ChildRoute('/profile', child: (_,args) => ProfilePage(user: args.data,)),
  ];
}