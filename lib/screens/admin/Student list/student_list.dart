import 'package:flutter/material.dart';
import 'package:library_app/screens/admin/Student%20list/returned_student_list.dart';
import 'package:library_app/screens/widgets/admin/studentlistview.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Student List',
          isBackRequired: true,
          iseditRequired: true,
          leadingicon: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const ReturnedStudentList();
                }));
              },
              icon: const Icon(Icons.task))),
      body: const StudentListview(),
    );
  }
}
