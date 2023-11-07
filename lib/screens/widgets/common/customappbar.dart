import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      this.leadingicon,
      this.backicon,
      required this.titleofpage,
      required this.isBackRequired,
      required this.iseditRequired});

  IconButton? leadingicon;
  IconButton? backicon;
  bool isBackRequired;
  bool iseditRequired;
  String titleofpage;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: MediaQuery.of(context).orientation ==
                  Orientation.portrait
              ? const BorderRadius.vertical(bottom: Radius.elliptical(460, 150))
              : const BorderRadius.vertical(bottom: Radius.elliptical(470, 80)),
          color: const Color.fromARGB(255, 79, 103, 92),
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 15),
                    isBackRequired == true
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 217, 217, 217),
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: backicon ??
                                    IconButton(
                                      icon:
                                          const Icon(Icons.arrow_back_ios_new),
                                      onPressed: () {
                                        refreshbooks();
                                        Navigator.of(context).pop();
                                      },
                                    )),
                          )
                        : const SizedBox(
                            width: 50,
                            height: 50,
                          ),
                  ],
                ),
                Text(
                  titleofpage,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    iseditRequired == true
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 217, 217, 217),
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(child: leadingicon),
                          )
                        : const SizedBox(
                            width: 50,
                            height: 50,
                          ),
                    const SizedBox(width: 15),
                  ],
                )
              ],
            )
          ],
        )));
  }

  @override
  Size get preferredSize => const Size(150, 200);
}
