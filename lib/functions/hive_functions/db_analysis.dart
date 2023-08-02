import 'package:hive/hive.dart';
import '../../models/sign_up/db_model.dart';

const ANALYSIS_DB_NAME = 'analaysis_db';

abstract class DateDBfunctions {
  Future<List<AnalysisModel>> getAllanalysData();
  Future<void> clearAllData(); 
  Future<void> addanalysData(AnalysisModel value);
  Future<void> updateanalysData(int index, AnalysisModel updatedValue);
  
}

class AnalysisDB implements DateDBfunctions {
  @override
  Future<void> addanalysData(AnalysisModel value) async {
    final habitDB = await Hive.openBox<AnalysisModel>(ANALYSIS_DB_NAME);
    await habitDB.add(value);
  }

  @override
  Future<List<AnalysisModel>> getAllanalysData() async {
    final habitDB = await Hive.openBox<AnalysisModel>(ANALYSIS_DB_NAME);
    return habitDB.values.toList();
  }

  @override
  Future<void> updateanalysData(int index, AnalysisModel updatedValue) async {
    final habitDB = await Hive.openBox<AnalysisModel>(ANALYSIS_DB_NAME);
    await habitDB.putAt(index, updatedValue);
  }
  
  @override
  Future<void> clearAllData() async {
    final habitDB = await Hive.openBox<AnalysisModel>(ANALYSIS_DB_NAME);
    await habitDB.clear();
  }
 
  
  
}
