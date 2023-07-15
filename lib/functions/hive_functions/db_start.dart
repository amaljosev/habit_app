
import 'package:flutter/material.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<StartModel>> startListNotifier = ValueNotifier([]);


Future<void> addCategory(StartModel value) async {
  final categoryDB = await Hive.openBox<StartModel>('category_db');
  categoryDB.put(value.id, value);
  getallDatas();

}

Future<void> getallDatas() async {
  final categoryDB = await Hive.openBox<StartModel>('category_db');
  startListNotifier.value.clear();
  startListNotifier.value.addAll(categoryDB.values);
  startListNotifier.notifyListeners();
}



Future<void> deleteData(int id) async {
  final categoryDB = await Hive.openBox<StartModel>('category_db');
  await categoryDB.deleteAt(id);
  getallDatas();
}

Future<void> updateList(int id, StartModel value) async {
  final categoryDB = await Hive.openBox<StartModel>('category_db');
  categoryDB.putAt(id, value);
  getallDatas(); 
}