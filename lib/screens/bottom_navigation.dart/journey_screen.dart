import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/user/sub_pages/analysis_screen/bar_graph.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../functions/hive_functions/db_analysis.dart';
import '../../functions/hive_functions/db_date.dart';

class JourneyPage extends StatefulWidget {
  const JourneyPage({super.key});

  @override
  State<JourneyPage> createState() => _JourneyPageState();
}

class _JourneyPageState extends State<JourneyPage> {
  List<double> weeklySummary = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];

  DateTime? parsedDate;

  @override
  void initState() {
    super.initState();

    fetchDate();
    fetchAnalysisData();
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

  void fetchDate() async {
    final db = DateDB();
    final dateList = await db.getAlldates();
    if (dateList.isNotEmpty) {
      setState(() {
        parsedDate = DateTime.parse(dateList.first.date);
      });
    }
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
            padding: const EdgeInsets.only(
                top: 20, bottom: 140, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "JOURNEY",
                  style: GoogleFonts.comicNeue(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TableCalendar(
                    pageJumpingEnabled: true,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2035, 10, 16),
                    focusedDay: DateTime.now(),
                    calendarFormat: CalendarFormat.month,
                    rangeStartDay: parsedDate,
                    rangeEndDay: DateTime.now(),
                    calendarStyle: CalendarStyle(
                      rangeHighlightColor: Colors.indigo.shade400,
                      rangeEndDecoration: const BoxDecoration(
                        color: Colors.indigo,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(5, 5),
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      rangeStartDecoration: const BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      withinRangeTextStyle:
                          const TextStyle(color: Colors.white),
                      rangeHighlightScale: 0.2,
                      withinRangeDecoration: const BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      todayDecoration: const BoxDecoration(
                        color: Colors.indigo,
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
                      weekdayStyle: TextStyle(color: Colors.indigo),
                      weekendStyle: TextStyle(color: Colors.indigo),
                    ),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      headerPadding: EdgeInsets.all(15),
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Card(
                  color: Colors.indigo.shade100,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Most active days',
                          style: GoogleFonts.unbounded(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
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
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
