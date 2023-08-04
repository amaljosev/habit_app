import 'package:hive/hive.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class SignUpModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String mail;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;

  SignUpModel(
      {required this.id,
      required this.mail,
      required this.username,
      required this.password});
}

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

@HiveType(typeId: 3)
class HabitsCountModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int totalHabitCompleted;

  HabitsCountModel({required this.id, required this.totalHabitCompleted});
}

@HiveType(typeId: 4)
class DateModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String date;

  DateModel({
    required this.id,
    required this.date,
  });
}

@HiveType(typeId: 5)
class AnalysisModel {
  @HiveField(0)
  final int id; 

  @HiveField(1)
  final double monday;

  @HiveField(2)
  final double tuesday;

  @HiveField(3)
  final double wednesday;

  @HiveField(4)
  final double thursday;

  @HiveField(5)
  final double friday;

  @HiveField(6)
  final double saturday;

  @HiveField(7)
  final double sunday;

  AnalysisModel({
    required this.id,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });
}
