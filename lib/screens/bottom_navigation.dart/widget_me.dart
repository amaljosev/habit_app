import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/functions/hive_functions/db_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/hive_functions/db_analysis.dart';
import '../../functions/hive_functions/db_count.dart';
import '../../functions/hive_functions/db_start.dart';
import '../start/screen_login.dart';
import 'help/screenhelp.dart';

class ScreenMe extends StatefulWidget {
  const ScreenMe({super.key});

  @override
  State<ScreenMe> createState() => _ScreenMeState();
}

class _ScreenMeState extends State<ScreenMe> {
  String username = '';
  String email = '';
  int countComplete = 0;
  int totalHabitsStarted = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();

    fetchUsername();
    fetchCount();
  }

  void fetchUsername() async {
    final db = SignUpDB();
    final dataList = await db.getDatas();
    if (dataList.isNotEmpty) {
      setState(() {
        username = dataList.last.username;
        email = dataList.last.mail;
        calculateTotalHabitsStarted().then((totalHabits) {
          setState(() {
            totalHabitsStarted = totalHabits;
          });
        });
      });
    }
  }

  void fetchCount() async {
    final db = HabitCountsDB();
    final countList = await db.getAllCounts();
    if (countList.isNotEmpty) {
      setState(() {
        countComplete = countList.last.totalHabitCompleted;
        calculateScore();
      });
    }
  }

  void calculateScore() {
    setState(() {
      score = countComplete * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 140, left: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.indigo.shade50,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.indigo,
                                    child: Icon(
                                      Icons.person_2_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          username,
                                          style: GoogleFonts.unbounded(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(email),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.indigo.shade50,
                                child: IconButton(
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            FractionallySizedBox(
                                          heightFactor: 0.6,
                                          child: AlertDialog(
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.close)),
                                                      const SizedBox(
                                                        width: 55,
                                                      ),
                                                      Text(
                                                        'Settings',
                                                        style: GoogleFonts
                                                            .unbounded(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Card(
                                                    color:
                                                        Colors.indigo.shade50,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'DELETE ALL HABITS',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              clearDatabase();
                                                              AnalysisDB()
                                                                  .clearAllData();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Icon(
                                                                Icons.delete),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Log out',
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              signOut(context);
                                                            },
                                                            child: const Icon(Icons
                                                                .power_settings_new_rounded),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.settings,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 2),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'RUNNING HABITS : $totalHabitsStarted',
                          style: GoogleFonts.unbounded(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade200,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'TOTAL HABITS COMPLETED : $countComplete',
                        style: GoogleFonts.unbounded(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'YOUR SCORE : $score',
                        style: GoogleFonts.unbounded(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(thickness: 2),
                ),
                Text(
                  'HELP',
                  style: GoogleFonts.comicNeue(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Frequently asked questions',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade50),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const ScreenHelp();
                      }),
                    );
                  },
                  child: Text(
                    'CLick me',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Divider(thickness: 2),
                ),
                Text(
                  'Rate our app',
                  style: GoogleFonts.comicNeue(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Please rate the app ',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade50),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => FractionallySizedBox(
                        heightFactor: 0.6,
                        child: AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Enjoying Our App',
                                    style: GoogleFonts.unbounded(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Drag and share your responce',
                                  style: GoogleFonts.comicNeue(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'It will help to improve the app',
                                  style: GoogleFonts.comicNeue(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return const Icon(
                                              Icons.sentiment_very_dissatisfied,
                                              color: Colors.red,
                                            );
                                          case 1:
                                            return const Icon(
                                              Icons.sentiment_dissatisfied,
                                              color: Colors.redAccent,
                                            );
                                          case 2:
                                            return const Icon(
                                              Icons.sentiment_neutral,
                                              color: Colors.amber,
                                            );
                                          case 3:
                                            return const Icon(
                                              Icons.sentiment_satisfied,
                                              color: Colors.lightGreen,
                                            );
                                          case 4:
                                            return const Icon(
                                              Icons.sentiment_very_satisfied,
                                              color: Colors.green,
                                            );
                                          default:
                                            return Container();
                                        }
                                      },
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Rate now',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Divider(thickness: 2),
                ),
                Text(
                  'Share with your friends',
                  style: GoogleFonts.comicNeue(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'It help to make our app available ',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'to more people',
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade50),
                  onPressed: () { 
                  
                  },
                  child: const Icon(Icons.share),
                ),
                const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Divider(thickness: 2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Privacy Policy |',
                        style: GoogleFonts.comicNeue(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        ' Terms and conditions', 
                        style: GoogleFonts.comicNeue(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/svg/instagram (1).svg',
                      width: 20,
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '|',
                        style: GoogleFonts.halant(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'lib/assets/svg/linkedin.svg',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  shareYourApp()  {
     
  }

  signOut(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const LogInPage()),
        (route) => false);
  }
}
