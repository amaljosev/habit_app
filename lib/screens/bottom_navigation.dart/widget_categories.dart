import 'package:flutter/material.dart';

import '../../functions/hive_functions/db_start.dart';
import '../../models/categories/categories_model.dart';
import '../../models/sign_up/signup_model.dart';
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
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 80, 37, 89),
                  child: ListTile(
                    title: Text(
                      categoryList[index].trailingTitle.toString(),
                      style: const TextStyle(color: Colors.white),
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
        leadingIcon: const Icon(
          Icons.yard,
          color: Colors.white,
        ),
        trailingTitle: 'Meditation'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.menu_book_sharp,
          color: Colors.white,
        ),
        trailingTitle: 'Reading'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.assignment,
          color: Colors.white,
        ),
        trailingTitle: 'Study'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.accessibility_new,
          color: Colors.white,
        ),
        trailingTitle: 'Workout'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.draw,
          color: Colors.white,
        ),
        trailingTitle: 'Art'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.sports_soccer,
          color: Colors.white,
        ),
        trailingTitle: 'Sports'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.mobile_off_outlined,
          color: Colors.white,
        ),
        trailingTitle: 'Social'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.cleaning_services_outlined,
          color: Colors.white,
        ),
        trailingTitle: 'Cleaning'),
    CategoryModel(
        leadingIcon: const Icon(
          Icons.airline_seat_individual_suite,
          color: Colors.white,
        ),
        trailingTitle: 'Sleep'),
  ];
}
