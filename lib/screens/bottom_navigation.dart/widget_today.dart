import 'package:flutter/material.dart';

class TodayWidget extends StatefulWidget {
  const TodayWidget({super.key});

  @override
  State<TodayWidget> createState() => _TodayWidgetState();
}

class _TodayWidgetState extends State<TodayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('home',style: TextStyle(color: Colors.white),)), 
    );
  }
}