import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/functions/hive_functions/db_start.dart';
import '../../models/user_model.dart';
import '../user/screen_user.dart';

class TodayWidget extends StatefulWidget {
  const TodayWidget({super.key});

  @override
  State<TodayWidget> createState() => _TodayWidgetState();
}

class _TodayWidgetState extends State<TodayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: startListNotifier,
          builder:
              (BuildContext ctx, List<StartModel> startList, Widget? child) {
            return ListView.separated(
                itemBuilder: (ctx, indexVal) {
                  final startdata = startList[indexVal];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenUser(
                                          id: DateTime.now()
                                              .millisecond
                                              .toString(),
                                          index: indexVal,
                                          habitName: startdata.habit,
                                          totalDays: startdata.days,
                                          wheelCount: startdata.wheelCount,
                                          wheelName: startdata.wheelName,
                                          todayCount: startdata.todayHours,
                                          today: startdata.today,
                                          streak: startdata.streak,
                                          week: startdata.week,
                                          doItAt: startdata.doitAt,
                                          date: startdata.date,
                                          lastDoneDate: startdata.dateLastDone,
                                        )));
                          },
                          child: Card(
                            color: Colors.indigo.shade50,
                            child: ListTile(
                              title: Text(
                                startdata.habit,
                                style: GoogleFonts.andadaPro(
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 0);
                },
                itemCount: startList.length);
          },
        ),
      ),
    );
  }
}
