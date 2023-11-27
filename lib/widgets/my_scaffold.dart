import 'package:flutter/material.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

import '../constants/my_theme.dart';

class MyScaffold extends StatelessWidget {
  Widget child;
  Widget? bottomNavigationBar;
  PreferredSizeWidget? appBar;

  MyScaffold(
      {required this.child, this.appBar, this.bottomNavigationBar, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:context.theme.onPrimary,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFF000000),
          ],
        )),
        child: child,
      ),
    );
  }
}
