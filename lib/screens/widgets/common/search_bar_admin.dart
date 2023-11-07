import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:recase/recase.dart';

class SearchBarAdmin extends StatefulWidget {
  const SearchBarAdmin({super.key});

  @override
  State<SearchBarAdmin> createState() => _SearchBarAdminState();
}

class _SearchBarAdminState extends State<SearchBarAdmin> {
  TextEditingController _searchcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SearchAnchor(
        key: _formkey,
        builder: (context, controller) {
          return SearchBar(
            controller: _searchcontroller,
            hintText: 'Search',
            onChanged: (value) {
              searchbooks(value.toLowerCase());
            },
            elevation: const MaterialStatePropertyAll(9),
            shadowColor: const MaterialStatePropertyAll(Colors.black),
            trailing: [
              IconButton(
                  onPressed: () {
                    _searchcontroller.clear();
                    searchbooks(_searchcontroller.text);
                  },
                  icon: const Icon(Icons.clear))
            ],
          );
        },
        suggestionsBuilder: (context, controller) {
          return List<ListTile>.generate(searchbooksvn.value.length, (index) {
            String _name = 'item$index';
            return ListTile(
              title: Text(_name),
              onTap: () {
                setState(() {
                  controller.closeView(_name);
                });
              },
            );
          });
        },
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(20),
    //   child: Form(
    //     key: _formkey,
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         TextFormField(
    //           validator: (value) {
    //             if (value == null || value.isEmpty) {
    //               return "please enter something";
    //             }
    //             return null;
    //           },
    //           onChanged: (value) {
    //             searchbooks(value);
    //           },
    //           controller: _searchcontroller,
    //           decoration: InputDecoration(
    //             hintText: 'Search Something',
    //             fillColor: const Color.fromRGBO(217, 217, 217, 0.5),
    //             filled: true,
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 50,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             ElevatedButton(
    //               onPressed: () {
    //                 if (_formkey.currentState!.validate()) {
    //                   searchbooks(_searchcontroller.text);
    //                   setState(() {});
    //                 }
    //               },
    //               style: ElevatedButton.styleFrom(
    //                   backgroundColor: const Color.fromARGB(232, 87, 87, 87)),
    //               child: const Text('Search'),
    //             ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 _searchcontroller.clear();
    //                 searchbooks(_searchcontroller.text);
    //               },
    //               style: ElevatedButton.styleFrom(
    //                   backgroundColor: const Color.fromARGB(232, 87, 87, 87)),
    //               child: const Text('clear  X'),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
