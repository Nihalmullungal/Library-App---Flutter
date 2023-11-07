import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app/models/admin_model/returned_booking_modal.dart';

const RETURNED_DB = 'returned db';

ValueNotifier<List<ReturnedBookingModal>> returnedbookvn = ValueNotifier([]);

Future<List<ReturnedBookingModal>> getallreturned() async {
  final returned = await Hive.openBox<ReturnedBookingModal>(RETURNED_DB);
  return returned.values.toList();
}

Future<void> refreshreturned() async {
  final returned = await getallreturned();
  returnedbookvn.value.clear();
  returned.forEach((element) {
    returnedbookvn.value.add(element);
  });
  returnedbookvn.notifyListeners();
}

Future<void> addreturned(ReturnedBookingModal value) async {
  final returned = await Hive.openBox<ReturnedBookingModal>(RETURNED_DB);
  returned.put(value.id, value);
  refreshreturned();
}

Future<void> deletereturned(ReturnedBookingModal val) async {
  final booking = await Hive.openBox<ReturnedBookingModal>(RETURNED_DB);
  booking.delete(val.id);
  refreshreturned();
}
