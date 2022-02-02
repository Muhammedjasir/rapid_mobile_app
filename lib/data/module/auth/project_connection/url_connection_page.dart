import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/data/api/api_client.dart';
import 'package:rapid_mobile_app/data/model/projects_list_model/project_list_response.dart';
import 'package:rapid_mobile_app/data/module/auth/project_connection/connection_controller.dart';
import 'package:rapid_mobile_app/data/widget/buttons/login_button_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/text_fields/text_field_widget.dart';
import 'package:rapid_mobile_app/data/widget/tile/listview_tile_widget.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class UrlConnectionPage extends GetView<ConnectionController> {
  const UrlConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.kProjects,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: colours.background_top,
        elevation: 0.0,
        toolbarHeight: 80.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
        onPressed: _onPressedFloatingButton,
      ),
      body: BackgroundWidget(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        childWidget: Obx(
          () => ListView.builder(
            itemCount: controller.savedProjects.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: const ValueKey(0),
                enabled: true,
                child: ListTileWidget(
                  response: controller.savedProjects[index],
                ),
                startActionPane: ActionPane(
                  extentRatio: 0.20,
                  dragDismissible: false,
                  motion: const DrawerMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) => _onTapListView(
                          controller.savedProjects[index], 'delete', index),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: Strings.kDelete,
                      spacing: 10.0,
                    )
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.20,
                  dragDismissible: false,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) => _onTapListView(
                          controller.savedProjects[index], 'add', index),
                      backgroundColor: const Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.arrow_forward,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _onPressedFloatingButton() {
    _openProjectAlertBox();
  }

  _openProjectAlertBox() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      contentPadding: const EdgeInsets.all(20.0),
      radius: 15.0,
      title: Strings.kAddProject.tr,
      backgroundColor: Colors.white,
      barrierDismissible: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldWidget(
              hint: Strings.kProjectName.tr,
              controller: controller.projectNameController),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
              hint: Strings.kUrl.tr, controller: controller.baseUrlController),
          const SizedBox(
            height: 25,
          ),
          LoginButtonWidget(
            label: Strings.kAdd.tr,
            onTap: _onTapAlertButton,
          ),
        ],
      ),
    );
  }

  _onTapAlertButton() {
    if (controller.isBaseUrlCredentialValid() &&
        controller.isProjectNameCredentialValid()) {
      // fetch controller values
      String projectName =
          controller.projectNameController.text.toString().trim();
      String projectKey = projectName.replaceAll(' ', '');
      String url = controller.baseUrlController.text.toString();
      // clear controller values
      controller.projectNameController.clear();
      // controller.baseUrlController.clear();

      ProjectListResponse response = ProjectListResponse(
          projectName: projectName,
          projectKey: projectKey,
          projectUrl: url,
          userName: '',
          password: '',
          projectId: '');
      // add to db
      controller.getUsers().add(response);
      controller.fetchProjectsFromDb();
      Get.back();
    }
  }

  _onTapListView(
      ProjectListResponse savedProject, String type, int index) async {
    if (type == 'add') {
      // store project url, project localdbName, projectName
      RapidPref().setBaseUrl(savedProject.projectUrl);
      RapidPref().setProjectName(savedProject.projectName);
      RapidPref().setProjectKey(savedProject.projectKey);
      // update project url
      Get.find<ApiClient>().updateBaseUrl(savedProject.projectUrl);

      // var isToken = RapidPref().getToken() ?? "";
      Get.toNamed(
        Strings.kLoginPage ,
        arguments: {
          'index': index,
          'url': savedProject.projectUrl,
          'projectName': savedProject.projectName,
          'projectKey': savedProject.projectKey,
        },
      );
    } else if (type == 'delete') {
      var userBox =
          await Hive.openBox<ProjectListResponse>(Strings.kRapidMainDatabase);
      userBox.deleteAt(index);
      controller.fetchProjectsFromDb();
    }
  }

  void doNothing(BuildContext context) {}
}
