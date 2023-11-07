import 'package:flutter/material.dart';
import 'package:library_app/screens/admin/Main%20Screen/admin_login.dart';
import 'package:library_app/screens/user/login/userlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    setuserlogin();
                    return UserLogin();
                  },
                )),
                child: Card(
                  elevation: 50,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Icon(
                        Icons.person_2_rounded,
                        color: Color.fromARGB(255, 79, 103, 92),
                        size: 70,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "User",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.85)),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 150,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return const AdminLogin();
                  },
                )),
                child: Card(
                  elevation: 50,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Icon(
                        Icons.admin_panel_settings_outlined,
                        color: Color.fromARGB(255, 79, 103, 92),
                        size: 70,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Admin",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.85)),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 150,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  Future<void> setuserlogin() async {
    final _shared = await SharedPreferences.getInstance();
    _shared.setBool('LoginStateuser', true);
  }
}
