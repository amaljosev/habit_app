import 'package:hive/hive.dart';

import '../../models/count_model/count_model.dart';



const COUNT_DB_NAME = 'count_db';

abstract class HabitCountDBfunctions {
  Future<List<HabitsCountModel>> getAllCounts();
  Future<void> addCounts(HabitsCountModel value);
  Future<void> updateCounts(int index, HabitsCountModel updatedValue);
}

class HabitCountsDB implements HabitCountDBfunctions {
  @override
  Future<void> addCounts(HabitsCountModel value) async {
    final habitDB = await Hive.openBox<HabitsCountModel>(COUNT_DB_NAME);
    await habitDB.add(value);
  }

  @override
  Future<List<HabitsCountModel>> getAllCounts() async {
    final habitDB = await Hive.openBox<HabitsCountModel>(COUNT_DB_NAME);
    return habitDB.values.toList();
  }

  @override
  Future<void> updateCounts(int index, HabitsCountModel updatedValue) async {
    final habitDB = await Hive.openBox<HabitsCountModel>(COUNT_DB_NAME);
    await habitDB.putAt(index, updatedValue);
  }
}
