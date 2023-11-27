import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jpshua/screen/Profile.dart';
import 'package:jpshua/screen/camera_page.dart';
import 'package:jpshua/screen/home_screen.dart';
import 'package:jpshua/utils/appStrings.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/utils/hive_utils.dart';
import 'package:jpshua/utils/session_key.dart';
import 'package:jpshua/widgets/user_avatar.dart';

class _HomeState extends State<BaseHome> {
  int _selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _pageMap = [
      HomeScreen(),
      CameraPage(onBackPressed: () => _onItemTapped(0)),
      Profile(onBackPressed: () => _onItemTapped(0)),
    ];

    return Scaffold(
      extendBody: false,
      backgroundColor: context.theme.primary,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pageMap,
      ),
      bottomNavigationBar: Visibility(
          visible: _selectedIndex != 1,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                ),
              ],
            ),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                backgroundColor: Colors.white,
                iconSize: 32,
                elevation: 10,
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/svg/home.svg"),
                      activeIcon: Icon(Icons.home_filled),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/svg/add.svg"),
                      activeIcon: Icon(Icons.add_box),
                      label: ""),
                  BottomNavigationBarItem(
                      icon: SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: UserAvatar(
                              fontSize: 12.0,
                              userName:
                                  HiveUtils.getSession<String>(SessionKey.name),
                              profileImg: HiveUtils.getSession<String>(
                                          SessionKey.image) !=
                                      "null"
                                  ? "$baseUrl${HiveUtils.getSession<String>(SessionKey.image)}"
                                  : "")),
                      label: ""),
                ],
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black,
                onTap: _onItemTapped),
          )),
    );
  }
}

class BaseHome extends StatefulWidget {
  const BaseHome({super.key});

  @override
  _HomeState createState() => _HomeState();
}
