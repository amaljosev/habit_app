import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/user/sub_pages/analysis_screen/bar_graph.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../functions/hive_functions/db_analysis.dart';
import '../../functions/hive_functions/db_count.dart';
import '../../functions/hive_functions/db_date.dart';
import '../../functions/hive_functions/db_functions.dart';
import '../../functions/hive_functions/db_start.dart';
import '../start/screen_login.dart';


class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  List<double> weeklySummary = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  String username = '';
  String email = '';
  int countComplete = 0;
  int totalHabitsStarted = 0;
  int score = 0;
  DateTime? parsedDate;

  @override
  void initState() {
    super.initState();

    fetchUsername();
    fetchCount();
    fetchDate();
    fetchAnalysisData();
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

  void fetchAnalysisData() async {
    final db = AnalysisDB();
    final analysList = await db.getAllanalysData();
    if (analysList.isNotEmpty) {
      setState(
        () {
          weeklySummary = [
            analysList.last.monday,
            analysList.last.tuesday,
            analysList.last.wednesday,
            analysList.last.thursday,
            analysList.last.friday,
            analysList.last.saturday,
            analysList.last.sunday
          ];
        },
      );
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

  void fetchDate() async {
    final db = DateDB();
    final dateList = await db.getAlldates();
    if (dateList.isNotEmpty) {
      setState(() {
        parsedDate = DateTime.parse(dateList.first.date);
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "JOURNEY",
                    style: GoogleFonts.unbounded(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
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
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.close)),
                                          const SizedBox(
                                            width: 55,
                                          ),
                                          Text(
                                            'profile',
                                            style: GoogleFonts.unbounded(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Card(
                                        color: Colors.blue.shade50,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    child: Icon(
                                                      Icons.person_2_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          username,
                                                          style: GoogleFonts
                                                              .unbounded(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                        Text(email),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                          color: Colors.green.shade200,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                clearDatabase();
                                                AnalysisDB().clearAllData();
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'DELETE ALL HABITS',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                const Text('log out'), 
                                                IconButton(
                                                  onPressed: () {
                                                    signOut(context);
                                                  },
                                                  icon: const Icon(Icons
                                                      .power_settings_new_rounded),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue.shade800,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.blue.shade100,  
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TableCalendar(
                      pageJumpingEnabled: true,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2035, 10, 16),
                      focusedDay: DateTime.now(),
                      calendarFormat: CalendarFormat.month,
                      rangeStartDay: parsedDate,
                      rangeEndDay: DateTime.now(),
                      calendarStyle: const CalendarStyle(
                        rangeHighlightColor: Colors.blue,
                        rangeEndDecoration: BoxDecoration( 
                          color: Colors.blue, 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        rangeStartDecoration: BoxDecoration(
                          color: Colors.blue, 
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        withinRangeTextStyle: TextStyle(color: Colors.white),
                        rangeHighlightScale: 0.2,
                        withinRangeDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.blue, 
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.blue),
                        weekendStyle: TextStyle(color: Colors.blue),
                      ),
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        headerPadding: EdgeInsets.all(15),
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  color: Colors.blue.shade100,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Most active days',   
                          style: GoogleFonts.unbounded(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, 
                          ),),
                      ), 
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          height: 200,
                          child: MybarGraph(
                            weeklySummary: weeklySummary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox( 
                height: 30,
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
