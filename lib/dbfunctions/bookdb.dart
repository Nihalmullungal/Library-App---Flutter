import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/models/admin_model/book_model.dart';

const BOOK_DB = 'book_database';
ValueNotifier<List<BookModel>> bookaddedvn = ValueNotifier([]);
ValueNotifier<List<BookModel>> bookbestvn = ValueNotifier([]);
ValueNotifier<List<BookModel>> bookfavoritevn = ValueNotifier([]);
ValueNotifier<List<BookModel>> bookavailablevn = ValueNotifier([]);
ValueNotifier<List<BookModel>> categorywisevn = ValueNotifier([]);
ValueNotifier<List<BookModel>> searchbooksvn = ValueNotifier([]);

Future<void> onbookadd(BookModel value) async {
  final bookdb = await Hive.openBox<BookModel>(BOOK_DB);
  bookdb.put(value.id, value);
}

Future<List<BookModel>> getallbooks() async {
  final bookdb = await Hive.openBox<BookModel>(BOOK_DB);
  return bookdb.values.toList();
}

Future<void> refreshbooks() async {
  final _value = await getallbooks();
  bookaddedvn.value.clear();
  bookbestvn.value.clear();
  bookfavoritevn.value.clear();
  bookavailablevn.value.clear();
  _value.forEach((ele) {
    bookaddedvn.value.add(ele);
    if (ele.typebest == 'true') {
      bookbestvn.value.add(ele);
    }
    if (ele.typefavorite == 'true') {
      bookfavoritevn.value.add(ele);
    }
    if (ele.availability == 'true') {
      bookavailablevn.value.add(ele);
    }
  });
  bookaddedvn.notifyListeners();
  bookbestvn.notifyListeners();
  bookfavoritevn.notifyListeners();
  bookavailablevn.notifyListeners();
  searchbooks('');
  refreshcategory();
}

Future<void> onbookdelete(id) async {
  final bookdb = await Hive.openBox<BookModel>(BOOK_DB);
  bookdb.delete(id);
  refreshbooks();
}

Future<void> categroyview(name) async {
  final _value = await getallbooks();
  categorywisevn.value.clear();
  _value.forEach((element) {
    if (element.category == name) {
      categorywisevn.value.add(element);
    }
  });
  categorywisevn.notifyListeners();
}

Future<void> searchbooks(String name) async {
  final books = await getallbooks();
  searchbooksvn.value.clear();
  books.forEach((ele) {
    if (ele.name.toLowerCase().contains(name)) {
      searchbooksvn.value.add(ele);
    }
    searchbooksvn.notifyListeners();
  });
}

Future<String> imagesender(String name) async {
  String? image;
  final books = await getallbooks();
  books.forEach((element) {
    if (element.name == name) {
      image = element.image;
    }
  });
  return image.toString();
}

List<BookModel> searchresults = [];
Future<void> filtersearch(int val, ValueNotifier<List<BookModel>> vn) async {
  int count = 0;
  if (vn.value.isEmpty) {
  } else {
    vn.value.forEach((element) {
      if (searchresults.contains(element)) {
        count++;
      }
    });
    if (count != vn.value.length) {
      searchresults = [];
      searchresults.addAll(vn.value);
    }
  }
  vn.value.clear();

  await Future.forEach(searchresults, (element) {
    if (val == 0) {
      vn.value.add(element);
    } else if (val == 1) {
      if (element.availability == 'true') {
        vn.value.add(element);
      }
    } else if (val == 2) {
      if (element.availability == 'false') {
        vn.value.add(element);
      }
    }
  });
  // if (vn.value.isEmpty) {
  //   filtersearch(val, vn);
  // }
  vn.notifyListeners();

  // final books = await getallbooks();
  // final searchfilter = searchbooksvn;
  // searchbooksvn.value.clear();
  // searchbooksvn.value.forEach((element) {
  //   if (val == 1) {
  //     if (element.availability == 'true') {
  //       searchbooksvn.value.add(element);
  //     }
  //   } else if (val == 2) {
  //     if (element.availability == 'false') {
  //       searchbooksvn.value.add(element);
  //     }
  //   }
  // });
}

Future<void> toupdateavail(BookModel value) async {
  final bookdb = await Hive.openBox<BookModel>(BOOK_DB);
  bookdb.put(value.id, value);
  refreshbooks();
}

Future<BookModel?> togetabookdetails(name) async {
  final books = await getallbooks();
  BookModel? book;
  books.forEach((element) {
    if (element.name == name) {
      book = element;
    }
  });
  return book;
}

List<BookModel> filterbk = [];
Future<void> filterbook(ValueNotifier<List<BookModel>> vn, int val) async {
  int count = 0;
  if (vn.value.isEmpty) {
  } else {
    vn.value.forEach((element) {
      if (filterbk.contains(element)) {
        count++;
      }
    });
    if (count != vn.value.length) {
      filterbk = [];
      filterbk.addAll(vn.value);
    }
  }
  vn.value.clear();
  await Future.forEach(filterbk, (element) {
    if (val == 0) {
      vn.value.add(element);
      filterbk = [];
    } else if (val == 1) {
      if (element.availability == 'true') {
        vn.value.add(element);
      }
    } else if (val == 2) {
      if (element.availability == 'false') {
        vn.value.add(element);
      }
    }
  });
  vn.notifyListeners();
}

Future<void> toupdatecategory(String old, String newname) async {
  final books = await getallbooks();
  await Future.forEach(books, (element) {
    if (element.category == old) {
      final BookModel obj = element;
      obj.category = newname;
      onbookadd(obj);
    }
  });
}

Future<bool> tocheckbookadd(String name, String author) async {
  final books = await getallbooks();
  int count = 0;
  await Future.forEach(books, (element) {
    if (element.author == author && element.name == name) {
      count++;
    }
  });
  return count == 0 ? false : true;
}

Future<bool> tocheckbookedit(BookModel book) async {
  final books = await getallbooks();
  int count = 0;
  await Future.forEach(books, (element) {
    if (element.author == book.author &&
        element.name == book.name &&
        element.about == book.about &&
        element.availability == book.availability &&
        element.category == book.category &&
        element.id == book.id &&
        element.image == book.image &&
        element.typebest == book.typebest &&
        element.typefavorite == book.typefavorite) {
      count++;
    }
  });
  return count == 0 ? false : true;
}
