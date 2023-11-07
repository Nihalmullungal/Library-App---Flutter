import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/screens/admin/bookactions/bookpreveiwadmin.dart';
import 'package:library_app/screens/widgets/admin/search%20screen/search_filter.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class CategoryViewAdmin extends StatelessWidget {
  const CategoryViewAdmin({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    categroyview(name);
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: name, isBackRequired: true, iseditRequired: false),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SearchFilter(filtervn: categorywisevn, pageno: 2);
            },
          );
        },
        child: const Icon(Icons.filter_alt),
      ),
      body: ValueListenableBuilder(
          valueListenable: categorywisevn,
          builder: (context, val, _) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 1.0, crossAxisCount: 3),
              itemBuilder: (context, index) {
                final data = val[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BookPreviewAdmin(data: data)),
                    );
                  },
                  child: SizedBox(
                    height: 290,
                    width: 150,
                    child: Column(
                      children: [
                        Row(
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
                        Container(
                            height: 114,
                            width: 85,
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(5, 5),
                                blurRadius: 4,
                              )
                            ]),
                            child: Image.file(
                              File(
                                data.image,
                              ),
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          data.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: categorywisevn.value.length,
            );
          }),
    );
  }
}
