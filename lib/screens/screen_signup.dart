import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habit_project/screens/screen_home.dart';
import '../functions/hive_functions/db_functions.dart';
import '../main.dart';
import '../models/sign_up/signup_model.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _userNameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    SignUpDB().getDatas().then((value) {
      print('signUp list');
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/newBackground.png"), 
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text('Get Started Free',
                          style: GoogleFonts.unbounded(  
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo )), 
                    )),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        filled: true,
                        fillColor: Colors.indigo.shade300,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'yourname@gmail.com',
                        labelText: 'Email Address',
                        labelStyle: const TextStyle(color: Colors.white), 
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enail Address is empty!';
                        }  else if (!EmailValidator.validate(value)) {
                        return 'Invalid email address!';
                      }
                        else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _userNameController,
                        keyboardType: TextInputType.name,
                        decoration:  InputDecoration(
                          
                          filled: true,
                          fillColor: Colors.indigo.shade300,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: '@yourname',
                          labelText: 'User Name',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ), 
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'User Name is empty!';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration:  InputDecoration(
                          filled: true,
                          fillColor: Colors.indigo.shade300,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: '**********',
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is empty!';
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addDataToModel();
                        } else {
                          print("Empty");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          fixedSize: const Size(220, 34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          )),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.unbounded(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> addDataToModel() async {
    final _mail = _emailController.text.trim();
    final _username = _userNameController.text.trim();
    final _password = _passwordController.text.trim();

    if (_mail.isEmpty || _username.isEmpty || _password.isEmpty) {
      return;
    } else {
      _emailController.text = '';
      _userNameController.text = '';
      _passwordController.text = '';
      
      
      final signUpDB = SignUpDB();
      final signUpList = await signUpDB.getDatas();
      
      var user;
      for (var signUp in signUpList) {
        if (signUp.username == _username && signUp.password == _password) {
          user = signUp;
          break;
        }
      }
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green[800],
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            content: const Text(
              'You are already registred',
              style: TextStyle(
                color: Colors.white,
              ),
            )));
            
        print('user already registred');
      } else {
        
        _emailController.text = '';
        _userNameController.text = '';
        _passwordController.text = '';
        final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(save_key_name, true);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) { 
          return const HomeScreen();
        }));
      }
    }

      

    final signUpObject = SignUpModel(
        mail: _mail,
        username: _username,
        password: _password,
        id: DateTime.now().millisecond.toString());

    print("$_mail $_username $_password ");

    SignUpDB().addData(signUpObject);
  }
}
