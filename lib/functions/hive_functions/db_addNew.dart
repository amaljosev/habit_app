
import 'package:flutter/material.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<AddModel>> addListNotifier = ValueNotifier([]);


Future<void> addNew(AddModel value) async {
  final studentDB = await Hive.openBox<AddModel>('student_db');
  studentDB.put(value.id, value);
  getallstudents();
  print(value);
}

Future<void> getallstudents() async {
  final studentDB = await Hive.openBox<AddModel>('student_db');
  addListNotifier.value.clear();
  addListNotifier.value.addAll(studentDB.values);
  addListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<AddModel>('student_db');
  await studentDB.deleteAt(id);
  getallstudents();
}

Future<void> updateList(int id, AddModel value) async {
  final studentDB = await Hive.openBox<AddModel>('student_db');
  studentDB.putAt(id, value);
  getallstudents();
 }

