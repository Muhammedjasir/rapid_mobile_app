import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/data/model/projects_list_model/project_list_response.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class ConnectionController extends GetxController {
  RxList<ProjectListResponse> savedProjects = RxList<ProjectListResponse>([]);

   Box<ProjectListResponse> getUsers() =>
      Hive.box<ProjectListResponse>(Strings.kRapidMainDatabase);

  final TextEditingController projectNameController = TextEditingController(
    text: 'ATM Bharath',
  );
  final TextEditingController baseUrlController = TextEditingController(
    text: 'https://api.techlogica.com/atmbharath/api/',
  );

  @override
  void onInit() {
    super.onInit();
    fetchProjectsFromDb();
  }

  /// Returns true: if the baseurl matches the validation criteria
  bool isBaseUrlCredentialValid() {
    return baseUrlController.text.isNotEmpty;
  }

  /// Returns true: if the project_name matches the validation criteria
  bool isProjectNameCredentialValid() {
    return projectNameController.text.isNotEmpty;
  }

  Future fetchProjectsFromDb() async {
    final userBox = await Hive.openBox<ProjectListResponse>(Strings.kRapidMainDatabase);
    // read metadata table values
    List<ProjectListResponse> dbSavedProjects =
        userBox.values.toList().cast<ProjectListResponse>();
    savedProjects.value = dbSavedProjects;
  }
}
