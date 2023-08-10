import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen(
      {super.key,
      required this.date,
      required this.totalDays,
      required this.totalCount,
      required this.completedDays,
      required this.completedHours,
      required this.categoryname});
  final DateTime date;
  final String totalDays;
  final String totalCount;
  final String completedDays;
  final String completedHours;
  final String categoryname;

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    int completedDays = int.parse(widget.completedDays);
    int totalDays = int.parse(widget.totalDays);
    int completedCount = int.parse(widget.completedHours);
    int totalCount = int.parse(widget.totalCount); 

    // Calculate the percent based on completedDays and totalDays
    double percentDay = completedDays / totalDays;
    double percentCount = completedCount / totalCount; 
    return SafeArea( 
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'STATISTICS',
            style: GoogleFonts.comicNeue(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView( 
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.indigo.shade50,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TableCalendar(
                      pageJumpingEnabled: true,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2035, 10, 16),
                      focusedDay: DateTime.now(),
                      calendarFormat: CalendarFormat.month,
                      rangeStartDay: widget.date,
                      rangeEndDay: DateTime.now(),
                      calendarStyle: CalendarStyle(
                        rangeHighlightColor: Colors.indigo.shade300,
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
                        rangeHighlightScale: 0.3,
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'DAYS',
                        style: GoogleFonts.comicNeue(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Card(
                        elevation: 5,
                        color: Colors.pink.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: CircularPercentIndicator(
                            animation: true,
                            animateFromLastPercent: true,
                            radius: 60.0,
                            lineWidth: 9.0,
                            percent: percentDay,
                            center:
                                Text("${(percentDay * 100).toStringAsFixed(0)}%"),
                            progressColor: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.categoryname,
                        style: GoogleFonts.comicNeue(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Card(
                        elevation: 5,
                        color: Colors.green.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: CircularPercentIndicator(
                            animation: true,
                            animateFromLastPercent: true,
                            radius: 60.0,
                            lineWidth: 9.0,
                            percent: percentCount,
                            center: Text(
                                "${(percentCount * 100).toStringAsFixed(0)}%"),
                            progressColor: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
