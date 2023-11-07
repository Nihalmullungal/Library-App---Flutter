import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/bookingdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';
import 'package:recase/recase.dart';

class StudentListAdding extends StatefulWidget {
  const StudentListAdding({super.key});

  @override
  State<StudentListAdding> createState() => _StudentListAddingState();
}

class _StudentListAddingState extends State<StudentListAdding> {
  String? _takendate = null;
  TextEditingController _studentname = TextEditingController();
  String? _bokname;
  TextEditingController _studentnumber = TextEditingController();
  DateTime? _selectedtakendate = null;
  DateTime? _selectedreturndate;
  String? _returndate;
  bool _isvisible1 = false;
  bool _isvisible2 = false;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        // color: const Color.fromARGB(255, 91, 91, 91),
        color: const Color.fromARGB(255, 79, 103, 92).withOpacity(0.8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                      child: Text(
                    'Student Add ',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _studentname,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          (value
                              .contains(RegExp(r'[^A-Za-z]+\s[^A-Za-z]+$')))) {
                        if (value!.contains(RegExp(r'[A-Za-z]+\s[A-Za-z]+$'))) {
                          return 'Enter only letters';
                        } else {
                          return 'please enter somthing';
                        }
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Student Name',
                        fillColor: Color.fromARGB(255, 241, 237, 237),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownSearch(
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Book';
                      }
                      return null;
                    },
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Select book',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    items: bookavailablevn.value.map((e) {
                      return e.name;
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _bokname = value;
                      });
                    },
                    selectedItem: _bokname,
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _studentnumber,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 10 ||
                          value.contains(RegExp(r'[^0-9]'))) {
                        if (value!.contains(RegExp(r'[^0-9]'))) {
                          return 'Enter number only';
                        } else if (value.length != 10) {
                          return 'please enter 10 digits';
                        }
                        return 'please enter somthing';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Student Number',
                        fillColor: Color.fromARGB(255, 241, 237, 237),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          ElevatedButton.icon(
                              onPressed: () async {
                                final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
                                setState(() {
                                  _selectedtakendate = date;
                                  _takendate = date.toString().substring(0, 10);
                                });
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white24)),
                              icon: const Icon(Icons.date_range),
                              label: _takendate == null
                                  ? const Text('Taken date')
                                  : Text(_takendate!)),
                          const SizedBox(
                            height: 5,
                          ),
                          Visibility(
                              visible: _isvisible1,
                              child: const Text(
                                'Please select a taken date',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton.icon(
                              onPressed: () async {
                                final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 30)));
                                setState(() {
                                  _selectedreturndate = date;
                                  _returndate = date.toString();
                                });
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white24)),
                              icon: const Icon(Icons.date_range),
                              label: _returndate == null
                                  ? const Text('return date')
                                  : Text(_returndate!.substring(0, 10))),
                          Visibility(
                              visible: _isvisible2,
                              child: const Text(
                                'please select the return date',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate() &&
                            _takendate != null &&
                            _returndate != null) {
                          setState(() {
                            _isvisible1 = false;
                            _isvisible2 = false;
                          });
                          _bookavailupdate(_bokname.toString());
                          _onaddclicked();
                          Navigator.of(context).pop();
                        } else if (_takendate == null && _returndate == null) {
                          setState(() {
                            _isvisible1 = true;
                            _isvisible2 = true;
                          });
                        } else if (_takendate == null && _returndate != null) {
                          setState(() {
                            _isvisible1 = true;
                            _isvisible2 = false;
                          });
                        } else if (_takendate != null && _returndate == null) {
                          setState(() {
                            _isvisible1 = false;
                            _isvisible2 = true;
                          });
                        } else if (_takendate != null && _returndate != null) {
                          setState(() {
                            _isvisible1 = false;
                            _isvisible2 = false;
                          });
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black45)),
                      child: const Text('Add'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onaddclicked() async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final String _stdname = _studentname.text.titleCase;
    final String _bkname = _bokname.toString();
    final String _number = _studentnumber.text;
    final DateTime? _taken = _selectedtakendate;
    final DateTime? _return = _selectedreturndate;
    final String image = await imagesender(_bkname);
    final booking = BookingModal(
        id: id,
        studentname: _stdname,
        bookname: _bkname,
        number: _number,
        takendate: _taken,
        returndate: _return,
        image: image);
    addtostudentlist(booking);
  }

  Future<void> _bookavailupdate(bkname) async {
    final bkdetails = await togetabookdetails(bkname) as BookModel;
    final book = BookModel(
        id: bkdetails.id,
        name: bkname,
        typebest: bkdetails.typebest,
        typefavorite: bkdetails.typefavorite,
        author: bkdetails.author,
        availability: 'false',
        category: bkdetails.category,
        about: bkdetails.about,
        image: bkdetails.image);
    toupdateavail(book);
  }
}
