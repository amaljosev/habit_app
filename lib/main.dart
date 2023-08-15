import 'package:flutter/material.dart';
import 'package:habit_project/screens/start/screen_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/analysis model/analysis_model.dart';
import 'models/count_model/count_model.dart';
import 'models/date models/date_model.dart';
import 'models/signup_models/signup_model.dart';
import 'models/user model/user_model.dart';




const save_key_name = 'userLoggedIn';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); 
  if (!Hive.isAdapterRegistered(SignUpModelAdapter().typeId)) {
    Hive.registerAdapter(SignUpModelAdapter());
  }
  if (!Hive.isAdapterRegistered(StartModelAdapter().typeId)) { 
    Hive.registerAdapter(StartModelAdapter());
  }
  if (!Hive.isAdapterRegistered(HabitsCountModelAdapter().typeId)) {
    Hive.registerAdapter(HabitsCountModelAdapter()); 
  }
  if (!Hive.isAdapterRegistered(DateModelAdapter().typeId)) {
    Hive.registerAdapter(DateModelAdapter()); 
  }
  if (!Hive.isAdapterRegistered(AnalysisModelAdapter().typeId)) {
    Hive.registerAdapter(AnalysisModelAdapter());  
  }
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), 
        useMaterial3: true,
        
      ),
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
