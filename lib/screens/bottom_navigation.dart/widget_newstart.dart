import 'package:flutter/material.dart';


class StartWidget extends StatefulWidget {
  const StartWidget({Key? key}) : super(key: key);

  @override
  State<StartWidget> createState() => _StartWidgetState();
}

final TextEditingController _habitController = TextEditingController();
final TextEditingController _daysController = TextEditingController();


var data;

class _StartWidgetState extends State<StartWidget> {
  final List<bool> selectedWeekdays = List.filled(7, true);
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('new')),); 
  }

}
