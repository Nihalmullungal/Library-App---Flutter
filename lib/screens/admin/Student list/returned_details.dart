import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/bookingdb.dart';
import 'package:library_app/dbfunctions/returnedbookingdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';
import 'package:library_app/models/admin_model/returned_booking_modal.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class Returneddetails extends StatelessWidget {
  const Returneddetails({super.key, required this.data});
  final ReturnedBookingModal data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: data.studentname,
          isBackRequired: true,
          iseditRequired: true,
          leadingicon: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: const Text('Are you sure to restore?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                torestore(data);
                                _bookavailupdate2(data.bookname);
                                deletereturned(data);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
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
              icon: const Icon(Icons.restore))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, bottom: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(5, 5),
                      blurRadius: 4,
                    )
                  ],
                  color: const Color.fromARGB(255, 79, 103, 92),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            data.bookname,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.file(File(data.image)),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Student Name : ',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Roboto-Black'),
                              ),
                              Text(
                                data.studentname,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Phone : ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data.number,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Taken date:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.takendate
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'return date:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.returndate
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> torestore(ReturnedBookingModal data) async {
    final bkdetails = BookingModal(
        id: data.id,
        image: data.image,
        studentname: data.studentname,
        bookname: data.bookname,
        number: data.number,
        takendate: data.takendate,
        returndate: data.returndate);
    await addtostudentlist(bkdetails);
  }

  Future<void> _bookavailupdate2(bkname) async {
    final bkdetails = await togetabookdetails(bkname) as BookModel;
    bkdetails.availability = 'false';
    toupdateavail(bkdetails);
  }
}
