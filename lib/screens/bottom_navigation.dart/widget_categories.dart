import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../models/categories/categories_model.dart';
import '../../models/user model/user_model.dart';
import '../screen_start.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(  
        child: Container(  
          decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
          child: Padding(  
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 120), 
            child: ValueListenableBuilder( 
              valueListenable: startListNotifier,
              builder:
                  (BuildContext ctx, List<StartModel> startList, Widget? child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Card( 
                          color: Colors.indigo.shade50,
                          child: ListTile(
                            title: Text(
                              categoryList[index].trailingTitle.toString(),
                              style: GoogleFonts.saira(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: categoryList[index].leadingIcon,
                           
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartScreen(
                                        name: categoryList[index].trailingTitle)),
                              );
                              print(categoryList[index].trailingTitle);
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: categoryList.length);
              },
            ),
          ),
        ),
      );
    
  }

  List<CategoryModel> categoryList = [
    CategoryModel(
        leadingIcon: const Icon(
          Icons.yard,
          color: Colors.green,
        ),
        trailingTitle: 'Meditation'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.menu_book_sharp,
          color: Colors.red,
        ),
        trailingTitle: 'Reading'),
    CategoryModel(
        leadingIcon: Icon(
          Icons.directions_walk,
          color: Colors.purple.shade300,
        ),
        trailingTitle: 'Walking'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.assignment,
          color: Colors.pink,
        ),
        trailingTitle: 'Study'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.fitness_center,
          color: Colors.black,
        ),
        trailingTitle: 'Workout'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.draw,
          color: Colors.purple,
        ),
        trailingTitle: 'Art'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.water_drop_outlined,
          color: Colors.deepPurple,
        ),
        trailingTitle: 'Drink Water'),
    CategoryModel(
        leadingIcon: Icon(
          Icons.sports_soccer_outlined,
          color: Colors.yellow.shade800,
        ),
        trailingTitle: 'Sports'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.mobile_off_outlined,
          color: Colors.grey,
        ),
        trailingTitle: 'Social'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.cleaning_services_outlined,
          color: Colors.blue,
        ),
        trailingTitle: 'Cleaning'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.airline_seat_individual_suite,
          color: Colors.deepPurple,
        ),
        trailingTitle: 'Sleep'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.currency_rupee,
          color: Colors.deepPurple,
        ),
        trailingTitle: 'Limit spending'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.directions_run,
          color: Colors.greenAccent,
        ),
        trailingTitle: 'Running'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.pool,
          color: Colors.blueGrey,
        ),
        trailingTitle: 'Swimming'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.local_florist_outlined,
          color: Colors.orangeAccent,
        ),
        trailingTitle: 'Gardening'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.accessibility_new,
          color: Colors.orangeAccent,
        ),
        trailingTitle: 'Yoga'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.directions_bike,
          color: Colors.brown,
        ),
        trailingTitle: 'cycling'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.sports_gymnastics_sharp,
          color: Colors.blueAccent,
        ),
        trailingTitle: 'Warm up'),
    CategoryModel(
        leadingIcon: Icon(
          Icons.air,
          color: Colors.red.shade400,
        ),
        trailingTitle: 'Practice breathing'),
    CategoryModel(
        leadingIcon: Icon(
          Icons.border_color_rounded,
          color: Colors.green.shade700,
        ),
        trailingTitle: 'Keep a journal'),
  ];
}
