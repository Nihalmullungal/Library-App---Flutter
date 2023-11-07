import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/bookingdb.dart';
import 'package:library_app/dbfunctions/returnedbookingdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';
import 'package:library_app/models/admin_model/returned_booking_modal.dart';
import 'package:library_app/screens/widgets/admin/student_details_edits.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';
import 'package:recase/recase.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key, required this.data});

  final BookingModal data;

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
              builder: (context) {
                return AlertDialog(
                  content: const Text('you are about to delete a record!!!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _bookavailupdate2(data.bookname);
                        addtoreturned(data);
                        deletestudent(data.id);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (ctx) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: StudentDetailsEdit(data: data),
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 79, 103, 92),
        child: const Icon(
          Icons.edit,
        ),
      ),
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
                  // color: const Color.fromARGB(255, 249, 233, 233),
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

  Future<void> _bookavailupdate2(bkname) async {
    final bkdetails = await togetabookdetails(bkname) as BookModel;
    final book = BookModel(
        id: bkdetails.id,
        name: bkname,
        typebest: bkdetails.typebest,
        typefavorite: bkdetails.typefavorite,
        author: bkdetails.author,
        availability: 'true',
        category: bkdetails.category,
        about: bkdetails.about,
        image: bkdetails.image);
    toupdateavail(book);
  }

  Future<void> addtoreturned(BookingModal val) async {
    final id = val.id;
    final image = val.image;
    final studentname = val.studentname;
    final bookname = val.bookname;
    final number = val.number;
    final takendate = val.takendate;
    final returndate = val.returndate;
    final bookingdetails = ReturnedBookingModal(
        id: id,
        image: image,
        studentname: studentname.titleCase,
        bookname: bookname,
        number: number,
        takendate: takendate,
        returndate: returndate);
    await addreturned(bookingdetails);
  }
}
