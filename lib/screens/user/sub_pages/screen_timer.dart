import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class TimerSreen extends StatefulWidget {
  const TimerSreen({super.key});

  @override
  State<TimerSreen> createState() => _TimerSreenState();
}

final CountDownController _controller = CountDownController();

class _TimerSreenState extends State<TimerSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Column(
        children: [
          CircularCountDownTimer(
            duration: 10,
            initialDuration: 0,
            controller: _controller,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            ringColor: Colors.grey[300]!,
            ringGradient: null,
            fillColor: Colors.purpleAccent[100]!,
            fillGradient: null,
            backgroundColor: Colors.purple[500],
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            isReverse: false,
            isReverseAnimation: false,
            isTimerTextShown: true,
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
            timeFormatterFunction: (defaultFormatterFunction, duration) {
              if (duration.inSeconds == 0) {
                return "Start";
              } else {
                return Function.apply(defaultFormatterFunction, [duration]);
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.start();
                },
                child: Text("Start"),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.pause();
                },
                child: Text("Pause"),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.resume();
                },
                child: Text("Resume"),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.restart();
                },
                child: Text("Restart"), 
              ),
            ],
          ),
        ],
      ),
    );
  }
}
