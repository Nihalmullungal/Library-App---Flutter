import 'package:flutter/material.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportIssue extends StatelessWidget {
  const ReportIssue({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    TextEditingController messageediting = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Report Issue',
          isBackRequired: true,
          iseditRequired: false),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  // TextFormField(
                  //   keyboardType: TextInputType.emailAddress,
                  //   decoration: InputDecoration(
                  //     labelText: 'Email',
                  //     fillColor: const Color.fromARGB(1000, 217, 217, 217),
                  //     filled: true,
                  //     hintText: 'Enter your Email',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //       borderSide: const BorderSide(
                  //         width: 0,
                  //         style: BorderStyle.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  Form(
                    key: _key,
                    child: TextFormField(
                      controller: messageediting,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please neter something';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Message',
                        fillColor: const Color.fromARGB(1000, 217, 217, 217),
                        filled: true,
                        hintText: 'Write the Issue',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'NB:This will redirect to email app ',
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            await onemailluancher(messageediting.text);
                            messageediting.clear();
                          }
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 79, 103, 92),
                        )),
                        child: const Text('Submit'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onemailluancher(message) async {
    String email = Uri.encodeComponent("mnihalm1@gmail.com");
    String subject = Uri.encodeComponent(message);
    print('hi $message');
    Uri mail = Uri.parse("mailto:$email?subject=$subject");
    if (await launchUrl(mail)) {
      print('email app');
    } else {
      print('not opened');
    }
  }
}
