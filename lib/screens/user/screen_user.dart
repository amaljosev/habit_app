import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/user/sub_pages/analysis_screen.dart';
import 'package:habit_project/screens/user/sub_pages/screen_timer.dart';
import 'package:habit_project/screens/user/sub_pages/stopwatch_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';
import '../../functions/hive_functions/db_analysis.dart';
import '../../functions/hive_functions/db_count.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../models/sign_up/db_model.dart';
import '../screen_home.dart';
import 'edit_user.dart';

ValueNotifier<int> habitNameNotifier = ValueNotifier<int>(habitName ?? 0);
ValueNotifier<int> daysNotifier = ValueNotifier<int>(days ?? 0);
ValueNotifier<int> streakNotifier = ValueNotifier<int>(days ?? 0);
int? habitName;
int? days;
int? streak;

class ScreenUser extends StatefulWidget {
  final int index;
  final String id;
  final String habitName;
  final String totalDays;
  final String wheelCount;
  final String wheelName;
  final String todayCount;
  final String today;
  final String streak;
  final List week;
  final String doItAt;
  final DateTime date;

  const ScreenUser({
    super.key,
    required this.habitName,
    required this.totalDays,
    required this.wheelCount,
    required this.wheelName,
    required this.index,
    required this.id,
    required this.todayCount,
    required this.today,
    required this.streak,
    required this.week,
    required this.doItAt,
    required this.date,
  });

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  double monday = 0.0;
  double tuesday = 0.0;
  double wednesday = 0.0;
  double thursday = 0.0;
  double friday = 0.0;
  double saturday = 0.0;
  double sunday = 0.0;
  int completed = 0;
  @override
  void initState() {
    super.initState();

    fetchCount();
    checkAndResetHabit();
  }

  void fetchCount() async {
    final db = HabitCountsDB();
    final dataList = await db.getAllCounts();
    if (dataList.isNotEmpty) {
      setState(
        () {
          completed = dataList.last.totalHabitCompleted;
        },
      );
    }
  }

  Future<void> checkAndResetHabit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastUsedDate = prefs.getString('lastUsedDate') ?? '';

    DateTime currentDate = DateTime.now();
    String formattedCurrentDate =
        "${currentDate.year}-${currentDate.month}-${currentDate.day}";

    if (lastUsedDate != formattedCurrentDate) {
      setState(() {
        habitNameNotifier.value = 0;
        updateList(
          widget.index,
          StartModel(
              id: DateTime.now().millisecond.toString(),
              days: widget.totalDays,
              habit: widget.habitName,
              wheelCount: widget.wheelCount,
              wheelName: widget.wheelName,
              todayHours: habitNameNotifier.value.toString(),
              today: widget.today.toString(),
              streak: widget.streak.toString(),
              doitAt: widget.doItAt,
              week: widget.week,
              date: widget.date),
        );
      });

      // Save the current date as the last used date in shared preferences
      await prefs.setString('lastUsedDate', formattedCurrentDate);
    }
  }

  SampleItem? selectedMenu;

  bool shouldShowButtons(List week) {
    // Get the current day of the week (e.g., "Monday", "Tuesday")
    String currentDayOfWeek = DateFormat('EEEE').format(DateTime.now());

    // Check if the current day is present in the list of days
    bool isDayInWeek = week.contains(currentDayOfWeek);

    // Return true if the current day is in the list, otherwise false
    return isDayInWeek;
  }

  bool disableButtons() {
    String todayCount = widget.todayCount;
    String today = widget.wheelCount;
    bool isDisable = true;

    if (todayCount == today) {
      isDisable = false;
    }

    return isDisable;
  }

  @override
  Widget build(BuildContext context) {
    habitName = int.parse(widget.todayCount);
    days = int.parse(widget.today);
    streak = int.parse(widget.streak);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/user_bg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return EditUser(
                                    index: widget.index,
                                    id: DateTime.now().millisecond.toString(),
                                    habitName: widget.habitName,
                                    totalDays: widget.totalDays,
                                    wheelCount: widget.wheelCount,
                                    wheelName: widget.wheelName,
                                    name: widget.todayCount,
                                    today: widget.today,
                                    percentage: widget.streak,
                                    week: widget.week,
                                    doItAt: widget.doItAt,
                                    date: widget.date,
                                  );
                                }),
                              );
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            )),
                        PopupMenuButton<SampleItem>(
                          color: Colors.white,
                          initialValue: selectedMenu,
                          onSelected: (SampleItem item) {
                            setState(() {
                              selectedMenu = item;
                              if (item == SampleItem.itemOne) {
                                reset();
                              }
                              if (item == SampleItem.itemTwo) {
                                popupDialogueBox(widget.index);
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SampleItem>>[
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.itemOne,
                              child: Text('Reset'),
                            ),
                            const PopupMenuItem<SampleItem>(
                              value: SampleItem.itemTwo,
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white30,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Text(
                                widget.habitName,
                                style: GoogleFonts.unbounded(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13, top: 8),
                          child: Row(
                            children: [
                              Card(
                                color: Colors.deepPurple,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.doItAt,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.deepPurple,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      widget.week.length == 7
                                          ? "EVERYDAY"
                                          : "${widget.week.length} DAYS",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.wheelName} \nFINISHED',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ValueListenableBuilder<int>(
                                        valueListenable: habitNameNotifier,
                                        builder: (BuildContext context,
                                            int value, Widget? child) {
                                          return Text(
                                            habitName.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 30,
                                            ),
                                          );
                                        },
                                      ),
                                      Text(
                                        'TOTAL ${widget.wheelName} : ${widget.wheelCount}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade700,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'DAYS \nFINISHED',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ValueListenableBuilder<int>(
                                        valueListenable: daysNotifier,
                                        builder: (BuildContext context,
                                            int count, Widget? child) {
                                          return Text(
                                            days.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 30,
                                            ),
                                          );
                                        },
                                      ),
                                      Text(
                                        'TOTAL DAYS : ${widget.totalDays}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade400,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'CURRENT \nSTREAK',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      ValueListenableBuilder<int>(
                                        valueListenable: streakNotifier,
                                        builder: (BuildContext context,
                                            int count, Widget? child) {
                                          return Text(
                                            streak.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 30,
                                            ),
                                          );
                                        },
                                      ),
                                      Text(
                                        'BEST STREAK : ${widget.streak}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (disableButtons())
                          if (shouldShowButtons(widget.week))
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: SliderButton(
                                      backgroundColor: Colors.greenAccent,
                                      buttonColor: Colors.greenAccent.shade700,
                                      buttonSize: 50,
                                      action: () {
                                        incrementCounterBasedOnDay();
                                        incrementTodayWheelCount();
                                        if (daysNotifier.value.toString() ==
                                            widget.totalDays) {
                                          addCountToModel();
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'lib/assets/videos/habit_completed.gif'),
                                                    Text(
                                                      'YOU HAVE COMPLETED \n             YOUR HABIT',
                                                      style:
                                                          GoogleFonts.andadaPro(
                                                        color: Colors
                                                            .blue.shade900,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ElevatedButton(
                                                          child: const Text(
                                                              'GO TO HOME'),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                              return const HomeScreen();
                                                            }),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          child: const Text(
                                                              'RESTART'),
                                                          onPressed: () =>
                                                              restart(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Image.asset(
                                                        'lib/assets/videos/done.gif'),
                                                    Text(
                                                      'YOU HAVE COMPLETED \n    SCHEDULED TASKS',
                                                      style:
                                                          GoogleFonts.andadaPro(
                                                        color: Colors
                                                            .blue.shade900,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      child: const Text(
                                                          'GO TO HOME'),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                          return const HomeScreen();
                                                        }),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      label: const Text(
                                        "Swipe to complete",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                      boxShadow: BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 10.0,
                                        offset: const Offset(8, 5),
                                      ),
                                      icon: Icon(
                                        Icons.check_rounded,
                                        color: Colors.green.shade50,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      incrementCounterBasedOnDay();
                                      incrementTodayCount();
                                      if (daysNotifier.value.toString() ==
                                          widget.totalDays) {
                                        addCountToModel();
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                      'lib/assets/videos/habit_completed.gif'),
                                                  Text(
                                                    'YOU HAVE COMPLETED \n             YOUR HABIT',
                                                    style:
                                                        GoogleFonts.andadaPro(
                                                      color:
                                                          Colors.blue.shade900,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                        child: const Text(
                                                            'GO TO HOME'),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                            return const HomeScreen();
                                                          }),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                          child: const Text(
                                                              'RESTART'),
                                                          onPressed: () =>
                                                              restart()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                      'lib/assets/videos/trophy.gif'),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'YOU HAVE COMPLETED',
                                                        style: GoogleFonts
                                                            .andadaPro(
                                                          color: Colors
                                                              .blue.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        'A DAY',
                                                        style: GoogleFonts
                                                            .andadaPro(
                                                          color: Colors
                                                              .blue.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text(
                                                        'GO TO HOME'),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                        return const HomeScreen();
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.done_all,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      '|   FINISH ALL',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return const TimerSreen();
                                      }),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.timer_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'TIMER',
                                  style: GoogleFonts.unbounded(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return const StopWatchScreen();
                                      }),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.alarm,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'STOP WATCH',
                                  style: GoogleFonts.unbounded(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return AnalysisScreen(
                                          date: widget.date,
                                          completedDays:
                                              daysNotifier.value.toString(),
                                          completedHours: habitNameNotifier
                                              .value
                                              .toString(),
                                          totalCount: widget.wheelCount,
                                          totalDays: widget.totalDays,
                                          categoryname: widget.wheelName,
                                        );
                                      }),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.bar_chart,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'HISTORY',
                                  style: GoogleFonts.unbounded(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> reset() async {
    int todayCount = 0;
    int today = 0;
    int streak = 0;
    updateList(
      widget.index,
      StartModel(
          id: DateTime.now().millisecond.toString(),
          days: widget.totalDays,
          habit: widget.habitName,
          wheelCount: widget.wheelCount,
          wheelName: widget.wheelName,
          todayHours: todayCount.toString(),
          today: today.toString(),
          streak: streak.toString(),
          doitAt: widget.doItAt,
          week: widget.week,
          date: widget.date),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }),
    );
  }

  void incrementTodayWheelCount() {
    setState(() {
      habitNameNotifier.value = (habitName ?? 0) + 1;

      if (habitNameNotifier.value.toString() == widget.wheelCount) {
        daysNotifier.value = (days ?? 0) + 1;
        streakNotifier.value = (streak ?? 0) + 1;

        if (daysNotifier.value.toString() == widget.totalDays) {
          deleteData(widget.index);
        } else {
          updateList(
            widget.index,
            StartModel(
                id: DateTime.now().millisecond.toString(),
                days: widget.totalDays,
                habit: widget.habitName,
                wheelCount: widget.wheelCount,
                wheelName: widget.wheelName,
                todayHours: habitNameNotifier.value.toString(),
                today: daysNotifier.value.toString(),
                streak: streakNotifier.value.toString(),
                doitAt: widget.doItAt,
                week: widget.week,
                date: widget.date),
          );
        }
      } else {
        updateList(
          widget.index,
          StartModel(
              id: DateTime.now().millisecond.toString(),
              days: widget.totalDays,
              habit: widget.habitName,
              wheelCount: widget.wheelCount,
              wheelName: widget.wheelName,
              todayHours: habitNameNotifier.value.toString(),
              today: daysNotifier.value.toString(),
              streak: streakNotifier.value.toString(),
              doitAt: widget.doItAt,
              week: widget.week,
              date: widget.date),
        );
      }
    });
  }

  void incrementTodayCount() {
    setState(() {
      habitNameNotifier.value = 0;
      daysNotifier.value = (days ?? 0) + 1;
      streakNotifier.value = (streak ?? 0) + 1;

      if (daysNotifier.value.toString() == widget.totalDays) {
        deleteData(widget.index);
      } else {
        updateList(
          widget.index,
          StartModel(
              id: DateTime.now().millisecond.toString(),
              days: widget.totalDays,
              habit: widget.habitName,
              wheelCount: widget.wheelCount,
              wheelName: widget.wheelName,
              todayHours: habitNameNotifier.value.toString(),
              today: daysNotifier.value.toString(),
              streak: streakNotifier.value.toString(),
              doitAt: widget.doItAt,
              week: widget.week,
              date: widget.date),
        );
      }
    });
  }

  popupDialogueBox(int indexValue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Do you want to delete this entry?"),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
              onPressed: () {
                deleteData(indexValue);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }),
                );
              },
              child: const Text("YES"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("NO"),
            ),
          ],
        );
      },
    );
  }

  Future<void> restart() async {
    habitNameNotifier.value = 0;
    daysNotifier.value = 0;
    streakNotifier.value = 0;

    final startObject = StartModel(
        id: DateTime.now().millisecond.toString(),
        habit: widget.habitName,
        days: widget.totalDays,
        wheelCount: widget.wheelCount.toString(),
        wheelName: widget.wheelName,
        todayHours: habitNameNotifier.value.toString(),
        today: daysNotifier.value.toString(),
        streak: streakNotifier.value.toString(),
        week: widget.week,
        doitAt: widget.doItAt,
        date: widget.date);

    print(
        "${widget.habitName} ${widget.totalDays}  ${widget.wheelCount} ${widget.wheelName}");

    addCategory(startObject);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }),
    );
  }

  void addCountToModel() {
    print(completed);
    int countHabit = completed + 1;

    final habtCounts = HabitsCountModel(
        id: DateTime.now().millisecond.toString(),
        totalHabitCompleted: countHabit);
    HabitCountsDB().addCounts(habtCounts);
  }

  void incrementCounterBasedOnDay() {
    String currentDayOfWeek = DateFormat('EEEE').format(DateTime.now());

    setState(() {
      switch (currentDayOfWeek) {
        case 'Monday':
          monday += 1;
          final analysisObject = AnalysisModel(
              id: DateTime.now().millisecond,
              monday: monday,
              tuesday: tuesday,
              wednesday: wednesday,
              thursday: thursday,
              friday: friday,
              saturday: saturday,
              sunday: sunday);
          AnalysisDB().addanalysData(analysisObject);
          break;
        case 'Tuesday':
          tuesday += 1;
          final analysisObject = AnalysisModel(
              id: DateTime.now().millisecond,
              monday: monday,
              tuesday: tuesday,
              wednesday: wednesday,
              thursday: thursday,
              friday: friday,
              saturday: saturday,
              sunday: sunday);
          AnalysisDB().addanalysData(analysisObject);
          break;
        case 'Wednesday':
          wednesday += 1;

          final analysisObject = AnalysisModel(
              id: DateTime.now().millisecond,
              monday: monday,
              tuesday: tuesday,
              wednesday: wednesday,
              thursday: thursday,
              friday: friday,
              saturday: saturday,
              sunday: sunday);

          AnalysisDB().addanalysData(analysisObject);

          break;
        case 'Thursday':
          thursday += 1;
          final analysisObject = AnalysisModel(
              id: DateTime.now().millisecond,
              monday: monday,
              tuesday: tuesday,
              wednesday: wednesday,
              thursday: thursday,
              friday: friday,
              saturday: saturday,
              sunday: sunday);
          AnalysisDB().addanalysData(analysisObject);
          break;
        case 'Friday':
          friday += 1;
          final analysisObject = AnalysisModel(
              id: DateTime.now().millisecond,
              monday: monday,
              tuesday: tuesday,
              wednesday: wednesday,
              thursday: thursday,
              friday: friday,
              saturday: saturday,
              sunday: sunday);
          AnalysisDB().addanalysData(analysisObject);
          break;
        case 'Saturday':
          saturday += 1;
          final analysisObject = AnalysisModel(
              id: DateTime.now().millisecond,
              monday: monday,
              tuesday: tuesday,
              wednesday: wednesday,
              thursday: thursday,
              friday: friday,
              saturday: saturday,
              sunday: sunday);
          AnalysisDB().addanalysData(analysisObject);
          break;
        case 'Sunday':
          sunday += 1;
          final analysisObject = AnalysisModel(
              id: DateTime.now().millisecond,
              monday: monday,
              tuesday: tuesday,
              wednesday: wednesday,
              thursday: thursday,
              friday: friday,
              saturday: saturday,
              sunday: sunday);
          AnalysisDB().addanalysData(analysisObject);
          break;
        default:
          break;
      }
    });
  }
}

enum SampleItem { itemOne, itemTwo }
