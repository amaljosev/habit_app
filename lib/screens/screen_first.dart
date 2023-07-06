



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/screen_login.dart';
import 'package:habit_project/screens/screen_signup.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 27, 67),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration:  const BoxDecoration(
          image:  DecorationImage(
         image:  AssetImage("lib/assets/images/FirstPage.png"),
         fit: BoxFit.fill,
          ),
        ),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                      child: Text('My Habits',
                          style: GoogleFonts.acme(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child:
                      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Make your life helthy",
                      style: GoogleFonts.unbounded(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUp()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(220, 34),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                side: const BorderSide(
                                  color: Colors.white,
                                ))),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.unbounded(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LogInPage()),
                          );
                        },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(220, 34),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            20,
                          ))),
                      child: Text(
                        "Log In",
                        style: GoogleFonts.unbounded(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ]),
                )
              ],
            ),
      ),
    );
  }
 }
