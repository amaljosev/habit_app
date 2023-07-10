import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:habit_project/screens/screen_home.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../functions/hive_functions/db_start.dart';
import 'package:toggle_switch/toggle_switch.dart';
class StartScreen extends StatefulWidget {
  final String name;
  const StartScreen({super.key, required this.name});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

final TextEditingController _daysController = TextEditingController();

final _formKey = GlobalKey<FormState>();

var countData;
var hoursData;
var namecount;

class _StartScreenState extends State<StartScreen> {
  final List<bool> selectedWeekdays = List.filled(7, true);
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
          )),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text('START A HABIT',
                        style: GoogleFonts.unbounded(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _daysController, 
                    keyboardType: TextInputType.number,
                    decoration:   InputDecoration(
                      filled: true,
                      fillColor: Colors.indigo.shade300,   
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
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Text(
                        'SELECT WEEKDAYS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'COUNTER',
                              style: GoogleFonts.unbounded(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration:   BoxDecoration( 
                            color: Colors.indigo.shade300,   
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))), 
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: ListWheelScrollView(
                                  itemExtent: 50,
                                  onSelectedItemChanged: (index) {
                                    countData = index + 1;
                                    print('Days: $countData');
                                  },
                                  children: List<Widget>.generate(
                                    10,
                                    (index) => Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: ListWheelScrollView(
                                  itemExtent: 50,
                                  onSelectedItemChanged: (index) {
                                    hoursData = index;
                                    setState(() {
                                      if (index == 0) {
                                        namecount = 'cup';
                                      } else if (index == 1) {
                                        namecount = 'liter';
                                      } else if (index == 2) {
                                        namecount = 'Hours';
                                      } else if (index == 3) {
                                        namecount = 'page';
                                      } else if (index == 4) {
                                        namecount = 'Kilometer';
                                      } else if (index == 5) {
                                        namecount = 'Meter';
                                      } else if (index == 6) {
                                        namecount = 'Rupee';
                                      }
                                    });
                                    print('selected: $namecount');
                                  },
                                  children: const [
                                    Center(
                                      child: Text(
                                        'Cup',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Liter',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Hours',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Page',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Kilometer',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Meter',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Rupee',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                alignment: Alignment.center,
                                child: const Text(
                                  'per day',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
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
                              color: Colors.white),
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
                        labels: ['Morning', 'Noon', 'Evening'],
                        icons: [Icons.sunny,Icons.wb_sunny_outlined,Icons.bedtime_rounded], 
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
                            if (_formKey.currentState!.validate()) {
                              addDataToModel();
                            } else {
                              print("Empty");
                            }
                          },
                          child: const Text(
                            'START',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
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
    var counter = namecount + countData.toString();
    final _days = _daysController.text.trim();

    if (_days.isEmpty || namecount.isEmpty) {
      return;
    } else {
      _daysController.text = '';

      setState(() {
        popDialogueBox();
      });
    }

    final startObject = StartModel(
        id: DateTime.now().millisecond,
        habit: widget.name,
        days: _days,
        time: counter);

    print("${widget.name} $_days $counter ");

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
