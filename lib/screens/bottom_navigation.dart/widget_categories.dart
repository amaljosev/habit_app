import 'package:flutter/material.dart';

import '../../models/categories/ctegories_model.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0), 
        child: ListView.separated(
            itemBuilder: (context, index) { 
             
              return Card(
                color:  Color.fromARGB(255, 80, 37, 89),
                child: ListTile(
                  
                  title: Text(categoryList[index].trailingTitle.toString(),style: TextStyle(color: Colors.white),),
                  leading: categoryList[index].leadingIcon,
                  onTap: () {
                    
                  },
                  
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20,); 
            },
            itemCount: categoryList.length),
      ),
    );
  }
  List<CategoryModel> categoryList=[
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Reading'), 
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Study'),
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Meditation'),
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Quit a bad habit'),
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Art'),
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Sports'),
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Social'),
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Health'),
    CategoryModel(leadingIcon: Icon(Icons.book,color: Colors.white,),trailingTitle: 'Workout'),

  ];
}
