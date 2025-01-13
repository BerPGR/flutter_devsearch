import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_devs/features/app_module.dart';
import 'package:search_devs/features/app_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final lastRoute = prefs.getString('last_route') ?? '/';
  final lastArgs = prefs.getString('last_args');
  runApp(ModularApp(module: AppModule(initialRoute: lastRoute, initialArgs: lastArgs), child: AppWidget()));
}