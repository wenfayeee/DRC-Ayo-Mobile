import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  String location;
  BottomNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.edit_calendar_sharp, title: 'Create Event'),
          TabItem(icon: Icons.person_2_sharp, title: 'Account'),
        ],
        backgroundColor: Colors.blueGrey,
        initialActiveIndex: 0,
      ),
    );
  }
}
