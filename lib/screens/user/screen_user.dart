import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/screens/user/sub_pages/analysis_screen.dart';
import 'package:habit_project/screens/user/sub_pages/screen_timer.dart';
import 'package:habit_project/screens/user/sub_pages/stopwatch_screen.dart';
import 'package:intl/intl.dart';
import 'package:slider_button/slider_button.dart';
import '../../functions/hive_functions/db_analysis.dart';
import '../../functions/hive_functions/db_count.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../models/sign_up/db_model.dart';
import '../home.dart';
import 'edit_user.dart';

ValueNotifier<int> habitNameNotifier = ValueNotifier<int>(habitName ?? 0);
ValueNotifier<int> daysNotifier = ValueNotifier<int>(days ?? 0);
ValueNotifier<int> streakNotifier = ValueNotifier<int>(streak ?? 0);
int? habitName = 0;
int? days = 0;
int? streak = 0;
bool isDisable = true;

double monday = 0.0;
double tuesday = 0.0;
double wednesday = 0.0;
double thursday = 0.0;
double friday = 0.0;
double saturday = 0.0;
double sunday = 0.0;

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
  final DateTime lastDoneDate;

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
    required this.lastDoneDate,
  });

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  int completed = 0;
  List analysisList = [];

  DateTime lastDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await checkAndResetHabit();
    await fetchAnalysisData();
    await fetchCount();
  }

  Future<void> checkAndResetHabit() async {
    await resetNotifiers();
    lastDate = widget.lastDoneDate;

    DateTime currentDate = DateTime.now();


    if (lastDate.day != currentDate.day) {
      habitNameNotifier.value = 0;

      setState(
        () {
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
                date: widget.date,
                dateLastDone: currentDate),
          );

          getallDatas();
        },
      );
      if (isOneDayOrMoreDifference(lastDate, currentDate)) {
        streakNotifier.value = 0;
        setState(
          () {
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
                  date: widget.date,
                  dateLastDone: currentDate),
            );
            getallDatas();
          },
        );
      }
    }
  }

  bool isOneDayOrMoreDifference(DateTime lastDate, DateTime currentDate) {
    // Get the date components (day, month, year) for both dates
    int lastDay = lastDate.day;
    int currentDay = currentDate.day;

    int lastMonth = lastDate.month;
    int currentMonth = currentDate.month;

    int lastYear = lastDate.year;
    int currentYear = currentDate.year;

    // Check if the year and month are the same
    if (lastYear == currentYear && lastMonth == currentMonth) {
      // Check if the difference between the days is 1 or more
      return (currentDay - lastDay) > 1;
    }

    // Check if the dates are 1 month apart or more
    if ((currentYear == lastYear && currentMonth - lastMonth >= 1) ||
        (currentYear - lastYear == 1 && currentMonth == 1 && lastMonth == 12)) {
      // Check if the last date is the last day of the month and the current date is the first day of the month
      bool isLastDayOfMonth =
          (lastDate.day == DateTime(lastYear, lastMonth + 1, 0).day);
      bool isFirstDayOfMonth = (currentDate.day == 1);
      return isLastDayOfMonth && isFirstDayOfMonth;
    }

    return false;
  }

  Future<void> fetchCount() async {
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

  Future<void> fetchAnalysisData() async {
    final db = AnalysisDB();
    final dataList = await db.getAllanalysData();
    analysisList = dataList;
    if (dataList.isNotEmpty) {
      setState(
        () {
          monday = dataList.last.monday;
          tuesday = dataList.last.tuesday;
          wednesday = dataList.last.wednesday;
          thursday = dataList.last.thursday;
          friday = dataList.last.friday;
          saturday = dataList.last.saturday;
          sunday = dataList.last.sunday;
        },
      );
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
    String todayCount = habitName.toString();
    String today = widget.wheelCount;
    isDisable = true;
 
    if (todayCount == today) { 
      isDisable = false;
    } 

    return isDisable; 
  }

  Future<void> resetNotifiers() async {
    await getallDatas();
    habitName = int.parse(widget.todayCount);
    days = int.parse(widget.today);
    streak = int.parse(widget.streak);
    habitNameNotifier.value = int.parse(widget.todayCount);
    daysNotifier.value = int.parse(widget.today);
    streakNotifier.value = int.parse(widget.streak);
  }

  @override
  Widget build(BuildContext context) {
    resetNotifiers();
    return Scaffold(
      body: SingleChildScrollView( 
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/new_home.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Card(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
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
                                        lastDoneDate: widget.lastDoneDate,
                                      );
                                    }),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                )),
                          ),
                          Card(
                            child: PopupMenuButton<SampleItem>(
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
                                  child: Text('Reset',
                                      style: TextStyle(color: Colors.black)),
                                ),
                                const PopupMenuItem<SampleItem>(
                                  value: SampleItem.itemTwo,
                                  child: Text('Delete',
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
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
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 20, left: 20),
                                    child: Text(
                                      widget.habitName,
                                      style: GoogleFonts.unbounded(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
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
                                      color: Colors.indigo.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.doItAt,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.indigo.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            widget.week.length == 7
                                                ? "EVERYDAY"
                                                : "${widget.week.length} DAYS",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Card(
                                      color: Colors.indigo.shade50,
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
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            ValueListenableBuilder<int>(
                                              valueListenable: habitNameNotifier,
                                              builder: (BuildContext context,
                                                  int value, Widget? child) {
                                                return Text(
                                                  habitName.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30,
                                                  ),
                                                );
                                              },
                                            ),
                                            Text(
                                              'TOTAL ${widget.wheelName} : ${widget.wheelCount}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.indigo.shade50,
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
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            ValueListenableBuilder<int>(
                                              valueListenable: daysNotifier,
                                              builder: (BuildContext context,
                                                  int count, Widget? child) {
                                                return Text(
                                                  days.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30,
                                                  ),
                                                );
                                              },
                                            ),
                                            Text(
                                              'TOTAL DAYS : ${widget.totalDays}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 9),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.indigo.shade50,
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
                                                  color: Colors.black,
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
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30,
                                                  ),
                                                );
                                              },
                                            ),
                                            Text(
                                              'BEST STREAK : ${widget.streak}',
                                              style: const TextStyle(
                                                  color: Colors.black,
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
                                            backgroundColor:
                                                Colors.indigo.shade100,
                                            buttonColor: Colors.indigo,
                                            buttonSize: 50,
                                            action: () {
                                              incrementTodayWheelCount();
                                              if (daysNotifier.value.toString() ==
                                                  widget.totalDays) {
                                                addCountToModel();
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Image.asset(
                                                              'lib/assets/videos/habit_completed.gif'),
                                                          Text(
                                                            'YOU HAVE COMPLETED \n             YOUR HABIT',
                                                            style: GoogleFonts
                                                                .andadaPro(
                                                              color:
                                                                  Colors.indigo,
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
                                                                    return const Home();
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
                                                  backgroundColor: Colors.white,
                                                );
                                              } else {
                                                showModalBottomSheet<void>(
                                                  backgroundColor: Colors.white,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Image.asset(
                                                                'lib/assets/videos/completed.gif'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'YOU HAVE COMPLETED \n    SCHEDULED TASKS',
                                                              style: GoogleFonts
                                                                  .andadaPro(
                                                                color: Colors.blue
                                                                    .shade900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
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
                                                                return const Home();
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
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              blurRadius: 10.0,
                                              offset: const Offset(8, 5),
                                            ),
                                            icon: Icon(
                                              Icons.check_rounded,
                                              color: Colors.green.shade50,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
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
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Image.asset(
                                                            'lib/assets/videos/habit_completed.gif'),
                                                        Text(
                                                          'YOU HAVE COMPLETED \n             YOUR HABIT',
                                                          style: GoogleFonts
                                                              .andadaPro(
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
                                                                  return const Home();
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
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Image.asset(
                                                            'lib/assets/videos/trophy.gif'),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              'YOU HAVE COMPLETED',
                                                              style: GoogleFonts
                                                                  .andadaPro(
                                                                color: Colors.blue
                                                                    .shade900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              'A DAY',
                                                              style: GoogleFonts
                                                                  .andadaPro(
                                                                color: Colors.blue
                                                                    .shade900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
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
                                                              return const Home();
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
                                            color: Colors.black,
                                          ),
                                          label: const Text(
                                            '|   FINISH ALL',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.indigo.shade50,
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
                                          backgroundColor: Colors.indigo.shade50,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                              return const TimerSreen();
                                            }),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.timer_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'TIMER',
                                        style: GoogleFonts.unbounded(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.indigo.shade50,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                              return const StopWatchScreen();
                                            }),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.alarm,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'STOP WATCH',
                                        style: GoogleFonts.unbounded(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.indigo.shade50,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
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
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'HISTORY',
                                        style: GoogleFonts.unbounded(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Colors.black,
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
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> reset() async {
    habitNameNotifier.value = 0;
    daysNotifier.value = 0;
    streakNotifier.value = 0;
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
          date: widget.date,
          dateLastDone: widget.lastDoneDate),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return const Home();
      }),
    );
  }

  void incrementTodayWheelCount() {
    setState(() {
      habitNameNotifier.value = (habitName ?? 0) + 1;

      if (habitNameNotifier.value.toString() == widget.wheelCount) {
        incrementCounterBasedOnDay();
        daysNotifier.value = (days ?? 0) + 1;
        streakNotifier.value = (streak ?? 0) + 1;
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
              date: widget.date,
              dateLastDone: widget.lastDoneDate),
        );
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
                date: widget.date,
                dateLastDone: widget.lastDoneDate),
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
              date: widget.date,
              dateLastDone: widget.lastDoneDate),
        );
      }
    });
  }

  void incrementTodayCount() {
    setState(() {
      habitNameNotifier.value = int.parse(widget.wheelCount);
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
              date: widget.date,
              dateLastDone: widget.lastDoneDate),
        );
      }
    });
  }

  popupDialogueBox(int indexValue) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Do you want to delete this habit?"),
          title: Card(
              color: Colors.indigo.shade50,
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("DELETE HABIT"),
              ))),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w900, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  )),
              onPressed: () {
                deleteData(indexValue);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return const Home();
                  }),
                );
              },
              child:
                  const Text("DELETE", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("GO BACK"),
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
        date: widget.date,
        dateLastDone: widget.lastDoneDate);



    addCategory(startObject);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return const Home();
      }),
    );
  }

  void addCountToModel() {
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
