import 'package:hive/hive.dart';
part 'signup_model.g.dart';
@HiveType(typeId: 1)
class SignUpModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String mail;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;
  

  SignUpModel({required this.id,required this.mail,required this.username,required this.password});
}