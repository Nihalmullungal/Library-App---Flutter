import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/screens/widgets/admin/search%20screen/search_filter.dart';
import 'package:library_app/screens/widgets/common/search_bar_admin.dart';
import 'package:library_app/screens/widgets/user/searchscreen/usersearchresults.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return SearchFilter(
                  filtervn: searchbooksvn,
                  pageno: 1,
                );
              },
            );
          },
          backgroundColor: const Color.fromARGB(255, 79, 103, 92),
          child: const Icon(Icons.filter_alt)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchBarAdmin(),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Search Results :',
                style: TextStyle(
                    fontSize: 22, color: Colors.grey.withOpacity(0.8)),
              ),
              const SizedBox(
                height: 25,
              ),
              const SingleChildScrollView(
                  child: SizedBox(height: 625, child: UserSearchresult())),
            ],
          ),
        ),
      ),
    );
  }
}
