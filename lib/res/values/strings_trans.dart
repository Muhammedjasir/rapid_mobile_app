import 'package:get/get.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class StringsTrans extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          Strings.kAppName: 'Rapid App',
          Strings.kContinue: 'Continue',
          Strings.kUrl: 'Url',
          Strings.kUserName: 'User Name',
          Strings.kPassword: 'Password',
          Strings.kLogin: 'Login',
          Strings.kLoginTitle: 'Login to continue',
          Strings.kdDashboardPage: 'Dashboard',
          Strings.kHome: 'Home',
          Strings.kCalendar: 'Calendar',
        },
      };
}
