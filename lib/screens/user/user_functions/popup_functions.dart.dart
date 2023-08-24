import 'package:flutter/material.dart';

import '../../../functions/hive_functions/db_start.dart';
import '../../screen_home.dart';


  popupDialogueBox(int indexValue,BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Do you want to delete this habit?"),
          title: Card(
              color: Colors.indigo.shade50,
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("DELETE HABIT"),
              ))),
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w900, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  )),
              onPressed: () {
                deleteData(indexValue);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return const Home();
                  }),
                );
              },
              child:
                  const Text("DELETE", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("GO BACK"),
            ),
          ],
        );
      },
    );
  }

  

