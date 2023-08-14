import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/hive_functions/db_functions.dart';
import '../../main.dart';
import 'package:email_validator/email_validator.dart';
import '../../models/db_models/db_model.dart';
import '../home.dart';

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
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text('Begin your journey',
                          style: GoogleFonts.ubuntu(        
                              fontSize: 25,  
                              fontWeight: FontWeight.bold,
                              color: Colors.white )), 
                    )),
                    TextFormField(
                      style: const TextStyle(color: Colors.black), 
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:  const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70, 
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'yourname@gmail.com',
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Colors.grey), 
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.grey, 
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
                        style: const TextStyle(color: Colors.black),
                        controller: _userNameController,
                        keyboardType: TextInputType.name,
                        decoration:  const InputDecoration(
                          
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
                      height: 20,
                    ),
                    TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration:  const InputDecoration(
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
                          backgroundColor: Colors.white,
                          fixedSize: const Size(220, 34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          )),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.unbounded(
                            fontWeight: FontWeight.w500, color: Colors.indigo),  
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
          return const Home();
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
