import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key, required this.date}); 
  final DateTime date;


  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}
 
class _AnalysisScreenState extends State<AnalysisScreen> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.green.shade100, 
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
                      calendarStyle: const CalendarStyle(
                        rangeHighlightColor: Colors.red,
                        rangeEndDecoration: BoxDecoration(
                          color: Colors.red,
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
                          color: Colors.red,
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
                          color: Colors.red,
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
                          color: Colors.green,
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
        ],
      ),
    );
  }
}