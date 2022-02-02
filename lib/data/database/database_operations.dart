import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';

class DatabaseOperations {

  Future<Box> openDatabase() async {
    var projectName = RapidPref().getProjectKey();
    Box box;
    try{
      box = Hive.box(projectName!);
    }catch(error){
      box =  await Hive.openBox(projectName!);
      // Logs().logData("get_local_metadata.error:", error);
    }
    return box;
  }

  Future<bool> isTableEmpty(String tableName) async {
    //open database
    Box box = await openDatabase();
    // read table values
    var tableData = box.get(tableName);
    return tableData == null;
  }

}
