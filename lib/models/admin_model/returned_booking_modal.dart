import 'package:hive_flutter/adapters.dart';
part 'returned_booking_modal.g.dart';

@HiveType(typeId: 3)
class ReturnedBookingModal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String studentname;

  @HiveField(2)
  final String bookname;

  @HiveField(3)
  final String number;

  @HiveField(4)
  final DateTime? takendate;

  @HiveField(5)
  final DateTime? returndate;

  @HiveField(6)
  final String image;

  ReturnedBookingModal(
      {required this.id,
      required this.image,
      required this.studentname,
      required this.bookname,
      required this.number,
      required this.takendate,
      required this.returndate});
}
