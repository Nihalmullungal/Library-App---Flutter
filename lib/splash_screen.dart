import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_app/accounttype.dart';
import 'package:library_app/screens/admin/Main%20Screen/admin_main_homscreen.dart';
import 'package:library_app/screens/user/login/userlogin.dart';
import 'package:library_app/screens/user/screen/main/user_main_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

late final LoginState;
late final LoginStateuser;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (LoginState != null || LoginStateuser == true) {
        if (LoginState == 'true') {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const AdminmainHomeScreen();
          }));
        } else if (LoginStateuser) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const UserMainHomeScreen();
          }));
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const AccountType();
          }));
        }
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          return const AccountType();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getstatus();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'asset/SplashScreen/load.gif',
          ),
        ),
      ),
    );
  }

  Future<void> getstatus() async {
    final shared = await SharedPreferences.getInstance();
    LoginState = shared.getString('LoginState');
    LoginStateuser = shared.getBool('LoginStateuser');
    await usernamegettersp();
  }

  Future<void> usernamegettersp() async {
    final _shared = await SharedPreferences.getInstance();
    final name = _shared.getString('username');
    name == null || name.isEmpty
        ? usernametyped = 'User'
        : usernametyped = name;
  }
}
