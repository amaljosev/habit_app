import 'package:flutter/material.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_categories.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_newstart.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_today.dart';
import 'bottom_navigation.dart/widget_me.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  
  static const List<Widget> _widgetOptions = [
    TodayWidget(),
    CategoryWidget(),
    StartWidget(), 
    MeWdget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.9,   
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/images/Home.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'TODAY',
             backgroundColor:  Color.fromRGBO(80, 37, 89, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'CATEGORIES',
             backgroundColor:  Color.fromARGB(255, 80, 37, 89),
          ),
          
          BottomNavigationBarItem( 
            icon: Icon(Icons.add_box_sharp),
            label: 'NEW START',
             backgroundColor:  Color.fromARGB(255, 80, 37, 89),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ME',
             backgroundColor:  Color.fromARGB(255, 80, 37, 89),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        
      ), 
      ),
    );
  }
}
