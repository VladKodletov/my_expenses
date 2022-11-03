import 'package:hive/hive.dart';
part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime myDate;
  @HiveField(3)
  final double amount;

  Transaction({
    required this.id,
    required this.name,
    required this.myDate,
    required this.amount,
  });
}
