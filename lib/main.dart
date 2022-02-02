import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rapid_mobile_app/data/api/api_client.dart';
import 'package:rapid_mobile_app/data/database/database_operations.dart';
import 'package:rapid_mobile_app/data/model/chart_dashboard_model/chart_dashboard_response.dart';
import 'package:rapid_mobile_app/data/module/Calendar/calendar_binding.dart';
import 'package:rapid_mobile_app/data/module/Calendar/calendar_page.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_binding.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_page.dart';
import 'package:rapid_mobile_app/data/module/home/home_binding.dart';
import 'package:rapid_mobile_app/data/module/home/home_page.dart';
import 'package:rapid_mobile_app/data/module/subpage/menu_detailed_page/menu_detailed_binding.dart';
import 'package:rapid_mobile_app/data/module/subpage/menu_detailed_page/menu_detailed_page.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

import 'data/model/chart_model/chart_response.dart';
import 'data/model/chart_tab_model/chart_tab_response.dart';
import 'data/model/metadata_columns_model/metadata_columns_response.dart';
import 'data/model/metadata_table_model/metadata_table_response.dart';
import 'data/model/projects_list_model/project_list_response.dart';
import 'data/module/auth/login/login_binding.dart';
import 'data/module/auth/login/login_page.dart';
import 'data/module/auth/project_connection/connection_binding.dart';
import 'data/module/auth/project_connection/url_connection_page.dart';
import 'data/module/dashboard/dashboard_binding.dart';
import 'data/module/dashboard/dashboard_page.dart';

void main() async {
  await GetStorage.init();
  _registerServices();
  await Hive.initFlutter();
  _registerAdapter();

  runApp(MyApp());
}

/// Initiating ApiClient and Repo
void _registerServices() {
  Get.lazyPut(() => ApiClient());
  Get.lazyPut(() => DatabaseOperations());
}

///register hive adapter
void _registerAdapter() {
  if (!Hive.isAdapterRegistered(MetadataTableResponseAdapter().typeId)) {
    Hive.registerAdapter(
      MetadataTableResponseAdapter(),
    );
  }
  Hive.registerAdapter(
    MetadataColumnsResponseAdapter(),
  );
  Hive.registerAdapter(
    ProjectListResponseAdapter(),
  );
  Hive.registerAdapter(
    ChartTabResponseAdapter(),
  );
  Hive.registerAdapter(
    ChartDashboardResponseAdapter(),
  );
  Hive.registerAdapter(
      CharResponseAdapter(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final pages = [
    GetPage(
      name: Strings.kUrlConnectionPage,
      page: () => const UrlConnectionPage(),
      binding: ConnectionBinding(),
    ),
    GetPage(
      name: Strings.kLoginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Strings.kDashboardPage,
      page: () => const Dashboard(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Strings.kMenuDetailedPage,
      page: () => const MenuDetailedPage(),
      binding: MenuDetailedBinding(),
    ),
    GetPage(
      name: Strings.kChartPage,
      page: () => const ChartPage(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: Strings.kHomePage,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Strings.kCalendarPage,
      page: () => const CalendarPage(),
      binding: CalendarBinding(),
    ),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Strings.kAppName.tr,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      getPages: pages,
      initialRoute: Strings.kUrlConnectionPage,
    );
  }
}
