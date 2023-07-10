import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../../functions/hive_functions/db_start.dart';
import '../screen_home.dart';

class StartWidget extends StatefulWidget {
  const StartWidget({super.key});

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

final TextEditingController _habitController = TextEditingController();
final TextEditingController _daysController = TextEditingController();
final _formKey = GlobalKey<FormState>();

var data;

class _StartWidgetState extends State<StartWidget> {
  final List<bool> selectedWeekdays = List.filled(7, true);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _habitController,
                  keyboardType: TextInputType.multiline,
                  decoration:  InputDecoration(
                    filled: true,
                    fillColor: Colors.indigo.shade300,   
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Name',
                    hintStyle: const TextStyle(color: Colors.white60),
                    labelText: 'Habit Name',
                    labelStyle: const TextStyle(color: Colors.white ), 
                    prefixIcon: const Icon(
                      Icons.alarm_on_sharp,
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Habit Name is empty!';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _daysController,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                    filled: true,
                    fillColor:   Colors.indigo.shade300,  
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'REPETATION',
                          style: GoogleFonts.unbounded(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
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
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ToggleSwitch(
                        minWidth: 100.0,  
                        initialLabelIndex: 0,
                        totalSwitches: 3,
                        inactiveBgColor: Colors.grey, 
                        labels: const ['Morning', 'Noon', 'Evening'],
                        icons: const [Icons.sunny,Icons.wb_sunny_outlined,Icons.bedtime_rounded], 
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
                          if (_formKey.currentState!.validate()) {
                            addDataToModel();
                          } else {
                            print("Empty");
                          }
                        },
                        child: const Text(
                          'START',
                          style: TextStyle(color: Colors.deepPurple),  
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addDataToModel() async {
    final _days = _daysController.text.trim();
    final _habit = _habitController.text.trim();

    if (_days.isEmpty || _habit.isEmpty) {
      return;
    } else {
      _daysController.text = '';
      _habitController.text = '';
      setState(() {
        popDialogueBox();
      });
    }

    final addObject = StartModel(
        id: DateTime.now().millisecond,
        days: _days,
        habit: _habit,
        time: _days);

    print(" $_days $_habit ");

    addCategory(addObject);
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
                fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }));
                  },
                  child: const Text("Home")),
            ],
            content: Text(
              "Saved successfully",
              style: TextStyle(color: Colors.green[400]),
            ),
          );
        });
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
