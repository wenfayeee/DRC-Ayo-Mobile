import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final TabController tabController;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.tabController,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      controller: widget.tabController,
      style: TabStyle.react,
      items: const [
        TabItem(
          icon: Icon(Icons.home_sharp, size: 30, color: Color(0xFFB0C6D4)),
        ),
        TabItem(
          icon: Icon(Icons.add_box, size: 30, color: Color(0xFFB0C6D4)),
        ),
        TabItem(
          icon: Icon(Icons.person_2_sharp, size: 30, color: Color(0xFFB0C6D4)),
        ),
      ],
      backgroundColor: Color(0xFF202926),
      initialActiveIndex: 0,
      onTap: widget.onTap,
    );
  }
}

  // Widget build(BuildContext context) {
  //   return BlocBuilder<BottomNavCubit, int>(builder: (context, index) {
  //     return ConvexAppBar(
  //       style: TabStyle.react,
  //       items: const [
  //         TabItem(
  //           icon: Icons.home,
  //           title: 'Home',
  //         ),
  //         TabItem(
  //           icon: Icons.edit_calendar_sharp,
  //           title: 'Create Event',
  //         ),
  //         TabItem(
  //           icon: Icons.person_2_sharp,
  //           title: 'Account',
  //         ),
  //       ],
  //       backgroundColor: const Color(0xFF858378),
  //       initialActiveIndex: index,
  //       onTap: (int newIndex) {
  //         context.read<BottomNavCubit>().updateIndex(newIndex, context);
  //       },
  //     );
  //   });
  // }
