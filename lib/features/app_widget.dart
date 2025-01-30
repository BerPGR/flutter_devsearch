import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_devs/features/home/home_bloc.dart';
import 'package:search_devs/features/profile/bloc/profile_bloc.dart';
import 'package:search_devs/services/github_service.dart';
import 'package:search_devs/services/storage_service.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(GithubService(), StorageService())),
          BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(GithubService())),
        ],
        child: MaterialApp.router(
          title: 'Petize Search D_evs',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFFCFCFC),
            primarySwatch: Colors.blue,
          ),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        ));
  }
}
