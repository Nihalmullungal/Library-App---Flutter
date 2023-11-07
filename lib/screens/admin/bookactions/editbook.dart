import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';
import 'package:recase/recase.dart';

class EditBook extends StatefulWidget {
  const EditBook({super.key, required this.data});
  final BookModel data;

  @override
  State<EditBook> createState() => _EditBookState();
}

@override
class _EditBookState extends State<EditBook> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _authorcontroller = TextEditingController();
  final TextEditingController _aboutcontroller = TextEditingController();
  bool _availability = true;
  String? _cate;
  bool _typebest = false;
  bool _typefavorite = false;
  String _selectedimg = '';
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    refreshcategory();
    _namecontroller.text = widget.data.name;
    _authorcontroller.text = widget.data.author;
    _aboutcontroller.text = widget.data.about;
    _availability = widget.data.availability == 'true' ? true : false;
    _cate = null;
    _typebest = widget.data.typebest == 'true' ? true : false;
    _typefavorite = widget.data.typefavorite == 'true' ? true : false;
    _selectedimg = widget.data.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleofpage: 'Edit', isBackRequired: true, iseditRequired: false),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  child: Row(
                    children: [
                      const Text(
                        'Name :  ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _namecontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter something';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Type :  ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            'Favorites',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: _typefavorite,
                          onChanged: (value) {
                            setState(() {
                              _typefavorite == true
                                  ? _typefavorite = false
                                  : _typefavorite = true;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            'Best',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: _typebest,
                          onChanged: (value) {
                            setState(() {
                              _typebest == true
                                  ? _typebest = false
                                  : _typebest = true;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Author :  ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _authorcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter something';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Availability :  ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Switch(
                          value: _availability,
                          onChanged: (value) {
                            setState(() {
                              _availability == false
                                  ? _availability = true
                                  : _availability = false;
                            });
                          }),
                      Text(
                        _availability == true ? 'Yes' : 'No',
                        style: TextStyle(
                            fontSize: 22,
                            color: _availability == true
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        'category :  ',
                        style: TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      DropdownButton(
                        value: _cate,
                        items: categoryadded.value.map((e) {
                          return DropdownMenuItem(
                            value: e.categorytype,
                            child: Text(e.categorytype),
                          );
                        }).toList(),
                        onChanged: ((value) {
                          setState(() {
                            _cate = value!;
                          });
                        }),
                        hint: const Text(
                          'category',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        'About :  ',
                        style: TextStyle(fontSize: 22),
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLines: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter something';
                            }
                            return null;
                          },
                          controller: _aboutcontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Preview :  ',
                        style: TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        width: 82,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        height: 150,
                        width: 150,
                        child: _selectedimg != ''
                            ? Image.file(
                                File(_selectedimg),
                                fit: BoxFit.scaleDown,
                              )
                            : const Center(child: Text('No Preview Available')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      _selectedimg = await previewselector();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(1000, 37, 66, 108)),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Upload Photo',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate() &&
                        _selectedimg != '') {
                      final bool added = await tocheckbookedit(
                          await _onaddclicked(widget.data.id));
                      if (!added) {
                        final bookobj = await _onaddclicked(widget.data.id);
                        onbookadd(bookobj);
                        Navigator.of(context).pop();
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                elevation: 5,
                                backgroundColor: Colors.green,
                                content: Text(
                                  'success',
                                  style: TextStyle(color: Colors.white),
                                )));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                elevation: 5,
                                backgroundColor: Colors.red,
                                content: Text(
                                  'This book is already added',
                                  style: TextStyle(color: Colors.white),
                                )));
                      }
                    }
                    // _onaddclicked(widget.data.id);
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(10))),
                    //     elevation: 5,
                    //     backgroundColor: Colors.green,
                    //     content: Text(
                    //       'success',
                    //       style: TextStyle(color: Colors.white),
                    //     )));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(1000, 37, 66, 108)),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<BookModel> _onaddclicked(id) async {
    final String _id = id;
    final String _name = _namecontroller.text.titleCase;
    final String _typef = _typefavorite.toString();
    final String _typeB = _typebest.toString();
    final String _author = _authorcontroller.text.trim().titleCase;
    final String _category = _cate.toString();
    final String _avail = _availability.toString();
    final String _about = _aboutcontroller.text;
    final String _image = _selectedimg;
    final bookobj = BookModel(
        id: _id,
        name: _name,
        typebest: _typeB,
        typefavorite: _typef,
        author: _author,
        availability: _avail,
        category: _category,
        about: _about,
        image: _image);
    return bookobj;
  }

  Future<String> previewselector() async {
    ImagePicker picker = ImagePicker();
    final XFile? _img = await picker.pickImage(source: ImageSource.gallery);
    String _returnimg = _img!.path;
    return _returnimg;
  }
}
