import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/functions/hive_functions/db_start.dart';
import 'package:habit_project/models/sign_up/db_model.dart';

import 'package:weekday_selector/weekday_selector.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../functions/hive_functions/db_date.dart';
import 'home.dart';

class StartScreen extends StatefulWidget {
  final String name;
  const StartScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

final TextEditingController totalDaysController = TextEditingController();

var wheelName;
var wheelCount;
var doitAt;
var week;

class _StartScreenState extends State<StartScreen> {
  final List<bool> selectedWeekdays = List.filled(7, true);

  final int defaultCountData = 1;
  final String defaultNameCount = 'Hours';
  final String defaultWeek = 'MORNING';
  List defaultWeekDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/start_habit.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    'START A HABIT',
                    style: GoogleFonts.unbounded(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ), 
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'ENTER DURATION',
                    style: GoogleFonts.unbounded(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: totalDaysController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Days ',  
                    hintStyle: TextStyle(color: Colors.grey),
                    
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Duration empty!';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text( 
                            'SELECT WEEKDAYS',
                            style: GoogleFonts.unbounded(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                          ),
                        ],
                      ),
                    ),
                    WeekdaySelector(
                      onChanged: (int day) {
                        setState(() {
                          final index = day % 7;
                          selectedWeekdays[index] = !selectedWeekdays[index];
                          printSelectedWeekdays();
                        });
                      },
                      values: selectedWeekdays,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),  
                      child: Row(
                        children: [
                          Text(
                            'COUNTER',
                            style: GoogleFonts.unbounded(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text('SCROLL THE WHEEL'),
                          // ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ListWheelScrollView(
                                    itemExtent: 50,
                                    onSelectedItemChanged: (index) {
                                      wheelCount = index + 1;
                                      print('Days: $wheelCount');
                                    },
                                    physics: const FixedExtentScrollPhysics(),
                                    children: List<Widget>.generate(
                                      10,
                                      (index) => Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              '${index + 1}',
                                              style: GoogleFonts.andadaPro(
                                                color: Colors.blue.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                            child: Divider(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ListWheelScrollView(
                                    itemExtent: 50,
                                    onSelectedItemChanged: (index) {
                                      wheelName = index;
                                      setState(() {
                                        if (index == 0) {
                                          wheelName = 'HOURS';
                                        } else if (index == 1) {
                                          wheelName = 'PAGES';
                                        } else if (index == 2) {
                                          wheelName = 'KILOMETER';
                                        } else if (index == 3) {
                                          wheelName = 'METER';
                                        } else if (index == 4) {
                                          wheelName = 'LITER';
                                        } else if (index == 5) {
                                          wheelName = 'CUP';
                                        } else if (index == 6) {
                                          wheelName = 'RUPEE';
                                        }
                                      });
                                      print('Selected: $wheelName');
                                    },
                                    physics: const FixedExtentScrollPhysics(),
                                    children: [
                                      for (var name in [
                                        'HOUR',
                                        'PAGES',
                                        'KILOMETER',
                                        'METER',
                                        'LITER',
                                        'CUP',
                                        'RUPEE'
                                      ])
                                        Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                name,
                                                style: GoogleFonts.andadaPro(
                                                  color: Colors.blue.shade900,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 50,
                                              child:
                                                  Divider(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'per day',
                                    style: GoogleFonts.andadaPro(
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),  
                  child: Row(
                    children: [
                      Text(
                        'DO IT AT',
                        style: GoogleFonts.unbounded(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ToggleSwitch(
                      minWidth: 100.0,
                      initialLabelIndex: 0,
                      totalSwitches: 3,
                      inactiveBgColor: Colors.grey,
                      labels: const ['MORNING', 'NOON', 'EVENING'],
                      icons: const [
                        Icons.sunny,
                        Icons.wb_sunny_outlined,
                        Icons.bedtime_rounded
                      ],
                      onToggle: (index) {
                        List<String> labelValues = [
                          'MORNING',
                          'NOON',
                          'EVENING'
                        ];
                        if (index != null &&
                            index >= 0 &&
                            index < labelValues.length) {
                          String selectedValue = labelValues[index];
                          doitAt = selectedValue;
                          print('Switched to: $selectedValue');
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (totalDaysController.text.isNotEmpty) {
                          addDataToModel();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(10),
                                  content: Center(
                                    child: Text(
                                      'Enter Duration of Habit',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )));

                          print("Empty");
                        }
                      },
                      child: const Text(
                        'START',
                        style: TextStyle(color: Colors.white),
                      ),
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

  Future<void> addDataToModel() async {
    wheelCount ??= defaultCountData;
    wheelName ??= defaultNameCount;
    doitAt ??= defaultWeek;
    week ??= defaultWeekDays;
    final _days = totalDaysController.text.trim();

    if (_days.isEmpty) {
      return;
    } else {
      totalDaysController.text = '';

      setState(() {
        popDialogueBox();
      });
    }

    int todayCount = 0;
    int today = 0;
    int streak = 0;
     DateTime currentDate = DateTime.now();
DateTime currentDateWithoutTime = DateTime(currentDate.year, currentDate.month, currentDate.day);
    final startObject = StartModel(
        id: DateTime.now().millisecond.toString(),
        habit: widget.name,
        days: _days,
        wheelCount: wheelCount.toString(),
        wheelName: wheelName,
        todayHours: todayCount.toString(),
        today: today.toString(),
        streak: streak.toString(),
        week: week,
        doitAt: doitAt,
        date:DateTime.now(),dateLastDone:currentDateWithoutTime ); 

    print("${widget.name} $_days  $wheelCount $wheelName $today "); 
    wheelCount = defaultCountData;
    wheelName = defaultNameCount;

    addCategory(startObject);

    final date = DateModel(
        id: DateTime.now().millisecond.toString(),
        date: DateTime.now().toString());
        DateDB().addDate(date);  
  }

  popDialogueBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("HABIT STARTED"),  
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[400],
            fontSize: 20,
          ),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(  
                  MaterialPageRoute(builder: (context) {
                    return const Home(); 
                  }),
                );
              },
              child: const Text("Home"),
            ),
          ],
          content: Text(
            "Saved successfully",
            style: TextStyle(color: Colors.green[400]),
          ),
        );
      },
    );
  }

  void printSelectedWeekdays() {
    final weekdays = <String>[];

    for (int i = 0; i < selectedWeekdays.length; i++) {
      if (selectedWeekdays[i]) {
        switch (i) {
          case 0:
            weekdays.add('Sunday');
            break;
          case 1:
            weekdays.add('Monday');
            break;
          case 2:
            weekdays.add('Tuesday');
            break;
          case 3:
            weekdays.add('Wednesday');
            break;
          case 4:
            weekdays.add('Thursday');
            break;
          case 5:
            weekdays.add('Friday');
            break;
          case 6:
            weekdays.add('Saturday');
            break;
        }
      }
    }
    week = weekdays;
    print('Selected weekdays: $weekdays');
  }
}
