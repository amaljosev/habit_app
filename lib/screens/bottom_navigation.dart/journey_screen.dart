import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/user/sub_pages/analysis_screen/bar_graph.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../functions/hive_functions/db_functions.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  String username = '';
  String email = '';

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
        email = dataList.last.mail;
      });
    }
  }

  List<double> weeklySummary = [10.0, 20.0, 30.0, 50.0, 80.0, 25.0, 35.0, 25.0];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                  "STATISTICS",
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
                          builder: (BuildContext context) => AlertDialog(
                            content: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.close)),
                                  ],
                                ),
                                Card(
                                  color: Colors.blue.shade50,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              child:
                                                  Icon(Icons.person_2_outlined),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    username,
                                                    style:
                                                        GoogleFonts.unbounded(
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
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'TOTAL HABITS STARTED : 5',
                                          style: GoogleFonts.unbounded(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'TOTAL HABITS STARTED : 5',
                                          style: GoogleFonts.unbounded(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
              padding: const EdgeInsets.all(18.0),
              child: Card(
                elevation: 5,
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                ),
              ),
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
    );
  }
}
