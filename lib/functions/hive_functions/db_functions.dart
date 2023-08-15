
import 'package:hive/hive.dart';

import '../../models/signup_models/signup_model.dart';
// ignore: constant_identifier_names
const SIGNUP_DB_NAME='signup_db';
abstract class SignupDBfunctions {
  Future<List <SignUpModel>> getDatas();
  Future<void> addData(SignUpModel value);
}
class SignUpDB implements SignupDBfunctions {
  @override
  Future <void>addData(SignUpModel value)async{
    // ignore: no_leading_underscores_for_local_identifiers
    final _signupDB=await Hive.openBox<SignUpModel>(SIGNUP_DB_NAME);
    await _signupDB.add(value);
  }
  
  @override
  Future<List<SignUpModel>> getDatas() async{
    // ignore: no_leading_underscores_for_local_identifiers
    final _signupDB=await Hive.openBox<SignUpModel>(SIGNUP_DB_NAME);
    return _signupDB.values.toList();
  }

  
}