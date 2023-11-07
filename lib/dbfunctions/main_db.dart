import 'package:hive_flutter/adapters.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/bookingdb.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/dbfunctions/returnedbookingdb.dart';
import 'package:library_app/models/admin_model/book_model.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';
import 'package:library_app/models/admin_model/category_model.dart';
import 'package:library_app/models/admin_model/returned_booking_modal.dart';

Future<void> initDB() async {
  Hive.initFlutter();
  if (!Hive.isAdapterRegistered(BookModelAdapter().typeId)) {
    Hive.registerAdapter(BookModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(BookingModalAdapter().typeId)) {
    Hive.registerAdapter(BookingModalAdapter());
  }
  if (!Hive.isAdapterRegistered(ReturnedBookingModalAdapter().typeId)) {
    Hive.registerAdapter(ReturnedBookingModalAdapter());
  }
}

Future<void> clearappdata() async {
  final bookdb = await Hive.openBox<BookModel>(BOOK_DB);
  final bookingdb = await Hive.openBox<BookingModal>(BOOKING_DB);
  final categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB);
  final returned = await Hive.openBox<ReturnedBookingModal>(RETURNED_DB);
  await bookdb.clear();
  await bookingdb.clear();
  await categorydb.clear();
  await returned.clear();
  refreshbooks();
  refreshcategory();
  refreshreturned();
  refreshstudentlist();
}
