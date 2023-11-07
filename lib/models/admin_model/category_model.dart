import 'package:hive_flutter/adapters.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(1)
  final String categorytype;

  @HiveField(0)
  final String categoryid;

  CategoryModel({required this.categorytype, required this.categoryid});
}
