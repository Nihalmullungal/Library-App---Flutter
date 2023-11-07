import 'package:flutter/material.dart';
import 'package:library_app/screens/admin/Main%20Screen/admin_main_homscreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

final _formKey = GlobalKey<FormState>();

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    TextEditingController collegeid = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: collegeid,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter the college id";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'College ID',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$')
                          .hasMatch(value)) {
                    return "enter the email id";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter the password";
                  } else {
                    return null;
                  }
                },
                obscuringCharacter: '*',
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        collegeid.text.trim() == '11001' &&
                        email.text.trim() == 'abc@gmail.com' &&
                        password.text.trim() == '1212') {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                        builder: (ctx) {
                          return const AdminmainHomeScreen();
                        },
                      ), (route) => false);
                      final _shared = await SharedPreferences.getInstance();
                      await _shared.setString('LoginState', 'true');

                      setState(() {});
                    } else if (collegeid.text != '11001') {}
                  },
                  child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
