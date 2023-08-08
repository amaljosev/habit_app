import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../models/sign_up/db_model.dart';
import '../home.dart';

class StartWidget extends StatefulWidget {
  const StartWidget({Key? key}) : super(key: key);

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

TextEditingController total_DaysController = TextEditingController();
TextEditingController habit_NameController = TextEditingController();
var wheel_name;
var wheel_count;
var do_itAt;
var week;

class _StartWidgetState extends State<StartWidget> {
  final List<bool> selectedWeekdays = List.filled(7, true);
  final int defaultCountData = 1;
  final String defaultNameCount = 'Hours';
  final String default_Week = 'MORNING';
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
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 140),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    'START A HABIT', 
                    style: GoogleFonts.comicNeue(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
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
                                'ENTER HABIT NAME',
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
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: habit_NameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.indigo.shade50,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'HABIT NAME',
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
                                'ENTER TOTAL DAYS',
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
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: total_DaysController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.indigo.shade50,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Days',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.alarm,
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
                
                Column(
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded (
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
                      padding: const EdgeInsets.all(8.0),
                      child: WeekdaySelector(
                        selectedColor: Colors.white,
                        fillColor: Colors.white,
                        selectedFillColor: Colors.indigo,
                        onChanged: (int day) {
                          setState(() {
                            final index = day % 7;
                            selectedWeekdays[index] = !selectedWeekdays[index];
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
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
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
                    Row( 
                      children: [ 
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ListWheelScrollView(
                              itemExtent: 70,
                              onSelectedItemChanged: (index) {
                                wheel_count = index + 1;
                                print('Days: $wheel_count');
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
                                          color:Colors.black,
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ListWheelScrollView(
                              itemExtent: 70,
                              onSelectedItemChanged: (index) {
                                wheel_name = index;
                                setState(() {
                                  if (index == 0) {
                                    wheel_name = 'HOURS';
                                  } else if (index == 1) {
                                    wheel_name = 'PAGES';
                                  } else if (index == 2) {
                                    wheel_name = 'KILOMETER';
                                  } else if (index == 3) {
                                    wheel_name = 'METER';
                                  } else if (index == 4) {
                                    wheel_name = 'LITER';
                                  } else if (index == 5) {
                                    wheel_name = 'CUP';
                                  } else if (index == 6) {
                                    wheel_name = 'RUPEE';
                                  }
                                });
                                print('Selected: $wheel_name');
                              },
                              physics: const FixedExtentScrollPhysics(),
                              children: List<Widget>.generate(
                                7,
                                (index) => Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        [
                                          'HOURS',
                                          'PAGES',
                                          'KILOMETE',
                                          'METER',
                                          'LITER',
                                          'CUP',
                                          'RUPEE',
                                        ][index],
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
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.2,
                            alignment: Alignment.center,
                            child: Text(
                              'per day',
                              style: GoogleFonts.andadaPro(
                                color: Colors.black, 
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                Row(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleSwitch( 
                    activeBgColor: const [Colors.indigo],
                    minWidth: 100.0,
                    initialLabelIndex: 0,
                    totalSwitches: 3,
                    inactiveBgColor: Colors.indigo.shade100,
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
                        do_itAt = selectedValue;
                      }
                    },
                  ),
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
                        if (habit_NameController.text.isNotEmpty) {
                          if (total_DaysController.text.isNotEmpty) {
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
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(10),
                                  content: Center(
                                    child: Text(
                                      'Enter Name of Habit',
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
    wheel_count ??= defaultCountData;
    wheel_name ??= defaultNameCount;
    do_itAt ??= default_Week;
    week ??= defaultWeekDays;
    final _days = total_DaysController.text.trim();
    final name = habit_NameController.text.trim();

    if (_days.isEmpty) {
      return;
    } else {
      total_DaysController.text = '';
      habit_NameController.text = '';

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
    final startObject = StartModel(
      id: DateTime.now().millisecond.toString(),
      habit: name,
      days: _days,
      wheelCount: wheel_count.toString(),
      wheelName: wheel_name,
      todayHours: todayCount.toString(),
      today: today.toString(),
      streak: streak.toString(),
      doitAt: do_itAt,
      week: week,
      date: DateTime.now(),
      dateLastDone: DateTime.now(),
    );

    print("$name $_days  $wheel_count $wheel_name");
    wheel_count = defaultCountData;
    wheel_name = defaultNameCount;
    addCategory(startObject);
  }

  popDialogueBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Scroll and select items based on your habit'),
          titleTextStyle: const TextStyle(color: Colors.indigo),
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
