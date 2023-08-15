import 'package:hive/hive.dart';
part 'count_model.g.dart'; 
@HiveType(typeId: 3)
class HabitsCountModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int totalHabitCompleted;

  HabitsCountModel({required this.id, required this.totalHabitCompleted});
}