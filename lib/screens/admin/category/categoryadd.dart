import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/models/admin_model/category_model.dart';
import 'package:recase/recase.dart';

class CategoryAdd extends StatefulWidget {
  const CategoryAdd({super.key});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  TextEditingController categorytextfield = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 190, 190, 190)),
          child: ListView(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Row(
                              children: [
                                Text(
                                  'close',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Icon(
                                  Icons.close,
                                  size: 15,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: categorytextfield,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            (!RegExp(r'^\S+(?!\d+$)').hasMatch(value)) ||
                            value.contains(
                                RegExp(r'^[a-zA-Z]+\s [^a-zA-Z]+$'))) {
                          return "please enter Category Name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Category',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _onaddclicked();
                        categorytextfield.clear();
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                elevation: 5,
                                backgroundColor: Colors.green,
                                content: Text(
                                  'success',
                                  style: TextStyle(color: Colors.white),
                                )));
                      }
                    },
                    child: const Text('Add'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onaddclicked() async {
    final String _category = categorytextfield.text.trim().titleCase;
    final String _id = DateTime.now().millisecondsSinceEpoch.toString();
    final CategoryModel categoryobj =
        await CategoryModel(categorytype: _category, categoryid: _id);
    oncategoryadd(categoryobj);
  }
}
