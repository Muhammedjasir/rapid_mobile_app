
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  //Shared Preferences
  static SharedPreferences? pref;

  // Shared preference file name
  static const prefName = "RAPID";

  //All Shared Preference Keys
  static const baseUrl = "base_url";
  static const token = "token";

  static const keyIsSynced = "is_synced";
  static const keyLogin = "login";
  static const loginFlag = "login_flag";

  static const keyUserName = "user_name";
  static const keyUserId = "user_id";
  static const keyUserFcmToken = "fcm_token";



}