import 'dart:io';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/screens/admin/bookactions/editbook.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class BookPreviewAdmin extends StatefulWidget {
  const BookPreviewAdmin({super.key, required this.data});
  final BookModel data;
  @override
  State<BookPreviewAdmin> createState() => _BookPreviewAdminState();
}

class _BookPreviewAdminState extends State<BookPreviewAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: widget.data.name,
          isBackRequired: true,
          iseditRequired: false),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(1000, 90, 118, 106)),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 216, 250, 239)),
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditBook(
                                        data: widget.data,
                                      )));
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: const Text(
                                        'You are about to delete a book!!!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "No",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            onbookdelete(widget.data.id);
                                            Navigator.of(context).pop();
                                            Navigator.of(ctx).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    elevation: 5,
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                      'Deleted',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )));
                                          },
                                          child: const Text(
                                            'Yes',
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ))
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ]),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  height: 280,
                  width: 200,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(5, 5),
                        blurRadius: 4,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 253, 253),
                  ),
                  child: Image.file(
                    File(widget.data.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Author :',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.data.author,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Availability :',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Switch(
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.red,
                              value: widget.data.availability == 'true'
                                  ? true
                                  : false,
                              onChanged: (value) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text('Are you sure'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                _onswitchclicked(value);
                                                setState(() {
                                                  value = value == true
                                                      ? false
                                                      : true;
                                                });
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                searchbooks('');
                                                refreshbooks();
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
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                        ],
                                      );
                                    });
                              }),
                          Text(
                            widget.data.availability == 'true' ? 'Yes' : 'No',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: widget.data.availability == 'true'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      widget.data.about,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _onswitchclicked(val) async {
    final _id = widget.data.id;
    final _name = widget.data.name;
    final _author = widget.data.author;
    final _typeb = widget.data.typebest;
    final _typef = widget.data.typefavorite;
    final _avail = val.toString();
    final _cat = widget.data.category;
    final _about = widget.data.about;
    final _img = widget.data.image;

    final _bookobj = BookModel(
        id: _id,
        name: _name,
        typebest: _typeb,
        typefavorite: _typef,
        author: _author,
        availability: _avail,
        category: _cat,
        about: _about,
        image: _img);
    onbookadd(_bookobj);
  }
}
