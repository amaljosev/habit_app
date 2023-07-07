import 'package:flutter/material.dart';

class StartWidget extends StatefulWidget {
  const StartWidget({super.key});

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: const Center(
          child: Text(
        'Start',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
