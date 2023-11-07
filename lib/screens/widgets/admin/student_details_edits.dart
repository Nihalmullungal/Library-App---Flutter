import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/bookingdb.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';

class StudentDetailsEdit extends StatefulWidget {
  const StudentDetailsEdit({super.key, required this.data});

  final BookingModal data;

  @override
  State<StudentDetailsEdit> createState() => _StudentDetailsEditState();
}

class _StudentDetailsEditState extends State<StudentDetailsEdit> {
  final _key = GlobalKey<FormState>();
  TextEditingController _namec = TextEditingController();
  TextEditingController _numberc = TextEditingController();
  DateTime? _takendate;
  DateTime? _returndate;
  String? _bookname;

  @override
  void initState() {
    _namec.text = widget.data.studentname;
    _bookname = widget.data.bookname;
    _numberc.text = widget.data.number;
    _takendate = widget.data.takendate;
    _returndate = widget.data.returndate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Container(
            height: 400,
            color: const Color.fromARGB(255, 79, 103, 92),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _namec,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              (value.contains(
                                  RegExp(r'[^A-Za-z]+\s[^A-Za-z]+$')))) {
                            if (value!
                                .contains(RegExp(r'[A-Za-z]+\s[A-Za-z]+$'))) {
                              return 'Enter only letters';
                            } else {
                              return 'please enter somthing';
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Student Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownSearch(
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
                            _bookname = value;
                          });
                        },
                        selectedItem: _bookname,
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _numberc,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.contains(RegExp(r'[^0-9]'))) {
                            if (value!.contains(RegExp(r'[^0-9]'))) {
                              return 'Enter number only';
                            }
                            return 'please enter somthing';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Student Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                              setState(() {
                                _takendate = date;
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                            label: Text(_takendate.toString().substring(0, 10)),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 30)));
                              setState(() {
                                _returndate = date;
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                            label:
                                Text(_returndate.toString().substring(0, 10)),
                          ),
                        ],
                      ),
                      const SizedBox(),
                      ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _onupdateclicked(widget.data.id);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Update')),
                    ],
                  ),
                ),
              ],
            )));
  }

  void _onupdateclicked(idp) async {
    final id = idp;
    final String _stdname = _namec.text;
    final String _bkname = _bookname.toString();
    final String _number = _numberc.text;
    final DateTime? _taken = _takendate;
    final DateTime? _return = _returndate;
    final image = await imagesender(_bkname);
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
}
