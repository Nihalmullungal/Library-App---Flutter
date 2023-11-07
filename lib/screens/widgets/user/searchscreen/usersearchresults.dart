import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/screens/user/screen/category/user_book_preview.dart';

class UserSearchresult extends StatefulWidget {
  const UserSearchresult({super.key});

  @override
  State<UserSearchresult> createState() => _UserSearchresultState();
}

class _UserSearchresultState extends State<UserSearchresult> {
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

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserBookPreview(data: data),
                      ));
                    },
                    child: ListTile(
                      leading: Image.file(File(data.image)),
                      title: Text(data.name),
                      subtitle: Text(data.author),
                      trailing: Icon(
                        Icons.circle,
                        color: data.availability == 'true'
                            ? Colors.green
                            : Colors.red,
                        size: 15,
                      ),
                    ),
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
