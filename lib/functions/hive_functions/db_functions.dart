
import 'package:hive/hive.dart';

import '../../models/db_models/db_model.dart';
const SIGNUP_DB_NAME='signup_db';
abstract class SignupDBfunctions {
  Future<List <SignUpModel>> getDatas();
  Future<void> addData(SignUpModel value);
}
class SignUpDB implements SignupDBfunctions {
  @override
  Future <void>addData(SignUpModel value)async{
    final _signupDB=await Hive.openBox<SignUpModel>(SIGNUP_DB_NAME);
    await _signupDB.add(value);
  }
  
  @override
  Future<List<SignUpModel>> getDatas() async{
    final _signupDB=await Hive.openBox<SignUpModel>(SIGNUP_DB_NAME);
    return _signupDB.values.toList();
  }

  
}