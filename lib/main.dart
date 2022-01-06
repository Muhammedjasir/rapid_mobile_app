import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rapid_mobile_app/data/api/api_provider.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

import 'data/module/auth/login/login_binding.dart';
import 'data/module/auth/login/login_page.dart';
import 'data/module/auth/project_connection/connection_binding.dart';
import 'data/module/auth/project_connection/url_connection_page.dart';
import 'data/module/dashboard/dashboard_binding.dart';
import 'data/module/dashboard/dashboard_page.dart';

void main() async {
  await GetStorage.init();
  Get.lazyPut(
        () => ApiProvider(),
  );
  runApp(MyApp());
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
      initialRoute: Strings.kLoginPage,
    );
  }
}
