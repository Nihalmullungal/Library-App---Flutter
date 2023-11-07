import 'package:flutter/material.dart';
import 'package:library_app/screens/common/Privacy_and_policy.dart';
import 'package:library_app/screens/common/terms_and_condition.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceheight =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;
    // var devicefontsize=MediaQuery.of(context).>=;
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'About Us', isBackRequired: true, iseditRequired: false),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: deviceheight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'About Us',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Center(
                  child: Image.asset(
                    'asset/Book preview/Logo.png',
                    width: 380,
                    height: 380,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                      'Version 1.0.0',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsAndCondition()));
                              },
                              child: const Text(
                                'Terms and Condition',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyAndPolicy()));
                              },
                              child: const Text(
                                'Privacy and Policy',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
