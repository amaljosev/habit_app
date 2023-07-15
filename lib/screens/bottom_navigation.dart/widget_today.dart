import 'package:flutter/material.dart';
import 'package:habit_project/functions/hive_functions/db_start.dart';
import '../../models/sign_up/signup_model.dart';
import '../user/screen_user.dart';

class TodayWidget extends StatefulWidget {
  const TodayWidget({super.key});

  @override
  State<TodayWidget> createState() => _TodayWidgetState();
}

class _TodayWidgetState extends State<TodayWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: startListNotifier,
      builder: (BuildContext ctx, List<StartModel> startList, Widget? child) {
        return ListView.separated(
            itemBuilder: (ctx, indexVal) {
              final startdata = startList[indexVal];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenUser(
                                  id: DateTime.now().millisecond.toString(),
                                  index: indexVal,
                                      habitName: startdata.habit,
                                      totalDays: startdata.days,
                                      wheelCount: startdata.wheelCount,
                                      wheelName: startdata.wheelName, 
                                    )));
                        print(startList[indexVal]);
                      },
                      child: Card(
                        color: Colors.indigo.shade400,
                        child: ListTile(
                          title: Text(
                            startdata.habit,
                            style: const TextStyle(color: Colors.white),
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
    );
  }
}
