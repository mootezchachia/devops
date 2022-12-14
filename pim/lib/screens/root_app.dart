import 'package:flutter/material.dart';
import 'package:pim/screens/participated.dart';
import 'package:pim/screens/bookmarked.dart';
import 'package:pim/screens/profile_view.dart';
import 'package:pim/theme/color.dart';
import 'package:pim/utils/constant.dart';
import 'package:pim/widgets/bottombar_item.dart';

import 'home.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int activeTab = 0;

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    List barItems = [
      {
        "icon": "assets/icons/home.svg",
        "active_icon": "assets/icons/home.svg",
        "page": HomePage(),
      },
      {
        "icon": "assets/icons/bookmark.svg",
        "active_icon": "assets/icons/bookmark.svg",
        "page": const Bookmarked(),
      },
      {
        "icon": "assets/icons/article.svg",
        "active_icon": "assets/icons/article.svg",
        "page": const Participated(),
      },
      {
        "icon": "assets/icons/profile.svg",
        "active_icon": "assets/icons/profile.svg",
        "page": const ProfileScreen(),
      },
    ];
    return Scaffold(
        backgroundColor: appBgColor,
        bottomNavigationBar: getBottomBar(barItems),
        body: getBarPage(barItems));
  }

  Widget getBarPage(List barItems) {
    return IndexedStack(
        index: activeTab,
        children: List.generate(
            barItems.length, (index) => animatedPage(barItems[index]["page"])));
  }

  Widget getBottomBar(List barItems) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bottomBarColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
                offset: const Offset(1, 1))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            barItems.length,
            (index) => BottomBarItem(
              barItems[index]["icon"],
              isActive: activeTab == index,
              activeColor: primary,
              onTap: () {
                onPageChanged(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
