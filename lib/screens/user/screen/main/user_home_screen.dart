import 'package:flutter/material.dart';
import 'package:library_app/screens/user/login/userlogin.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';
import 'package:library_app/screens/widgets/user/user_homescreen/user_home_screen_grid.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackRequired: false,
        iseditRequired: false,
        titleofpage: 'Welcome $usernametyped ',
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(height: 280, child: UserGrid2Home()),
              SizedBox(height: 280, child: UserGrid1Home()),
              SizedBox(height: 280, child: UserGrid3Home()),
            ],
          ),
        ),
      ),
    );
  }
}
