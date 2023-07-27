import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/user/sub_pages/analysis_screen/bar_graph.dart';
import 'package:table_calendar/table_calendar.dart';

import 'widget_me.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
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
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return const MeWdget();
                          }),
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
