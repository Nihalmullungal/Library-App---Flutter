import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app/models/admin_model/booking_modal.dart';

const BOOKING_DB = 'booking_database';

ValueNotifier<List<BookingModal>> bookinglistvn = ValueNotifier([]);

Future<List<BookingModal>> getallstudents() async {
  final booking = await Hive.openBox<BookingModal>(BOOKING_DB);
  return booking.values.toList();
}

Future<void> addtostudentlist(BookingModal value) async {
  final booking = await Hive.openBox<BookingModal>(BOOKING_DB);
  booking.put(value.id, value);
  refreshstudentlist();
}

Future<void> refreshstudentlist() async {
  final _values = await getallstudents();
  bookinglistvn.value.clear();
  _values.forEach((element) {
    bookinglistvn.value.add(element);
  });
  bookinglistvn.notifyListeners();
}

Future<void> deletestudent(id) async {
  final booking = await Hive.openBox<BookingModal>(BOOKING_DB);
  booking.delete(id);
  refreshstudentlist();
}
