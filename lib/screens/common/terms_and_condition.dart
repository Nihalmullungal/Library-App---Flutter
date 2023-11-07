import 'package:flutter/material.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> terms1 = [
      'Introduction : ',
      'How We Disclose Your Information :',
      ' Security:',
      ' Changes to the Policy:',
      ''
    ];
    List<String> terms2 = [
      '    This Privacy Policy explains how the provider collects, uses, and discloses information about users of the Data that allows users to view the availability of books in a library.',
      '''    The Provider does not share your information with any third parties without your consent. However, the Provider may disclose your information to third-party service providers that assist the Provider in providing the App's services. These service providers are bound by contract to keep your information confidential and to use it only for the purpose of providing the App's services.
''',
      '''    The Provider takes reasonable precautions to protect your information from unauthorized access, use, or disclosure. However, no method of transmission over the internet or electronic storage is 100% secure, and the Provider cannot guarantee the absolute security of your information.
''',
      '''    The Provider may update this Policy from time to time. If the Provider makes any material changes to the Policy, it will notify you by posting the updated Policy on the App.''',
      ''
    ];
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Terms and Condition',
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
