import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/screens/admin/bookactions/bookpreveiwadmin.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    searchbooks('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    searchbooks('');
    return ValueListenableBuilder(
      valueListenable: searchbooksvn,
      builder: (context, value1, child) {
        return value1.isEmpty
            ? const Center(
                child: Text(
                'No Data',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))
            : ListView.separated(
                itemBuilder: (context, index) {
                  final data = value1[index];
                  bool val = bool.parse(data.availability);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookPreviewAdmin(data: data),
                      ));
                    },
                    child: ListTile(
                        leading: Image.file(File(data.image)),
                        title: Text(data.name),
                        subtitle: Text(data.author),
                        trailing: Switch(
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red,
                            value: val,
                            onChanged: (value) {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      content: Text(
                                          'You are about to change the Availability of a "${data.name}"'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              data.availability =
                                                  value.toString();
                                              toupdateavail(data);
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
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ))
                                      ],
                                    );
                                  });
                            })),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
                itemCount: value1.length);
      },
    );
  }
}
