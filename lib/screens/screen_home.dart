import 'package:flutter/material.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_categories.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_newcategory.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_today.dart';
import 'bottom_navigation.dart/widget_me.dart';
import 'package:calendar_appbar/calendar_appbar.dart';


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
    return Scaffold(
      appBar: _selectedIndex == 0
          ? CalendarAppBar(
              onDateChanged: (value) => print(value),
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
              accent: Colors.indigo.shade400,
              backButton: false,
            )
          : null,
      extendBodyBehindAppBar: mounted, 
    
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.93,   
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/background_new.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'TODAY',
           backgroundColor:Colors.indigo.shade400,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.assignment_outlined,color: Colors.white,), 
          label: 'CATEGORIES',
           backgroundColor:Colors.indigo.shade400, 
        ),
        
        BottomNavigationBarItem( 
          icon: const Icon(Icons.add_circle_outline_outlined),
          label: 'CREATE',
           backgroundColor: Colors.indigo.shade400,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_2_outlined),
          label: 'ME',
           backgroundColor: Colors.indigo.shade400,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
      
    ), 
    );
  }
}
