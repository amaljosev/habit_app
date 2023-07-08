import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_categories.dart';

import '../../functions/hive_functions/db_addNew.dart';

class StartWidget extends StatefulWidget {
  const StartWidget({super.key});

  @override
  State<StartWidget> createState() => _StartWidgetState();
}
final TextEditingController _habitController = TextEditingController();
final TextEditingController _daysController = TextEditingController();
final _formKey = GlobalKey<FormState>();

var data;
class _StartWidgetState extends State<StartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child:  Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text('START A HABIT',
                        style: GoogleFonts.unbounded(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _habitController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 62, 51, 51),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Name',
                      labelText: 'Habit Name', 
                      labelStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(
                        Icons.alarm_on_sharp,
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Habit Name is empty!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _daysController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 62, 51, 51),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Days',
                      labelText: 'Duration',
                      labelStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Duration empty!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'DO IT AT',
                          style: GoogleFonts.unbounded(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 80, 37, 89)),
                          onPressed: () {
                            data = 'Morning';
                            print(data);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.sunny,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Morninig  ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 80, 37, 89)),
                          onPressed: () {
                            data = 'Afternoon';
                            print(data);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.wb_sunny_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Afternoon',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 80, 37, 89)),
                          onPressed: () {
                            data = 'Evening';
                            print(data);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.nightlight,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Evening     ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 80, 37, 89)),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_sharp,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Anytime    ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addDataToModel();
                            } else {
                              print("Empty");
                            }
                          },
                          child: const Text(
                            'START',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ), 
    );
  }
  Future<void> addDataToModel() async {
    final _days = _daysController.text.trim();
    final _habit = _habitController.text.trim();

    if (_days.isEmpty || _habit.isEmpty) {
      return;
    } else {
      _daysController.text = '';
      _habitController.text = '';
      setState(() {
        popDialogueBox();
      });
    }

    final addObject =AddModel(id: DateTime.now().millisecond,days:_days,name: _habit );

    print(" $_days $_habit ");

     addNew(addObject);
  }

  popDialogueBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Completed"),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[400],
                fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const CategoryWidget();
                    }));
                  },
                  child: const Text("Home")),
            ],
            content: Text(
              "Saved successfully",
              style: TextStyle(color: Colors.green[400]),
            ),
          );
        });
  }
}
