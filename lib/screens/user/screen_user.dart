import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import '../../functions/hive_functions/db_start.dart';
import '../screen_home.dart';
import 'edit_user.dart';

class ScreenUser extends StatefulWidget {
  final int index;
  final String id;
  final String habitName;
  final String totalDays;
  final String wheelCount;
  final String wheelName;
  const ScreenUser(
      {super.key,
      required this.habitName,
      required this.totalDays,
      required this.wheelCount,
      required this.wheelName,
      required this.index,
      required this.id});

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  SampleItem? selectedMenu;
  int todayWheelCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/bg-user_interface.png"),
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
                                  return  EditUser( 
                                    index: widget.index,
                                    id:  DateTime.now().millisecond.toString(),
                                    habitName: widget.habitName,
                                    totalDays: widget.totalDays,
                                    wheelCount: widget.wheelCount,
                                    wheelName: widget.wheelName,
                                  );
                                }), 
                              );
                            },
                            icon: Icon(Icons.edit_outlined)),
                        PopupMenuButton<SampleItem>(
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
                  decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: const BorderRadius.only(
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
                                  color: Colors.indigo,
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
                                      Text(
                                        '$todayWheelCount',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 30),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DAYS \nFINISHED',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 30),
                                      ),
                                      Text(
                                        'TOTAL DAYS : 10',
                                        style: TextStyle(
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
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'COMPLETION \nRATE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Text(
                                        '20%',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 30),
                                      ),
                                      Text(
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
      todayWheelCount++;
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
