import 'package:flutter/material.dart';
import 'package:library_app/screens/user/screen/main/user_main_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String usernametyped = 'User';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});

  TextEditingController _namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Tell Us Your Name',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.85)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _namecontroller,
                  decoration: const InputDecoration(
                      hintText: 'Enter your Name',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await usernamesettingsp();
                    await usernamegettersp();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) {
                    //     return const ;
                    //   },
                    // ));
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (ctx) {
                        return const UserMainHomeScreen();
                      },
                    ), (route) => false);
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 79, 103, 92),
                  )),
                  child: const Text('Get Started')),
              const SizedBox(height: 200),
            ],
          ),
        ],
      )),
    );
  }

  Future<void> usernamesettingsp() async {
    final _shared = await SharedPreferences.getInstance();
    _shared.setString('username', _namecontroller.text);
  }

  Future<void> usernamegettersp() async {
    final _shared = await SharedPreferences.getInstance();
    final name = _shared.getString('username');
    name == null || name.isEmpty
        ? usernametyped = 'User'
        : usernametyped = name;
  }
}
