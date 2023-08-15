import 'package:hive/hive.dart';
part 'user_model.g.dart';     
@HiveType(typeId: 2)
class StartModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String habit;
  @HiveField(2)
  final String days;
  @HiveField(3)
  final String wheelName;
  @HiveField(4)
  final String wheelCount;
  @HiveField(5)
  final String todayHours;
  @HiveField(6)
  final String today;
  @HiveField(7)
  final String streak;
  @HiveField(8)
  final List week;
  @HiveField(9)
  final String doitAt;
  @HiveField(10)
  final DateTime date;
    @HiveField(11)
  final DateTime dateLastDone;

  StartModel({
    required this.id,
    required this.habit,
    required this.days,
    required this.wheelName,
    required this.wheelCount,
    required this.todayHours,
    required this.today,
    required this.streak,
    required this.week,
    required this.doitAt,
    required this.date,
    required this.dateLastDone, 
  });
}