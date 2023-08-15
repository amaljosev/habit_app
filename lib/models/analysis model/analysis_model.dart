

import 'package:hive/hive.dart';
part 'analysis_model.g.dart'; 
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