import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ficonsax/ficonsax.dart';

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
      style: TabStyle.reactCircle,
      curveSize: 100.0,
      height: 50.0,
      items: const [
        TabItem(
          icon: Icon(IconsaxBold.home, size: 30.0, color: Color(0xFFB2BBDA)),
        ),
        TabItem(
          icon: Icon(IconsaxBold.add_square,
              size: 30.0, color: Color(0xFFB2BBDA)),
        ),
        TabItem(
          icon: Icon(IconsaxBold.user, size: 30.0, color: Color(0xFFB2BBDA)),
        ),
      ],
      backgroundColor: const Color(0xFF1E3765),
      initialActiveIndex: 0,
      activeColor: const Color(0xFFF8F7F2),
      onTap: widget.onTap,
    );
  }
}
