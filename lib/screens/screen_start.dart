import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_project/models/sign_up/signup_model.dart';
import 'package:habit_project/screens/screen_home.dart';
import '../functions/hive_functions/db_start.dart';

class StartScreen extends StatefulWidget {
  
final String name;
const StartScreen({super.key,required this.name});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

final TextEditingController _daysController = TextEditingController();
final TextEditingController _hoursController = TextEditingController();
final _formKey = GlobalKey<FormState>();

var data;

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('lib/assets/images/Home.png'),
            fit: BoxFit.fill,
          )),
          child: Padding(
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
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 62, 51, 51),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Time',
                      labelText: 'Goal',
                      labelStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(
                        Icons.alarm_on_sharp,
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Goal is empty!';
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
        ),
      ),
    );
  }

  Future<void> addDataToModel() async {
    final _days = _daysController.text.trim();
    final _hours = _hoursController.text.trim();

    if (_days.isEmpty || _hours.isEmpty) {
      return;
    } else {
      _daysController.text = '';
      _hoursController.text = '';
      setState(() {
        popDialogueBox();
      });
    }

    final startObject = StartModel(
        id: DateTime.now().millisecond,
        habit: widget.name,
        days: _days,
        time: _hours);

    print("${widget.name} $_days $_hours ");

     addStudent(startObject);
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
                      return const HomeScreen();
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
