import 'package:hive/hive.dart';
import '../../models/sign_up/db_model.dart';

const DATE_DB_NAME = 'date_db';

abstract class DateDBfunctions {
  Future<List<DateModel>> getAlldates();
  Future<void> addDate(DateModel value);
  Future<void> updateDate(int index, DateModel updatedValue);
}

class DateDB implements DateDBfunctions {
  @override
  Future<void> addDate(DateModel value) async {
    final habitDB = await Hive.openBox<DateModel>(DATE_DB_NAME);
    await habitDB.add(value);
  }

  @override
  Future<List<DateModel>> getAlldates() async {
    final habitDB = await Hive.openBox<DateModel>(DATE_DB_NAME);
    return habitDB.values.toList();
  }

  @override
  Future<void> updateDate(int index, DateModel updatedValue) async {
    final habitDB = await Hive.openBox<DateModel>(DATE_DB_NAME);
    await habitDB.putAt(index, updatedValue);
  }
  
}
