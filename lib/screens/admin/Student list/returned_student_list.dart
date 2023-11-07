import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/bookingdb.dart';
import 'package:library_app/dbfunctions/returnedbookingdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';
import 'package:library_app/models/admin_model/returned_booking_modal.dart';
import 'package:library_app/screens/admin/Student%20list/returned_details.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class ReturnedStudentList extends StatelessWidget {
  const ReturnedStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    refreshreturned();
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Returned books',
          isBackRequired: true,
          iseditRequired: false),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 79, 103, 92).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Table(
                      children: const [
                        TableRow(children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 25,
                                fontFamily: 'Roboto-Black'),
                          ),
                          Text(
                            'Book Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                fontFamily: 'Roboto-Black'),
                          ),
                          Text(
                            'Return Date',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                fontFamily: 'Roboto-Black'),
                          )
                        ])
                      ],
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: returnedbookvn,
                      builder: (context, value, child) {
                        return value.isEmpty
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No Data',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            : Column(
                                children: List.generate(value.length, (index) {
                                final data = value[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Returneddetails(
                                                data: data,
                                              )),
                                    );
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            content: const Text(
                                                'Are you sure to restore?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    torestoredetails(data);
                                                    _bookavailupdate2(
                                                        data.bookname);
                                                    deletereturned(data);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Table(
                                          children: [
                                            TableRow(children: [
                                              Text(
                                                data.studentname,
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                data.bookname,
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                data.returndate
                                                    .toString()
                                                    .substring(0, 10),
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ])
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> torestoredetails(ReturnedBookingModal data) async {
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
