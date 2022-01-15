import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/data/model/database_model/metadata_table_response.dart';
import 'package:rapid_mobile_app/res/values/logs/logs.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class HiveOperations {

  Future<Box> openHive() async {
    Box box;
    try{
      box = Hive.box(Strings.kDatabase);
    }catch(error){
      box =  await Hive.openBox(Strings.kDatabase);
      // Logs().logData("get_local_metadata.error:", error);
    }
    return box;
  }

}
