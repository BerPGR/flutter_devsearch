import 'package:flutter/material.dart';
import 'package:search_devs/features/home/screens/desktop.dart';
import 'package:search_devs/features/home/screens/mobile.dart';
import 'package:search_devs/features/home/screens/tablet.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return HomeMobile();
          } else if (constraints.maxWidth < 1200) {
            return HomeTablet();
          } else {
            return HomeDesktop();
          }
        },
      ),
    );
  }
}
