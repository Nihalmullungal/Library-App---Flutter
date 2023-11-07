import 'package:hive_flutter/adapters.dart';
part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String typebest;

  @HiveField(3)
  final String typefavorite;

  @HiveField(4)
  final String author;

  @HiveField(5)
  String availability;

  @HiveField(6)
  String category;

  @HiveField(7)
  final String about;

  @HiveField(8)
  final String image;

  BookModel(
      {required this.id,
      required this.name,
      required this.typebest,
      required this.typefavorite,
      required this.author,
      required this.availability,
      required this.category,
      required this.about,
      required this.image});
}
