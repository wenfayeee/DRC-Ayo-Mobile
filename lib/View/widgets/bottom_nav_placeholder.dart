import 'package:event_management_app/View/pages/profile_page.dart';
import 'package:event_management_app/View/pages/create_event_page.dart';
import 'package:event_management_app/View/pages/home_page.dart';
import 'package:event_management_app/View/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavPlaceholder extends StatefulWidget {
  final String? token;
  const BottomNavPlaceholder({
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavPlaceholder> createState() => _BottomNavPlaceholderState();
}

class _BottomNavPlaceholderState extends State<BottomNavPlaceholder>
    with SingleTickerProviderStateMixin {
  String? token;
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {
    //     setState(() {
    //       _currentIndex = _tabController.index;
    //     });
    //   }
    // });
  }

  void getTokenFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');

    if (storedToken != null) {
      setState(() {
        token = storedToken;
        print(token);
      });
      decodeToken();
    }
  }

  Map<String, dynamic>? decodeToken() {
    if (token != null) {
      return JwtDecoder.decode(token!);
    }
    return null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          HomePage(token: widget.token!),
          CreateEventPage(token: widget.token!),
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
