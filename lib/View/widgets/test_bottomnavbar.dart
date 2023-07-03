import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';

class TestNav extends StatefulWidget {
  final List<PersistentTabItem> items;

  const TestNav({Key? key, required this.items}) : super(key: key);

  @override
  _TestNavState createState() => _TestNavState();
}

class _TestNavState extends State<TestNav> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: IndexedStack(
        index: _selectedTab,
        children: [
          widget.items.map((page) => Navigator(
                key: page.navigatorkey,
              ))
        ],
      )),
      onWillPop: () async {
        if (widget.items[_selectedTab].navigatorkey?.currentState?.canPop() ??
            false) {
          widget.items[_selectedTab].navigatorkey?.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
    );
  }
}
