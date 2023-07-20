import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../models/sign_up/db_model.dart';
import '../screen_home.dart';
import 'edit_user.dart';

ValueNotifier<int> habitNameNotifier = ValueNotifier<int>(habitName ?? 0);
int? habitName;

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
  });

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    habitName = int.parse(widget.todayCount);
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30))),
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
                          padding: const EdgeInsets.only(top: 20, bottom: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ValueListenableBuilder<int>(
                                        valueListenable: habitNameNotifier,
                                        builder: (BuildContext context,
                                            int value, Widget? child) {
                                          return Text(
                                           habitName.toString(),  
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 30,
                                            ),
                                          );
                                        },
                                      ),
                                      Text(
                                        'TOTAL ${widget.wheelName} : ${widget.wheelCount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child:  Padding(
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.today,  
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 30),
                                      ),
                                      Text(
                                        'TOTAL DAYS : ${widget.totalDays}', 
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child:  Padding( 
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Text(
                                       widget.streak, 
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 30),
                                      ),
                                      const Text(
                                        'TOTAL HABITS : 10',
                                        style: TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SliderButton(
                                  action: () {
                                    incrementTodayWheelCount();
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
                                                  'lib/assets/videos/tick.gif'),
                                              const Text(
                                                  'YOU HAVE COMPLETED \n    SCHEDULED TASKS'),
                                              ElevatedButton(
                                                child: const Text('GO TO HOME'),
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
                                  },
                                  label: const Text(
                                    "Swipe to complete",
                                    style: TextStyle(
                                      color: Color(0xff4a4a4a),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                  icon: const Icon(Icons.task_alt_outlined),
                                ),
                              ),
                              ElevatedButton.icon(
                                  onPressed: () {
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
                                              const Text(
                                                  'YOU HAVE COMPLETED \n             THIS DAY'),
                                              ElevatedButton(
                                                child: const Text('GO TO HOME'),
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
                                  },
                                  icon: const Icon(Icons.done_all),
                                  label: const Text('|   FINISH ALL')),
                              
                            ],
                          ),
                        ),
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

  void incrementTodayWheelCount() {
  setState(() {
    habitNameNotifier.value = (habitName ?? 0) + 1;
    
    if (habitNameNotifier.value.toString() == widget.wheelCount) {
      habitNameNotifier.value = 0;
      updateList( 
        widget.index,
        StartModel(
          days: widget.totalDays,
          habit: widget.habitName,
          id: DateTime.now().millisecond.toString(),
          todayHours: habitNameNotifier.value.toString(),
          wheelCount: widget.wheelCount,
          wheelName: widget.wheelName, 
          today: widget.today,
          streak: widget.streak,
        ), 
      );
    } else { 
      updateList(
        widget.index,
        StartModel(
          days: widget.totalDays,
          habit: widget.habitName,
          id: DateTime.now().millisecond.toString(),
          todayHours: habitNameNotifier.value.toString(),
          wheelCount: widget.wheelCount,
          wheelName: widget.wheelName,
          today: widget.today,
          streak: widget.streak
        ),
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
}

enum SampleItem { itemOne, itemTwo }
