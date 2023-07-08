
import 'package:flutter/material.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<StartModel>> startListNotifier = ValueNotifier([]);


Future<void> addStudent(StartModel value) async {
  final studentDB = await Hive.openBox<StartModel>('student_db');
  studentDB.put(value.id, value);
  getallstudents();
  print(value);
}

Future<void> getallstudents() async {
  final studentDB = await Hive.openBox<StartModel>('student_db');
  startListNotifier.value.clear();
  startListNotifier.value.addAll(studentDB.values);
  startListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StartModel>('student_db');
  await studentDB.deleteAt(id);
  getallstudents();
}

Future<void> updateList(int id, StartModel value) async {
  final studentDB = await Hive.openBox<StartModel>('student_db');
  studentDB.putAt(id, value);
  getallstudents();
 }

