import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class DatabaseOperations {

  Future<Box> openDatabase() async {
    Box box;
    try{
      box = Hive.box(Strings.kDatabase);
    }catch(error){
      box =  await Hive.openBox(Strings.kDatabase);
      // Logs().logData("get_local_metadata.error:", error);
    }
    return box;
  }

  Future<bool> isMetadataTableEmpty(String tableName) async {
    //open database
    Box box = await openDatabase();
    // read table values
    var tableData = box.get(tableName);
    return tableData == null;
  }

}
