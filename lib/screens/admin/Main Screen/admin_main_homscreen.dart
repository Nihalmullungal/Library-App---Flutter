import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/screens/admin/category/admin_category.dart';
import 'package:library_app/screens/admin/Main%20Screen/admin_homescreen.dart';
import 'package:library_app/screens/admin/Main%20Screen/admin_search_screen.dart';
import 'package:library_app/screens/admin/Main%20Screen/admin_settings.dart';

class AdminmainHomeScreen extends StatefulWidget {
  const AdminmainHomeScreen({super.key});

  @override
  State<AdminmainHomeScreen> createState() => _AdminmainHomeScreenState();
}

class _AdminmainHomeScreenState extends State<AdminmainHomeScreen> {
  int _selectedindex = 0;
  List<Widget> adminnavigationbar = [
    const AdminHomeScreen(),
    const AdminSearchScreen(),
    const AdminCategory(),
    const AdminSettings()
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
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.shifting,
        //   currentIndex: _selectedindex,
        //   onTap: _onItemTapped,
        //   unselectedItemColor: Colors.black,
        //   selectedItemColor: Colors.blueGrey,
        //   showUnselectedLabels: true,
        //   items: const [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.home),
        //         label: 'home',
        //         backgroundColor: Color.fromARGB(1000, 35, 45, 63)),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.search),
        //         label: 'search',
        //         backgroundColor: Color.fromARGB(1000, 178, 200, 186)),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.grid_view),
        //         label: 'categories',
        //         backgroundColor: Color.fromARGB(1000, 178, 200, 186)),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.settings),
        //         label: 'settings',
        //         backgroundColor: Color.fromARGB(1000, 178, 200, 186)),
        //   ],
        // ),
        body: adminnavigationbar.elementAt(_selectedindex));
  }
}
