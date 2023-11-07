import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/models/admin_model/category_model.dart';

const CATEGORY_DB = 'category_database';
ValueNotifier<List<CategoryModel>> categoryadded = ValueNotifier([]);

Future<void> oncategoryadd(CategoryModel value) async {
  final categorybox = await Hive.openBox<CategoryModel>(CATEGORY_DB);
  await categorybox.put(value.categoryid, value);
  refreshcategory();
}

Future<List<CategoryModel>> getallcategorydb() async {
  final categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB);
  return categorydb.values.toList();
}

Future<void> refreshcategory() async {
  final _value = await getallcategorydb();
  categoryadded.value.clear();
  _value.forEach((element) {
    categoryadded.value.add(element);
  });

  categoryadded.notifyListeners();
}

Future<void> deletecategory(id) async {
  final categorybox = await Hive.openBox<CategoryModel>(CATEGORY_DB);
  await categorybox.delete(id);
  refreshcategory();
}

Future<int> tocheckcategorycontentcount(String name) async {
  final books = await getallbooks();
  int count = 0;
  await Future.forEach(books, (element) {
    if (element.category == name) {
      count++;
    }
  });
  return count;
}
