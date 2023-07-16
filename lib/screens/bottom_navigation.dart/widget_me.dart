import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person_outline_outlined,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              Text(
                username,
                style: const TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                  onPressed: () {
                    signOut(context);
                  },
                  child: const Text('sign out')),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                ),
              ),
            ],
          ),
        ),
      ],
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
