import 'dart:math';

import 'package:flutter/material.dart';
import 'package:library_app/accounttype.dart';
import 'package:library_app/dbfunctions/main_db.dart';
import 'package:library_app/screens/common/about_us.dart';
import 'package:library_app/screens/common/report_issue.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';
import 'package:library_app/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSettings extends StatelessWidget {
  const AdminSettings({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _number = TextEditingController();
    final _key = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Settings',
          isBackRequired: false,
          iseditRequired: false),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Hi Admin,',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const AboutUs()));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                      'About Us',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.star),
                  title: Text(
                    'Rate Us',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const ReportIssue()));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.bug_report),
                    title: Text(
                      'Report Issue',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Random number = Random();
                    final randomnumber = number.nextInt(10000);
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            content: const Text("You are to about clear data"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (ctx1) {
                                          return AlertDialog(
                                            content: Text(
                                                'Enter this number $randomnumber'),
                                            actions: [
                                              Form(
                                                  key: _key,
                                                  child: TextFormField(
                                                    controller: _number,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty ||
                                                          int.parse(value) !=
                                                              randomnumber) {
                                                        return 'Please enter the correct number';
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        if (_key.currentState!
                                                            .validate()) {
                                                          clearappdata();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            content:
                                                                Text("success"),
                                                            backgroundColor:
                                                                Colors.green,
                                                          ));
                                                          _number.clear();
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                            builder: (context) {
                                                              return const SplashScreen();
                                                            },
                                                          ));
                                                        }
                                                      },
                                                      child:
                                                          const Text('Submit')),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .pop();
                                                        _number.clear();
                                                      },
                                                      child:
                                                          const Text('Close'))
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.green),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          );
                        });
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Clear App Data',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('You are about Logout'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) {
                                    return const AccountType();
                                  }), (route) => false);
                                  final _shared =
                                      await SharedPreferences.getInstance();
                                  await _shared.setString(
                                      'LoginState', 'false');
                                },
                                child: const Text(
                                  'yes',
                                  style: TextStyle(color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.green),
                                ))
                          ],
                        );
                      },
                    );
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
