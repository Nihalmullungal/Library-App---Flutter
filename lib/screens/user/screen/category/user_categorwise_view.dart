import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/screens/admin/bookactions/bookpreveiwadmin.dart';
import 'package:library_app/screens/user/screen/category/user_book_preview.dart';
import 'package:library_app/screens/widgets/admin/search%20screen/search_filter.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class UserCategoryWiseView extends StatelessWidget {
  const UserCategoryWiseView({super.key, required this.name});
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
            return Column(
              children: List.generate(
                  val.length,
                  (index) => val.isEmpty
                      ? const Center(
                          child: Text('No Results Found'),
                        )
                      : GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return UserBookPreview(data: val[index]);
                              },
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, right: 20, left: 20),
                            child: SizedBox(
                              width: 130,
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.black,
                                color: Colors.white,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 10,
                                          color:
                                              val[index].availability == 'true'
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 110,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 94, 92, 92),
                                          offset: Offset(1, 3),
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: Image.file(File(val[index].image)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    val[index].name,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        )),
            );
          }),
    );
  }
}
