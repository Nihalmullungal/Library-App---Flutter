import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key, required this.filtervn, required this.pageno});
  final ValueNotifier<List<BookModel>> filtervn;
  final int pageno;

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 208, 210, 208)),
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Availability',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const Text(
                '_______________',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Radio(
                    value: 0,
                    groupValue: _selectedindex,
                    onChanged: (value) {
                      setState(() {
                        _selectedindex = value!;
                      });
                    }),
                title: const Text('Both'),
              ),
              ListTile(
                leading: Radio(
                    value: 1,
                    groupValue: _selectedindex,
                    onChanged: (value) {
                      setState(() {
                        _selectedindex = value!;
                      });
                    }),
                title: const Text('Yes'),
              ),
              ListTile(
                leading: Radio(
                    value: 2,
                    groupValue: _selectedindex,
                    onChanged: (value) {
                      setState(() {
                        _selectedindex = value!;
                      });
                    }),
                title: const Text('No'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    widget.pageno == 1
                        ? filtersearch(_selectedindex, widget.filtervn)
                        : filterbook(
                            widget.filtervn,
                            _selectedindex,
                          );
                    Navigator.of(context).pop();
                  },
                  child: const Text("Apply"))
            ],
          ),
        ),
      ),
    );
  }
}
