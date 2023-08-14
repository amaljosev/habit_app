import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class TimerSreen extends StatefulWidget {
  const TimerSreen({super.key});

  @override
  State<TimerSreen> createState() => _TimerSreenState();
}

class _TimerSreenState extends State<TimerSreen> {
  final CountDownController _controller = CountDownController();
  final TextEditingController textEditingController = TextEditingController();
  int timerDuration = 600; // 10 minutes in seconds
  int defaultValue = 10; // 1 minute in minutes
  int maxValue = 60; // Maximum value in minutes

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(onTimerDurationChanged);
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                  ),
                  Column(
                    children: [
                      CircularCountDownTimer(
                        duration: timerDuration,
                        initialDuration: 0,
                        controller: _controller,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        ringColor: Colors.yellow.shade200,
                        ringGradient: null,
                        fillColor: Colors.white,
                        fillGradient: null,

                        backgroundGradient: null,
                        strokeWidth: 20.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                          fontSize: 33.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textFormat: CountdownTextFormat
                            .MM_SS, // Format the timer in minutes and seconds
                        isReverse:
                            true, // Set to true to make the timer count down
                        isReverseAnimation: false,

                        autoStart: false,
                        onStart: () {
                          debugPrint('Countdown Started');
                        },
                        onComplete: () {
                          debugPrint('Countdown Ended');
                        },
                        onChange: (String timeStamp) {
                          debugPrint('Countdown Changed $timeStamp');
                        },
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {
                            return "10 min";
                          } else {
                            // Format the duration to minutes and seconds
                            String minutes = (duration.inMinutes % 60)
                                .toString()
                                .padLeft(2, '0');
                            String seconds = (duration.inSeconds % 60)
                                .toString()
                                .padLeft(2, '0');
                            return "$minutes:$seconds";
                          }
                        },
                        isTimerTextShown: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                           
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  controller: textEditingController,
                                  keyboardType: TextInputType.number,
                                  decoration:  const InputDecoration(
                                     focusedBorder: InputBorder.none, 
                                    filled: true,
                                    fillColor: Colors.black12, 
                                    border: OutlineInputBorder(  
                                      borderSide: BorderSide.none, 
                                        borderRadius: BorderRadius.all(
                                          
                                            Radius.circular(20))),
                                    labelText: 'Enter Time Limit in Minutes',
                                    labelStyle:
                                        TextStyle(color: Colors.grey),  
                                    prefixIcon: Icon(
                                      Icons.alarm,
                                      color: Colors.grey, 
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const CircleBorder(),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(80, 80)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.yellow.shade200),
                                    ),
                                    onPressed: () {
                                      startTimer();
                                    },
                                    child: const Text("Start"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.yellow.shade200),
                                      ),
                                      onPressed: () {
                                        _controller.pause();
                                      },
                                      child: const Text("Pause"),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.yellow.shade200),
                                      ),
                                      onPressed: () {
                                        _controller.resume();
                                      },
                                      child: const Text("Resume"),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.yellow.shade200),
                                      ),
                                      onPressed: () {
                                        resetTimer();
                                      },
                                      child: const Text("Restart"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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

  void onTimerDurationChanged() {
    setState(() {
      int timerDurationInMinutes =
          int.tryParse(textEditingController.text) ?? 0;
      timerDuration = timerDurationInMinutes * 60;
    });
  }

  void startTimer() {
    int enteredDuration = int.tryParse(textEditingController.text) ?? 0;
    if (enteredDuration > maxValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Entered value exceeds the maximum limit of $maxValue minutes.'),
          duration: const Duration(seconds: 3),
        ),
      );
      return; // Do not start the timer if the value is too big
    }

    int durationToStart =
        enteredDuration > 0 ? enteredDuration * 60 : defaultValue * 60;
    _controller.restart(duration: durationToStart);
    textEditingController.text = '';
  }

  void checkEnteredValue() {
    int enteredValue = int.tryParse(textEditingController.text) ?? 0;
    if (enteredValue > maxValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Entered value exceeds the maximum limit of $maxValue minutes.'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void resetTimer() {
    setState(() {
      timerDuration = 0;
      _controller.reset();
    });
  }
}
