import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../functions/hive_functions/db_start.dart';
import '../../models/sign_up/db_model.dart';
import '../screen_home.dart';

class StartWidget extends StatefulWidget {
  const StartWidget({Key? key}) : super(key: key);

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

TextEditingController total_DaysController = TextEditingController();
TextEditingController habit_NameController = TextEditingController();
var wheel_name;
var wheel_count;

class _StartWidgetState extends State<StartWidget> {
  final List<bool> selectedWeekdays = List.filled(7, true);
  final int defaultCountData = 1;
  final String defaultNameCount = 'Hours';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/create_bg.jpg'),
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
                        'ENTER HABIT NAME',
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
                  controller: habit_NameController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'HABIT NAME',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'ENTER TOTAL DAYS', 
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
                  controller: total_DaysController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Days',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelText: 'Duration',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
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
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'SELECT WEEKDAYS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
                      padding: const EdgeInsets.all(8.0),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Row(
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
                                            color: Colors.blue.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
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
                                            'Hours',
                                            'Pages',
                                            'Kilometer',
                                            'Meter',
                                            'Liter',
                                            'Cup',
                                            'Rupee',
                                          ][index],
                                          style: GoogleFonts.andadaPro(
                                            color: Colors.blue.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
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
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.blue.shade900,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'per day',
                                    style: GoogleFonts.andadaPro(
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                  padding: const EdgeInsets.all(8.0),
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
                      labels: const ['Morning', 'Noon', 'Evening'],
                      icons: const [
                        Icons.sunny,
                        Icons.wb_sunny_outlined,
                        Icons.bedtime_rounded
                      ],
                      onToggle: (index) {
                        List<String> labelValues = [
                          'Morning',
                          'Noon',
                          'Evening'
                        ];
                        if (index != null &&
                            index >= 0 &&
                            index < labelValues.length) {
                          String selectedValue = labelValues[index];
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
    final _days = total_DaysController.text.trim();
    final name = habit_NameController.text.trim();

    if (_days.isEmpty) {
      return;
    } else {
      total_DaysController.text = '';
      habit_NameController.text = '';

      setState(() {
        popDialogueBox();
      });
    }
int todayCount = 0;  
    final startObject = StartModel(
        id: DateTime.now().millisecond.toString(),
        habit: name,
        days: _days,
        wheelCount: wheel_count.toString(),
        wheelName: wheel_name,
        todayHours: todayCount.toString(),    
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
          title: const Text("Completed"),
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
                    return const HomeScreen();
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

    print('Selected weekdays: $weekdays');
  }
}
