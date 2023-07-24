import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/hive_functions/db_functions.dart';
import '../start/screen_login.dart';

class MeWdget extends StatefulWidget {
  const MeWdget({super.key});

  @override
  State<MeWdget> createState() => _MeWdgetState();
}

class _MeWdgetState extends State<MeWdget> {
  String username = '';

  @override
  void initState() {
    super.initState();
    
    fetchUsername();
  }

  void fetchUsername() async {
    final db = SignUpDB();
    final dataList = await db.getDatas();
    if (dataList.isNotEmpty) {
      setState(() {
        username = dataList.last.username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person_outline_outlined,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              Text(
                username,
                style: const TextStyle(color: Colors.white),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20), 
                  child: Icon(Icons.star_outline),
                ),
               
                Text(
                  'TOTAL HABITS STARTED : 5',
                  style: GoogleFonts.unbounded(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20), 
                  child: Icon(Icons.celebration_outlined), 
                ),
                Text(
                  'COMPLEATED : 2',
                  style: GoogleFonts.unbounded(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
                ),
              ), 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20), 
                  child: Icon(Icons.favorite_outline_outlined), 
                ),
                Text(
                  'YOUR SCORE : 200',
                  style: GoogleFonts.unbounded(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 50,right: 30), 
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                          onPressed: () {
                    signOut(context);
                          },
                          child: const Text('sign out')),
                  ],
                ),
              ), 
            ],
          ),
        ),
        
      ],
    );
  }

  signOut(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const LogInPage()),
        (route) => false);
  }
}
