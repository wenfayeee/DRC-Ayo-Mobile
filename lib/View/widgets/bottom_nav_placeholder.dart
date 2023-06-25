import 'package:event_management_app/View/pages/profile_page.dart';
import 'package:event_management_app/View/pages/create_event_page.dart';
import 'package:event_management_app/View/pages/home_page.dart';
import 'package:event_management_app/View/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class BottomNavPlaceholder extends StatefulWidget {
  const BottomNavPlaceholder({Key? key}) : super(key: key);

  @override
  State<BottomNavPlaceholder> createState() => _BottomNavPlaceholderState();
}

class _BottomNavPlaceholderState extends State<BottomNavPlaceholder>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          HomePage(),
          CreateEventPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        tabController: _tabController,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
