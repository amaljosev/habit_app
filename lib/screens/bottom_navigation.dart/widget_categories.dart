import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../functions/hive_functions/db_start.dart';
import '../../models/categories/categories_model.dart';
import '../../models/sign_up/db_model.dart';
import '../screen_start.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: startListNotifier,
      builder: (BuildContext ctx, List<StartModel> startList, Widget? child) {
        return Padding(
          padding:  const EdgeInsets.all(10.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell( 
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        categoryList[index].trailingTitle.toString(),
                        style: GoogleFonts.andadaPro(  
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold, 
                              ),
                      ),
                      leading: categoryList[index].leadingIcon,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StartScreen(
                                  name: categoryList[index].trailingTitle)) ,
                        );
                        print(categoryList[index].trailingTitle);
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: categoryList.length),
        );
      },
    );
  }

  List<CategoryModel> categoryList = [
    CategoryModel(
        leadingIcon:  const Icon(
          Icons.yard,
          color:Colors.green, 
        ),
        trailingTitle: 'Meditation'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.menu_book_sharp,
          color: Colors.red,  
        ),
        trailingTitle: 'Reading'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.assignment,
          color: Colors.pink,
        ),
        trailingTitle: 'Study'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.accessibility_new,
          color: Colors.yellow,
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
          Icons.sports_soccer,
          color: Colors.orangeAccent,
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
  ];
}
