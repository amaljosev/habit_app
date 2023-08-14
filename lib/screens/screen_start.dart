import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/functions/hive_functions/db_start.dart';
import 'package:habit_project/models/sign_up/db_model.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
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
          child: SingleChildScrollView(  
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ 
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                                Text(
                                  'START A HABIT',
                                  style: GoogleFonts.comicNeue(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
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
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: totalDaysController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                filled: true,
                                fillColor: Colors.black12,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                              WeekdaySelector(
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
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        wheelCount = value.label;
                                        print(wheelCount);
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
                                        wheelName = value.label;
                                        print(wheelName);
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
                            ],
                          ),
                          const SizedBox(
                            height: 20,
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
                                activeBgColor: const [Colors.indigo],
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
                ],
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
