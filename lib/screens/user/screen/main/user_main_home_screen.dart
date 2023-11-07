import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/screens/user/screen/main/user_category.dart';
import 'package:library_app/screens/user/screen/main/user_home_screen.dart';
import 'package:library_app/screens/user/screen/main/user_search_screen.dart';
import 'package:library_app/screens/user/screen/main/user_settings.dart';

class UserMainHomeScreen extends StatefulWidget {
  const UserMainHomeScreen({super.key});

  @override
  State<UserMainHomeScreen> createState() => _UserMainHomeScreenState();
}

class _UserMainHomeScreenState extends State<UserMainHomeScreen> {
  int _selectedindex = 0;
  List<Widget> adminnavigationbar = [
    const UserHomeScreen(),
    const UserSearchScreen(),
    const UserCategory(),
    const UserSettings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  void initState() {
    refreshbooks();
    refreshcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: FlashyTabBar(
            backgroundColor: Colors.white10,
            height: 55,
            showElevation: true,
            selectedIndex: _selectedindex,
            items: [
              FlashyTabBarItem(
                  activeColor: const Color.fromARGB(255, 79, 103, 92),
                  inactiveColor: Colors.black.withOpacity(0.7),
                  icon: const Icon(Icons.home),
                  title: const Text('home')),
              FlashyTabBarItem(
                  activeColor: const Color.fromARGB(255, 79, 103, 92),
                  inactiveColor: Colors.black.withOpacity(0.7),
                  icon: const Icon(Icons.search),
                  title: const Text('search')),
              FlashyTabBarItem(
                  activeColor: const Color.fromARGB(255, 79, 103, 92),
                  inactiveColor: Colors.black.withOpacity(0.7),
                  icon: const Icon(Icons.grid_view),
                  title: const Text('categories')),
              FlashyTabBarItem(
                  activeColor: const Color.fromARGB(255, 79, 103, 92),
                  inactiveColor: Colors.black.withOpacity(0.7),
                  icon: const Icon(Icons.settings),
                  title: const Text('settings')),
            ],
            onItemSelected: _onItemTapped),
        body: adminnavigationbar.elementAt(_selectedindex));
  }
}
