import 'package:flutter/material.dart';
import 'package:library_app/accounttype.dart';

import 'package:library_app/screens/common/about_us.dart';
import 'package:library_app/screens/common/report_issue.dart';
import 'package:library_app/screens/user/login/userlogin.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Hi $usernametyped,',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
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
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Login as Admin ?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                final _shared =
                                    await SharedPreferences.getInstance();
                                _shared.setBool('LoginStateuser', false);
                                _shared.setString('username', '');

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                  builder: (ctx) {
                                    return const AccountType();
                                  },
                                ), (route) => false);
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
                    },
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text(
                      'Login As Admin',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
