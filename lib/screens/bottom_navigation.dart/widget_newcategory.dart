import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../models/db_models/db_model.dart';
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
                Row(
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
                    
                Padding(
                  padding: const EdgeInsets.all(5.0), 
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: habit_NameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
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
                ),
                const SizedBox(height: 15,), 
                Row(
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
                Padding(
                  padding: const EdgeInsets.all(5.0),   
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: total_DaysController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Days',
                      hintStyle: TextStyle(color: Colors.grey),
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
                ),
                const SizedBox(height: 15,),      
                Column(
                  children: [
                    Padding(
                     padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: SelectorWheel(
                              childCount: 10,
                              convertIndexToValue: (int index) {
                                final value = index + 1;
                                return SelectorWheelValue(
                                  label: '$value',
                                  value: value.toDouble(),
                                  index: index,
                                );
                              },
                              onValueChanged:
                                  (SelectorWheelValue<double> value) {
                                wheel_count = value.label;
                                print(wheel_count);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: SelectorWheel( 
                              width: 100,  
                              childCount: 7,
                              convertIndexToValue: (int index) {
                                final units = [
                                  'Hours',
                                  'Pages',
                                  'Kilometer',
                                  'Meter',
                                  'Liter',
                                  'Cups',
                                  'Rupees',
                                ];
                                final value = units[index];
                                return SelectorWheelValue(
                                  label: value,
                                  value: value,
                                  index: index,
                                );
                              },
                              onValueChanged:
                                  (SelectorWheelValue<dynamic> value) {
                                wheel_name = value.label;
                                print(wheel_name);
                              },
                            ),
                          ),
                          Text(
                            'per day',
                            style: GoogleFonts.varela(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding( 
                  padding: const EdgeInsets.only(left: 14,right: 14),  
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleSwitch(
                    activeBgColor: const [Colors.indigo],
                    minWidth: 100.0,
                    initialLabelIndex: 0,
                    totalSwitches: 3,
                    inactiveBgColor: Colors.black12, 
                    labels: const ['MORNING', 'NOON', 'EVENING'],
                    icons: const [
                      Icons.sunny,
                      Icons.wb_sunny_outlined,
                      Icons.bedtime_rounded
                    ],
                    onToggle: (index) {
                      List<String> labelValues = ['MORNING', 'NOON', 'EVENING'];
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
          content: Image.asset('lib/assets/videos/information.gif'),
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
