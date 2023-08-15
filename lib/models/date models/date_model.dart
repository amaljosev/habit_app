import 'package:hive/hive.dart';
part 'date_model.g.dart'; 
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
