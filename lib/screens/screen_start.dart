import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:habit_project/screens/screen_home.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../functions/hive_functions/db_start.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StartScreen extends StatefulWidget {
  final String name;
  const StartScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

final TextEditingController totalDaysController = TextEditingController();

var wheelName;
var wheelCount;

class _StartScreenState extends State<StartScreen> {
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
              image: AssetImage('lib/assets/images/background_new.png'),
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
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: totalDaysController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.indigo.shade300,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Days',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'Duration',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.edit,
                      color: Colors.white,
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
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade300,
                        borderRadius: const BorderRadius.all(
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
                                itemExtent: 50,
                                onSelectedItemChanged: (index) {
                                  wheelCount = index + 1;
                                  print('Days: $wheelCount');
                                },
                                physics: const FixedExtentScrollPhysics(),
                                children: List<Widget>.generate(
                                  10,
                                  (index) => Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
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
                                children: const [
                                  Center(
                                    child: Text(
                                      'Hours',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Pages',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Kilometer',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Meter',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Liter',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Cup',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Rupee',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              alignment: Alignment.center,
                              child: const Text(
                                'per day',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
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
    final _days = totalDaysController.text.trim();

    if (_days.isEmpty) {
      return;
    } else {
      totalDaysController.text = '';

      setState(() {
        popDialogueBox();
      });
    }

    final startObject = StartModel(
        id: DateTime.now().millisecond.toString(),
        habit: widget.name,
        days: _days,
        wheelCount: wheelCount.toString(), 
        wheelName: wheelName);

    print("${widget.name} $_days  $wheelCount $wheelName");
    wheelCount = defaultCountData;
    wheelName = defaultNameCount;
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
