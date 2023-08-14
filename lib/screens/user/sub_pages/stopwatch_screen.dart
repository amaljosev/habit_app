import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  int seconds = 0, minutes = 0, hours = 0;
  String digiSeconds = '00', digiMinuts = '00', digiHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];
// Creating stop timer
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

//reset
  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digiSeconds = '00';
      digiMinuts = '00';
      digiHours = '00';

      started = false;
    });
  }

  void addLaps() {
    String lap = "$digiHours:$digiMinuts:$digiSeconds";
    setState(() {
      laps.add(lap);
    });
  }

//start
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;
      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digiSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digiMinuts = (minutes >= 10) ? "$minutes" : "0$minutes";
        digiHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/new_home.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
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
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: Text(
                        '$digiHours:$digiMinuts:$digiSeconds',
                        style:
                            const TextStyle(fontSize: 80, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lap no:${index + 1}',
                                    style: const TextStyle(
                                        color: Colors.indigo, fontSize: 16),
                                  ),
                                  Text(
                                    '${laps[index]}',
                                    style: const TextStyle(
                                        color: Colors.indigo, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade50, 
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),
                          onPressed: () {
                            (!started ? start() : stop());
                          },
                          child: Text(
                            (!started ? 'START' : 'PAUSE'),
                            style: const TextStyle(color: Colors.black), 
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            addLaps();
                          },
                          icon:  Card(
                            color: Colors.indigo.shade50, 
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.flag,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo.shade50,
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),
                          onPressed: () {
                            reset();
                          },
                          child: const Text(
                            'STOP',
                            style: TextStyle(color: Colors.black), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }
}
