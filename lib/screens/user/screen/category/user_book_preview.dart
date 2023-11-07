import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class UserBookPreview extends StatefulWidget {
  const UserBookPreview({super.key, required this.data});
  final BookModel data;

  @override
  State<UserBookPreview> createState() => _UserBookPreviewState();
}

class _UserBookPreviewState extends State<UserBookPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: widget.data.name,
          isBackRequired: true,
          iseditRequired: false),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(1000, 90, 118, 106)),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  height: 280,
                  width: 200,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(5, 5),
                        blurRadius: 4,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 253, 253),
                  ),
                  child: Image.file(
                    File(widget.data.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Author :',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.data.author,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Availability :',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.data.availability == 'true' ? 'Yes' : 'No',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: widget.data.availability == 'true'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      widget.data.about,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
