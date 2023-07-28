import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/screen_home.dart';
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/profile_bg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return const HomeScreen();
                          }),
                        );
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8, 
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  border: Border.all(
                    color: Colors.white, 
                    width: 2.0,
                  ),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'STARTED HABITS'),
                          Tab(
                            text: 'COMPLETED HABITS',
                          ),
                        ],
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black54,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.black,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'TOTAL HABITS STARTED : 5',
                                      style: GoogleFonts.unbounded(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'TOTAL HABITS STARTED : 5',
                                      style: GoogleFonts.unbounded(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'COMPLETED : 2',
                                style: GoogleFonts.unbounded(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                signOut(context);
                              },
                              child: const Text('sign out'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
