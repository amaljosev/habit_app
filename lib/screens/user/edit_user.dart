import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weekday_selector/weekday_selector.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../models/sign_up/db_model.dart';
import '../home.dart';

class EditUser extends StatefulWidget {
  final int index;
  final String habitName;
  final String totalDays;
  final String wheelCount;
  final String wheelName;
  final String id;
  final String name;
  final String today;
  final String percentage;
  final List week;
  final String doItAt;
  final DateTime date;
  final DateTime lastDoneDate;

  const EditUser({
    super.key,
    required this.habitName,
    required this.totalDays,
    required this.wheelCount,
    required this.wheelName,
    required this.id,
    required this.index,
    required this.name,
    required this.today,
    required this.percentage,
    required this.week,
    required this.doItAt,
    required this.date,
    required this.lastDoneDate,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController totalDaysController = TextEditingController();
  TextEditingController habitNameController = TextEditingController();
  var wheel_Name;
  var wheel_Count;
  var today_hours_Count;
  var today_days_count;
  var today_streak;
  var week_days;

  var do_it_at;
  @override
  void initState() {
    super.initState();
    totalDaysController = TextEditingController(text: widget.totalDays);
    habitNameController = TextEditingController(text: widget.habitName);
    wheel_Name = widget.wheelName;
    wheel_Count = widget.wheelCount;
    today_hours_Count = widget.name;
    today_days_count = widget.today;
    today_streak = widget.percentage;
    week_days = widget.week;
    do_it_at = widget.doItAt;
  }

  final List<bool> selectedWeekdays = List.filled(7, true);

  final int defaultCountData = 1;
  final String defaultNameCount = 'Hours';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8), 
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                            children: [
                              IconButton(onPressed: (){
                                Navigator.of(context).pop(); 
                              }, icon: const Icon(Icons.arrow_back_ios_new),), 
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Text(
                                  'Edit Habit',  
                                  style: GoogleFonts.comicNeue(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0), 
                                child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                              ), 
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'HABIT NAME',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            controller: habitNameController,
                            keyboardType: TextInputType.number, 
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.black12,  
                              focusedBorder: InputBorder.none, 
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none, 
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: 'Name',
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'HABIT DURATION',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
                              focusedBorder: InputBorder.none,
                              filled: true,
                              fillColor: Colors.black12,
                              border: OutlineInputBorder( 
                                 borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              hintText: 'Days',
                              hintStyle: TextStyle(color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.calendar_month_outlined,
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
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
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
                              const Row(
                                children: [
                                  Text(
                                    'COUNTER',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
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
                                        wheel_Count = value.label;
                                        print(wheel_Count);
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
                                        wheel_Name = value.label;
                                        print(wheel_Name);
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
                                Text(
                                  'DO IT AT',
                                  style: GoogleFonts.unbounded(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
                                inactiveBgColor: Colors.grey.shade200,
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
                                    do_it_at = selectedValue;
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
                                        10,
                                      ),
                                    )),
                                onPressed: () {
                                  if (habitNameController.text.isNotEmpty) {
                                    if (totalDaysController.text.isNotEmpty) {
                                      updateDetails(context);
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
                                  'UPDATE',
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
              ],
            ),
          ),
        ),
      ),
    );
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
                Navigator.of(context).push(
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
            weekdays.add('SUNDAY');
            break;
          case 1:
            weekdays.add('MONDAY');
            break;
          case 2:
            weekdays.add('TUESDAY');
            break;
          case 3:
            weekdays.add('WEDNESDAY');
            break;
          case 4:
            weekdays.add('THURSDAY');
            break;
          case 5:
            weekdays.add('FRIDAY');
            break;
          case 6:
            weekdays.add('SATURDAY');
            break;
        }
      }
    }
    week_days = weekdays;
    print('Selected weekdays: $weekdays');
  }

  Future<void> updateDetails(ctx) async {
    final dataModel = StartModel(
        id: DateTime.now().millisecond.toString(),
        habit: habitNameController.text,
        days: totalDaysController.text,
        wheelCount: wheel_Count.toString(),
        wheelName: wheel_Name.toString(),
        todayHours: today_hours_Count.toString(),
        today: today_days_count.toString(),
        streak: today_streak.toString(),
        week: week_days,
        doitAt: do_it_at,
        date: widget.date,
        dateLastDone: widget.lastDoneDate);

    await updateList(widget.index, dataModel);

    popDialogueBox();
  }
}
