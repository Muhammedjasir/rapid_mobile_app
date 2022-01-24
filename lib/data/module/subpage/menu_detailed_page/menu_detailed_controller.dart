import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/data/database/database_operations.dart';
import 'package:rapid_mobile_app/data/model/metadata_columns_model/metadata_columns_response.dart';
import 'package:rapid_mobile_app/res/utils/rapid_controller.dart';
import 'package:rapid_mobile_app/res/values/logs/logs.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class MenuDetailedController extends RapidController {

  final TextEditingController controllerSearch = TextEditingController();

  // navigation argument
  dynamic get argumentData => Get.arguments;
  late String menuName,menuDefaultWhere;

  RxList<MetadataColumnsResponse> metadataColumnsTable =
      RxList<MetadataColumnsResponse>([]);
  RxList<MetadataColumnsResponse> selectedMenuColumns =
      RxList<MetadataColumnsResponse>([]);
  RxList<dynamic> menuData = RxList<dynamic>([]);

  int pageNumberMenuData = 10;

  @override
  onInit() {
    super.onInit();
    menuName = argumentData['MENU_NAME'];
    menuDefaultWhere = argumentData['MDT_DEFAULT_WHERE'];
    fetchSelectedMenuMetadataColumns(
      argumentData['MDT_SYS_ID'],
    );
  }

  void fetchSelectedMenuMetadataColumns(int sysId) async {
    final isMetadataColumnEmpty = await DatabaseOperations()
        .isMetadataTableEmpty(Strings.kMetadataColumns + sysId.toString());
    if (isMetadataColumnEmpty) {
      await fetchMetadataColumnsFromApi(sysId);
    } else {
      await fetchMetadataColumnsFromLocalDb(sysId);
    }
  }

  Future<void> fetchMetadataColumnsFromApi(int tableSysId) async {
    // Getting meta data frm the API
    final metadataColumnsTableResponse = await apiClient.rapidRepo
        .getMetadataColumns(sysId: tableSysId.toString());
    if (metadataColumnsTableResponse.status) {
      _saveMetadataColumnsTableToDb(
          metadataColumnsTableResponse.data, tableSysId);
      fetchMetadataColumnsFromLocalDb(tableSysId);
    }
  }

  void _saveMetadataColumnsTableToDb(dynamic columnsData, int tableSysId) {
    for (int i = 0; i < columnsData.length; ++i) {
      String res = json.encode(columnsData[i]);
      final jsonDecode = json.decode(res);
      final data = MetadataColumnsResponse.fromJson(jsonDecode);
      addMetadataColumnsTable(data, tableSysId);
    }
  }

  addMetadataColumnsTable(
      MetadataColumnsResponse columnsResponse, int tableSysId) async {
    metadataColumnsTable.add(columnsResponse);
    //open database
    Box box = await dbAccess.openDatabase();
    // add value to table
    box.put(Strings.kMetadataColumns + tableSysId.toString(),
        metadataColumnsTable.toList());
  }

  fetchMetadataColumnsFromLocalDb(int sysId) async {
    //open database
    Box box = await dbAccess.openDatabase();
    // read metadata columns table value
    List<MetadataColumnsResponse> metadataColumnData = box
        .get(Strings.kMetadataColumns + sysId.toString())
        .toList()
        .cast<MetadataColumnsResponse>();
    if (metadataColumnData.isNotEmpty) {
      metadataColumnsTable.value = metadataColumnData;
      fetchColumnsFromLocalDb(sysId: sysId);
    }
  }

  Future fetchColumnsFromLocalDb({
    int? sysId,
  }) async {
    // check where condition
    List<MetadataColumnsResponse> menuColumns = metadataColumnsTable
        .where((element) =>
            element.mdcMdtSysId == sysId &&
            element.mdcPrwTempVisble?.compareTo('Y') == 0)
        .toList();
    if (menuColumns.isEmpty) {
      menuColumns = metadataColumnsTable
          .where((element) =>
              element.mdcMdtSysId == sysId &&
              element.mdcGridVisible?.compareTo('Y') == 0)
          .toList();
    }
    Logs.logData("metadata length::", menuColumns.length);
    for (var element in menuColumns) {
      Logs.logData("metadata columns::", element.mdcMetatitle);
    }
    selectedMenuColumns.value = menuColumns;
    // sort list data
    selectedMenuColumns.sort((a, b) => a.mdcSeqnum.compareTo(b.mdcSeqnum));
  }

  Future<void> fetchSelectedMenuColumnValues(
      {required String tableName,
      required String defaultCondition,
      required int page}) async {
    // Getting meta data frm the API
    final menuDataResponse = await apiClient.rapidRepo.getMenuColumnValues(
        tableName: tableName, defaultCondition: defaultCondition, pageNo: page);
    if (menuDataResponse.status) {
      List<dynamic> menuColumnData = menuDataResponse.data;
      // menuData.value = menuColumnData;
      menuData.addAll(menuColumnData);
      pageNumberMenuData += 10;
    }
  }

  Future<void> loadMenuData() async {
    fetchSelectedMenuColumnValues(
      tableName: menuName,
      defaultCondition: menuDefaultWhere,
      page: pageNumberMenuData,
    );
  }
}
