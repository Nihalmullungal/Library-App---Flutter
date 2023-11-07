import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/screens/admin/bookactions/bookpreveiwadmin.dart';
import 'package:library_app/screens/user/screen/category/user_book_preview.dart';
import 'package:library_app/screens/widgets/admin/search%20screen/search_filter.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class UserHomeViewAll extends StatelessWidget {
  const UserHomeViewAll(
      {super.key, required this.toviewall, required this.pagetitle});
  final ValueNotifier<List<BookModel>> toviewall;
  final String pagetitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            titleofpage: pagetitle,
            isBackRequired: true,
            iseditRequired: false),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 400,
                    child: ListView(children: [
                      SearchFilter(
                        filtervn: toviewall,
                        pageno: 2,
                      )
                    ]),
                  );
                });
          },
          child: const Icon(Icons.filter_alt),
        ),
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: toviewall,
          builder: (context, value, child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                final data = value[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserBookPreview(data: data),
                    ));
                  },
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.circle,
                                color: data.availability == 'true'
                                    ? Colors.green
                                    : Colors.red,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 60,
                          decoration: const BoxDecoration(
                              boxShadow: [BoxShadow(offset: Offset(2, 2))]),
                          child: Image.file(File(data.image)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          data.name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: value.length,
            );
          },
        )));
  }
}
