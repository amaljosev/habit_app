import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/hive_functions/db_functions.dart';
import '../screen_home.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/first_bg.jpg"),
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
                    Text('Welcome Back !',
                        style: GoogleFonts.unbounded(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Text('Welcome Back we missed you',
                          style: GoogleFonts.unbounded(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white70)),
                    )),
                    TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: '@yourname',
                          labelText: 'User Name',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
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
                      height: 30,
                    ),
                    TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: '**********',
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.grey,
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
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          addDataToModel();
                        } else {
                    
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(220, 34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          )),
                      child: Text(
                        "Log In",
                        style: GoogleFonts.unbounded(
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple),
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
    // ignore: no_leading_underscores_for_local_identifiers
    final _username = _usernameController.text;
    // ignore: no_leading_underscores_for_local_identifiers
    final _password = _passwordController.text;

    if (_username.isEmpty || _password.isEmpty) {
      return;
    }

    final signUpDB = SignUpDB();
    final signUpList = await signUpDB.getDatas();

    // ignore: prefer_typing_uninitialized_variables
    var user;
    for (var signUp in signUpList) {
      if (signUp.username == _username && signUp.password == _password) {
        user = signUp;
        break;
      }
    }

    if (user != null) {
      _usernameController.text = '';
      _passwordController.text = '';

      // ignore: no_leading_underscores_for_local_identifiers
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(save_key_name, true);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const Home()),
      );
    } else {
      _usernameController.text = '';
      _passwordController.text = '';

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[800],
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: const Text(
            'Invalid username or password!',
            style: TextStyle(
              color: Colors.white,
            ),
          )));
    }
  }
}
