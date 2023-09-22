import 'package:flutter/material.dart';
import 'package:international_news_app/View/News_Homepage.dart';
import 'package:international_news_app/View/profile.dart';
import 'package:international_news_app/View/save.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Bottom_Nav_Bar extends StatefulWidget {
  const Bottom_Nav_Bar({Key? key}) : super(key: key);

  @override
  State<Bottom_Nav_Bar> createState() => _Bottom_Nav_BarState();
}

class _Bottom_Nav_BarState extends State<Bottom_Nav_Bar> {
  final controler = PersistentTabController(initialIndex: 0);
  List<Widget> buildscreen() {
    return [
      const News_Homepage(),
      const Saved_items(),
      const User_Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> navitem() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined, color: Colors.black54)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.bookmark),
          inactiveIcon: const Icon(Icons.bookmark_border_outlined,
              color: Colors.black54)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon:
              const Icon(Icons.person_outline, color: Colors.black54)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: buildscreen(),
      items: navitem(),
      backgroundColor: Colors.grey.shade100.withOpacity(.9),
      controller: controler,
      decoration: NavBarDecoration(
          border: Border.all(color: Colors.black.withOpacity(.05)),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.neumorphic,
    );
  }
}
