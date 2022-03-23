import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part 'database.g.dart';

@HiveType(typeId: 1)
class Categories extends HiveObject {
  @HiveField(0)
  late final String category;

  @HiveField(1)
  final bool type;

  Categories({required this.category, required this.type});
}

@HiveType(typeId: 2)
class Transactions extends HiveObject {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final Categories categoryType;

  @HiveField(2)
  final DateTime dateTime;

  Transactions(
      {required this.amount,
      required this.categoryType,
      required this.dateTime});
}

@HiveType(typeId: 3)
class ReminderDb extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime dateTime;

  ReminderDb(
      {required this.title, required this.amount, required this.dateTime});
}
