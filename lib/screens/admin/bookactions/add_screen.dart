import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/screens/widgets/admin/add_screen_widget.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    refreshcategory();
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Add', isBackRequired: true, iseditRequired: false),
      body: const AddscreenWidget(),
    );
  }
}
