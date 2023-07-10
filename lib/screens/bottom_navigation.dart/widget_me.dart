import 'package:flutter/material.dart';
import 'package:habit_project/screens/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/hive_functions/db_functions.dart';

class MeWdget extends StatefulWidget {
  const MeWdget({super.key});

  @override
  State<MeWdget> createState() => _MeWdgetState();
}

class _MeWdgetState extends State<MeWdget> {

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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container( 
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 80, 37, 89),
                  borderRadius: BorderRadius.all(Radius.circular(60))),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                  Text(username,style: TextStyle(color: Colors.white),), 
                  ElevatedButton(
                onPressed: () {
                  signOut(context); 
                },
                child: const Text('sign out')),
                ],
              ),
            ),
            
          ],
        ),
      ],
    );
  }

  signOut(BuildContext ctx) async {
    
    final _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const LogInPage()), (route) => false);
  }
  
     
        
  

}
