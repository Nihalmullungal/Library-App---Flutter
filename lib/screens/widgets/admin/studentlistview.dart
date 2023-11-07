import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/bookingdb.dart';
import 'package:library_app/dbfunctions/returnedbookingdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';
import 'package:library_app/models/admin_model/returned_booking_modal.dart';
import 'package:library_app/screens/admin/Student%20list/student_details.dart';
import 'package:library_app/screens/widgets/admin/student_details_edits.dart';
import 'package:library_app/screens/widgets/admin/studentlistadding.dart';
import 'package:recase/recase.dart';

class StudentListview extends StatelessWidget {
  const StudentListview({super.key});

  @override
  Widget build(BuildContext context) {
    refreshstudentlist();
    refreshbooks();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            elevation: 0.0,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.viewInsetsOf(context).bottom),
                child: const SizedBox(height: 450, child: StudentListAdding()),
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 79, 103, 92),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      // const Color.fromARGB(255, 189, 189, 189).withOpacity(0.5),
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
                                fontWeight: FontWeight.w400,
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
                      valueListenable: bookinglistvn,
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
                                          builder: (context) => StudentDetails(
                                                data: data,
                                              )),
                                    );
                                  },
                                  onLongPress: () {
                                    _modifystudent(context, data);
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

  void _modifystudent(ctx, BookingModal value) {
    showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          content: Text(
              'you are about to modify the details of ${value.studentname}'),
          actions: [
            TextButton(
                onPressed: () {
                  showBottomSheet(
                    context: ctx,
                    builder: (context) {
                      return StudentDetailsEdit(
                        data: value,
                      );
                    },
                  );
                  Navigator.of(context).pop();
                },
                child: const Tooltip(
                  message: 'Edit',
                  child: Icon(Icons.edit),
                )),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context1) {
                      return AlertDialog(
                        content: const Text('Are you sure to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                _bookavailupdate2(value.bookname);
                                addtoreturned(value);
                                deletestudent(value.id);
                                Navigator.of(context1).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.red),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context1).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.green),
                              ))
                        ],
                      );
                    });
              },
              child: const Tooltip(
                message: 'Delete',
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _bookavailupdate2(bkname) async {
    final bkdetails = await togetabookdetails(bkname) as BookModel;
    bkdetails.availability = 'true';
    toupdateavail(bkdetails);
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
