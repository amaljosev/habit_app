import 'package:flutter/material.dart';
import 'package:habit_project/screens/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MeWdget extends StatefulWidget {
  const MeWdget({super.key});

  @override
  State<MeWdget> createState() => _MeWdgetState();
}

class _MeWdgetState extends State<MeWdget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){signOut(context);}, child: Text('sign out')), 
      ],
    );
  }
  signOut(BuildContext ctx) async {
    final _sharedPrefs=await SharedPreferences.getInstance();
    _sharedPrefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LogInPage()), (route) => false);
  }
}