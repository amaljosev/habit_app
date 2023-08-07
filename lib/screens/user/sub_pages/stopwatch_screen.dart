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
            image: AssetImage("lib/assets/images/stop_watch_bg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, 
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55), 
              child: Text(
                '$digiHours:$digiMinuts:$digiSeconds',
                style:
                    TextStyle(fontSize: 80, color: Colors.blueAccent.shade100),
              ),
            ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                            children: [
                              Text(
                                'Lap no:${index + 1}',
                                style: TextStyle(
                                    color: Colors.blue.shade800, fontSize: 16),
                              ),
                              Text(
                                '${laps[index]}',
                                style: TextStyle(
                                    color: Colors.blue.shade800, fontSize: 16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      (!started ? start() : stop());
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (!started ? 'START' : 'PAUSE'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      addLaps();
                    },
                    icon: const Icon(
                      Icons.flag,
                      color: Colors.white,
                    )),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: const Text(
                      'STOP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
