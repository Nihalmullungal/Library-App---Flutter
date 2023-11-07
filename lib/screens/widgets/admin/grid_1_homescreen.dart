import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/screens/admin/bookactions/bookpreveiwadmin.dart';
import 'package:library_app/screens/admin/viewall%20mainscreen/homescreen_viewall.dart';

class Grid1Home extends StatelessWidget {
  const Grid1Home({super.key});

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
                    bookaddedvn.value.isNotEmpty
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreenViewAll(
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
                          )
                        : const SizedBox(),
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
                                              BookPreviewAdmin(data: data)),
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

class Grid2Home extends StatelessWidget {
  const Grid2Home({super.key});

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
                    bookbestvn.value.isNotEmpty
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreenViewAll(
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
                          )
                        : const SizedBox(),
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
                                              BookPreviewAdmin(data: data)),
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

class Grid3Home extends StatelessWidget {
  const Grid3Home({super.key});

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
                    bookfavoritevn.value.isNotEmpty
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreenViewAll(
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
                          )
                        : const SizedBox(),
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
                                              BookPreviewAdmin(data: data)),
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
