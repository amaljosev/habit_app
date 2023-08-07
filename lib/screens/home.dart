import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_newcategory.dart';

import 'bottom_navigation.dart/journey_screen.dart';
import 'bottom_navigation.dart/widget_categories.dart';
import 'bottom_navigation.dart/widget_today.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int page = 0;
  static const List<Widget> widgetOptions = [
    TodayWidget(),
    CategoryWidget(),
    StartWidget(),
    JourneyPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      page = index;
    });
  }

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 11, 53, 107),  
      appBar: page == 0
          ? CalendarAppBar(
              onDateChanged: (value) => print(value),
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
              accent: const Color.fromARGB(202, 18, 63, 114),    
              backButton: false,
            )
          : null,
      extendBodyBehindAppBar: mounted,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,   
          decoration: const BoxDecoration(
            image: DecorationImage( 
              image: AssetImage("lib/assets/images/home_bg.jpg"), 
              fit: BoxFit.fill,
            ),
          ),
          child: widgetOptions.elementAt(page),   
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: const [
          Icon(Icons.home, color:   Color.fromARGB(202, 18, 63, 114), size: 35),  
          Icon(Icons.assignment_rounded, color:  Color.fromARGB(202, 18, 63, 114), size: 35),
          Icon(Icons.add, color: Color.fromARGB(202, 18, 63, 114), size: 35),
          Icon(Icons.bar_chart, color: Color.fromARGB(202, 18, 63, 114), size: 35),    
        ],
        color:Colors.white   ,
        backgroundColor: Colors.black12,  
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 900),
        buttonBackgroundColor:  Colors.white,    
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true, 
      ),
    );
  }
}
