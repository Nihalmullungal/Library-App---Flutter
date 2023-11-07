import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/models/admin_model/category_model.dart';
import 'package:recase/recase.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({super.key, required this.data});

  final CategoryModel data;
  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  TextEditingController categorytextfieldedit = TextEditingController();
  final _key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    categorytextfieldedit.text = widget.data.categorytype;
    return Form(
      key: _key1,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 190, 190, 190)),
          child: Column(
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
                  controller: categorytextfieldedit,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        (!RegExp(r'^\S+(?!\d+$)').hasMatch(value))) {
                      return 'Please enter a Category Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Category',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_key1.currentState!.validate()) {
                    _onupdateclicked(widget.data);
                    categorytextfieldedit.clear();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        elevation: 5,
                        backgroundColor: Colors.green,
                        content: Text(
                          'Updated',
                          style: TextStyle(color: Colors.white),
                        )));
                  }
                },
                child: const Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onupdateclicked(CategoryModel cate) async {
    final String _category = categorytextfieldedit.text.trim().titleCase;
    final String _id = cate.categoryid;
    final CategoryModel categoryobj =
        await CategoryModel(categorytype: _category, categoryid: _id);
    toupdatecategory(cate.categorytype, _category);
    oncategoryadd(categoryobj);
  }
}
