
import 'package:flutter/material.dart';
import 'package:habit_project/models/sign_up/db_model.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);


Future<void> addUserData(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userDB.put(value.id, value);
  getallUserDatas();

}

Future<void> getallUserDatas() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userListNotifier.value.clear(); 
  userListNotifier.value.addAll(userDB.values);
  userListNotifier.notifyListeners();
}



Future<void> deleteUserData(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  await userDB.deleteAt(id);
  getallUserDatas();
}

Future<void> updateUserList(int id, UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userDB.putAt(id, value);
  getallUserDatas(); 
}


