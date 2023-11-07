import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/screens/user/screen/category/user_book_preview.dart';
import 'package:library_app/screens/widgets/user/user_homescreen/user_home_screen_view_all.dart';

class UserGrid1Home extends StatelessWidget {
  const UserGrid1Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New Arrivals',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    bookaddedvn.value.isEmpty
                        ? Container()
                        : TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return UserHomeViewAll(
                                    toviewall: bookaddedvn,
                                    pagetitle: 'New Arrivals',
                                  );
                                },
                              ));
                            },
                            child: const Text(
                              'ViewAll>>>',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ValueListenableBuilder(
                  valueListenable: bookaddedvn,
                  builder: (BuildContext context, List<BookModel> newList, _) {
                    return newList.isEmpty
                        ? const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No Book Preview',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              newList.length,
                              (index) {
                                final data = newList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserBookPreview(data: data)),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 190,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                            decoration:
                                                const BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(5, 5),
                                                blurRadius: 4,
                                              )
                                            ]),
                                            height: 140,
                                            width: 100,
                                            child: Image.file(
                                              File(data.image),
                                              fit: BoxFit.fill,
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          data.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserGrid2Home extends StatelessWidget {
  const UserGrid2Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Best 20 Books',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    bookbestvn.value.isEmpty
                        ? Container()
                        : TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return UserHomeViewAll(
                                    toviewall: bookbestvn,
                                    pagetitle: 'Best Book',
                                  );
                                },
                              ));
                            },
                            child: const Text(
                              'ViewAll>>>',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ValueListenableBuilder(
                  valueListenable: bookbestvn,
                  builder: (BuildContext context, List<BookModel> newList, _) {
                    return newList.isEmpty
                        ? const Row(
                            children: [
                              Text(
                                'No Book is select as "Best"',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              newList.length,
                              (index) {
                                final data = newList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserBookPreview(data: data)),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 190,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                            height: 140,
                                            width: 100,
                                            decoration:
                                                const BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(5, 5),
                                                blurRadius: 4,
                                              )
                                            ]),
                                            child: Image.file(
                                              File(data.image),
                                              fit: BoxFit.cover,
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          data.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserGrid3Home extends StatelessWidget {
  const UserGrid3Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Most Favourite',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    bookfavoritevn.value.isEmpty
                        ? Container()
                        : TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return UserHomeViewAll(
                                    toviewall: bookfavoritevn,
                                    pagetitle: 'Favorite Books',
                                  );
                                },
                              ));
                            },
                            child: const Text(
                              'ViewAll>>>',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ValueListenableBuilder(
                  valueListenable: bookfavoritevn,
                  builder: (BuildContext context, List<BookModel> newList, _) {
                    return newList.isEmpty
                        ? const Column(
                            children: [
                              Text(
                                'No Book is selected as "Favourite"',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        : Row(
                            children: List.generate(
                              newList.length,
                              (index) {
                                final data = newList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserBookPreview(data: data)),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 190,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                            height: 140,
                                            width: 100,
                                            decoration:
                                                const BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(5, 5),
                                                blurRadius: 4,
                                              )
                                            ]),
                                            child: Image.file(
                                              File(data.image),
                                              fit: BoxFit.cover,
                                            )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          data.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
