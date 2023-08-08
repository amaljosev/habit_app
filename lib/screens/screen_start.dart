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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/new_bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          const SizedBox(
                            width: 50,
                          ),
                          Text(
                            'START A HABIT',
                            style: GoogleFonts.comicNeue(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.indigo.shade50,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    'ENTER DURATION',
                                    style: GoogleFonts.unbounded(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: totalDaysController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.indigo.shade50,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Days ',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
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
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.indigo.shade50,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'SELECT WEEKDAYS',
                                        style: GoogleFonts.unbounded(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: WeekdaySelector(
                            selectedFillColor: Colors.indigo,
                            onChanged: (int day) {
                              setState(() {
                                final index = day % 7;
                                selectedWeekdays[index] =
                                    !selectedWeekdays[index];
                                printSelectedWeekdays();
                              });
                            },
                            values: selectedWeekdays,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.indigo.shade50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Center(
                                      child: Text(
                                        'SET  COUNTER',
                                        style: GoogleFonts.unbounded(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.indigo.shade50,
                                child: IconButton(
                                    onPressed: () {
                                      popDialogueBox();
                                    },
                                    icon: const Icon(
                                      Icons.info_outline,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Padding( 
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height *
                                      0.2,
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
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height *
                                      0.2,
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
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Column( 
                                children: [
                                  Text( 
                                        'per day',
                                        style: GoogleFonts.andadaPro(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ), 
                                      const SizedBox(height: 30,),  
                                  
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.indigo.shade50,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'DO IT AT',
                                    style: GoogleFonts.unbounded(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ToggleSwitch(
                          activeBgColor: [Colors.indigo],
                          minWidth: 100.0,
                          initialLabelIndex: 0,
                          totalSwitches: 3,
                          inactiveBgColor: Colors.indigo.shade50,
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              fixedSize: const Size(220, 34),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              )),
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
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const Home();
          }),
        );
      });
    }

    int todayCount = 0;
    int today = 0;
    int streak = 0;
    DateTime currentDate = DateTime.now();
    DateTime currentDateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
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
        date: DateTime.now(),
        dateLastDone: currentDateWithoutTime);

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
          title: const Text(
              'Scroll and select items based on your habit.Set wheel for how many times do you want perform '),
          titleTextStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          content: Image.asset('lib/assets/videos/info scroll .gif'),
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
