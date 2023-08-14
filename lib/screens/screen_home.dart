import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_me.dart';
import 'package:habit_project/screens/bottom_navigation.dart/widget_newcategory.dart';
import 'package:table_calendar/table_calendar.dart';
import '../functions/hive_functions/db_functions.dart';
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
  String username = '';

  @override
  void initState() {
    super.initState();

    fetchUsername();
  }

  void fetchUsername() async {
    final db = SignUpDB();
    final dataList = await db.getDatas();
    if (dataList.isNotEmpty) {
      setState(() {
        username = dataList.last.username;
      });
    }
  }

  static const List<Widget> widgetOptions = [
    TodayWidget(),
    CategoryWidget(),
    StartWidget(),
    JourneyPage(),
    ScreenMe(), 
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
      backgroundColor: Colors.blueGrey,
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/bg_painted.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    if (shouldShowCalendar(page))
                      TableCalendar(
                        pageJumpingEnabled: true,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2035, 10, 16),
                        focusedDay: DateTime.now(),
                        calendarFormat: CalendarFormat.week,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: true,
                          outsideTextStyle: const TextStyle(color: Colors.black), 
                          todayDecoration: BoxDecoration(
                            color: Colors.indigo.shade900,
                            shape: BoxShape.circle,
                          ),
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: Colors.indigo),
                          weekendStyle: TextStyle(color: Colors.indigo),
                        ),
                        headerStyle: HeaderStyle(
                          rightChevronVisible: false,
                          leftChevronVisible: false,
                          titleTextFormatter: (date, locale) => 'Hey $username',
                          headerPadding: const EdgeInsets.all(15),
                          formatButtonVisible: false,
                          titleTextStyle: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: widgetOptions.elementAt(page)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: [
          shouldChangeIconColor(page, 0)
              ? SvgPicture.asset(
                  'lib/assets/svg/house.svg',
                  width: 35,
                  height: 35,
                )
              : const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
          shouldChangeIconColor(page, 1)
              ? SvgPicture.asset(
                  'lib/assets/svg/menu (1).svg',   
                  width: 35,
                  height: 35,
                )
              : const Icon(
                  Icons.assignment_sharp,
                  color: Colors.white,
                  size: 35,
                ),
          shouldChangeIconColor(page, 2)
              ? SvgPicture.asset(
                  'lib/assets/svg/add (1).svg', 
                  width: 35,
                  height: 35,
                )
              : const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
          shouldChangeIconColor(page, 3)
              ? SvgPicture.asset(
                  'lib/assets/svg/add (1).svg', 
                  width: 35,
                  height: 35,
                )
              : const Icon(
                  Icons.bar_chart,
                  color: Colors.white,
                  size: 35,
                ),
                shouldChangeIconColor(page, 3)
              ? SvgPicture.asset(
                  'lib/assets/svg/profile.svg', 
                  width: 35,
                  height: 35,
                )
              : const Icon(
                  Icons.person_2_outlined, 
                  color: Colors.white,
                  size: 35,
                ), 
        ],
        color: const Color.fromARGB(255, 25, 78, 122),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 900),
        buttonBackgroundColor: const Color.fromARGB(255, 25, 78, 122),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  bool shouldChangeIconColor(int selectedIndex, int iconIndex) {
    return selectedIndex == iconIndex;
  }

  bool shouldShowCalendar(int currentPageIndex) {
    return currentPageIndex == 0;
  }
}
