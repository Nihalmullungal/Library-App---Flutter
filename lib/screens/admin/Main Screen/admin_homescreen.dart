import 'package:flutter/material.dart';

import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/screens/admin/bookactions/add_screen.dart';
import 'package:library_app/screens/admin/category/admin_category.dart';
import 'package:library_app/screens/admin/Student%20list/student_list.dart';
import 'package:library_app/screens/widgets/admin/grid_1_homescreen.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackRequired: false,
        iseditRequired: true,
        titleofpage: 'Welcome',
        leadingicon: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StudentList()),
              );
            },
            icon: const Icon(Icons.list_alt_rounded)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categoryadded.value.isEmpty
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text('No Category Found'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('close')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return const AdminCategory();
                                },
                              ));
                            },
                            child: const Text('Add')),
                      ],
                    );
                  },
                )
              : Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddScreen()),
                );
        },
        backgroundColor:
            // const Color.fromARGB(255, 90, 118, 106).withOpacity(0.5),
            const Color.fromARGB(255, 79, 103, 92),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(height: 280, child: Grid2Home()),
              SizedBox(height: 280, child: Grid1Home()),
              SizedBox(height: 280, child: Grid3Home()),
            ],
          ),
        ),
      ),
    );
  }
}
