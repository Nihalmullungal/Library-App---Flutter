import 'package:flutter/material.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> terms1 = [
      'Introduction : ',
      'Acceptance of Terms and Conditions:',
      ' Use of the App :',
      ' Contact Us :',
      ''
    ];
    List<String> terms2 = [
      'This is a mobile application that allows users to view the availability of books in a library.',
      ''' By using the App, you agree to be bound by these terms and conditions (the "Terms"). If you do not agree to the Terms, you should not use the App.

''',
      '''   The App is for your personal use only. You may not use the App for any commercial purpose or for any purpose that is unlawful or otherwise prohibited by these Terms.
    You are responsible for ensuring that your use of the App complies with all applicable laws and regulations.
    The App is provided on an "as is" and "as available" basis. The Provider does not make any warranties, express or implied, with respect to the App, including but not limited to any warranties of merchantability, fitness for a particular purpose, or non-infringement.

''',
      '''   If you have any questions about these Terms, please contact us through report a issue.
''',
      ''
    ];
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Privay and Policy',
          isBackRequired: true,
          iseditRequired: false),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      terms1[index],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 25, right: 20),
                child: Text(
                  terms2[index],
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.justify,
                ),
              );
            },
            itemCount: 5),
      )),
    );
  }
}
