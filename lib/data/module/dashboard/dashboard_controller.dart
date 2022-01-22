import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/data/model/base/base_response.dart';
import 'package:rapid_mobile_app/data/model/metadata_table_model/metadata_table_response.dart';
import 'package:rapid_mobile_app/res/utils/rapid_controller.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class DashboardController extends RapidController {
  RxList<MetadataTableResponse> metadataTable =
      RxList<MetadataTableResponse>([]);
  RxList<MetadataTableResponse> firstPageData =
      RxList<MetadataTableResponse>([]);

  @override
  void onInit() {
    super.onInit();
    fetchMetaData();
  }

  addMetadataTable(MetadataTableResponse responseModel) async {
    metadataTable.add(responseModel);
    //open database
    Box box = await dbAccess.openDatabase();
    // add value to table
    box.put(Strings.kMetadataTable, metadataTable.toList());
  }

  Future fetchMetaDataFromLocalDb() async {
    //open database
    Box box = await dbAccess.openDatabase();
    // read metadata table values
    List<MetadataTableResponse> metadataTableData =
        box.get(Strings.kMetadataTable).toList().cast<MetadataTableResponse>();
    if (metadataTableData.isNotEmpty) {
      metadataTable.value = metadataTableData;
      fetchMenusFromLocalDb(sysId: 0);
    }
  }

  Future fetchMenusFromLocalDb({
    int? sysId,
  }) async {
    // check where condition
    List<MetadataTableResponse> firstPageResponse = metadataTable
        .where((element) => element.mdtMenuPrntid == sysId)
        .toList();
    firstPageData.value = firstPageResponse;
    // sort list data
    firstPageData.sort((a, b) => a.mdtSeqno.compareTo(b.mdtSeqno));
  }

  void fetchMetaData() async {
    final isMetadataEmpty =
        await dbAccess.isMetadataTableEmpty(Strings.kMetadataTable);
    if (isMetadataEmpty) {
      await fetchMetadataFromApi();
    } else {
      fetchMetaDataFromLocalDb();
    }
  }

  Future<void> fetchMetadataFromApi() async {
    // Getting meta data frm the API
    final metaDataResponse = await apiClient.rapidRepo.getMetaData(
      projectId: RapidPref().getProjectId().toString(),
    );

    // Checking if the status is success
    if (metaDataResponse.status) {
      // get userId
      final loginResponse = await getLoginTableData(metaDataResponse.data);
      if (loginResponse.status) {
        _changeLoginUserId(
          metaData: metaDataResponse.data,
          loginData: loginResponse.data,
        );

        final permissionMenuResponse =
            await getPermissionMenuData(metaData: metaDataResponse.data);
        if (permissionMenuResponse.status) {
          _savePermissionMenuResponseToDb(permissionMenuResponse.data);
          fetchMetaDataFromLocalDb();
        }
      }
    }
  }

  /// Fetching the Login table data
  Future<BaseResponse> getLoginTableData(dynamic metaData) async {
    String loginTableName = metaData[0]['MDP_TBL_LOGIN'];
    String userNameColumn = metaData[0]['MDP_LGNFIELD_USERNAME'];
    String userPasswordColumn = metaData[0]['MDP_LGNFIELD_PASSWORD'];
    String loginTableIdColumn = metaData[0]['MDP_LGNFIELD_USERID'];
    String permissionTableName = metaData[0]['MDP_TBL_PERMISSION'];
    String permissionTableIdColumn = metaData[0]['MDP_PERMSNFIELD_USERID'];
    String metaDataTableIdColumn = metaData[0]['MDP_PERMSN_TBLID'];

    final result = apiClient.rapidRepo.getLoginTable(
        loginTableName: loginTableName,
        userNameColumn: userNameColumn,
        userPasswordColumn: userPasswordColumn,
        loginTableIdColumn: loginTableIdColumn,
        permissionTableName: permissionTableName,
        permissionTableIdColumn: permissionTableIdColumn,
        metaDataTableIdColumn: metaDataTableIdColumn);

    return result;
  }

  Future<BaseResponse> getPermissionMenuData({
    dynamic metaData,
  }) async {
    String permissionTableName = metaData[0]['MDP_TBL_PERMISSION'];
    String permissionTableIdColumn = metaData[0]['MDP_PERMSNFIELD_USERID'];
    String metaDataTableIdColumn = metaData[0]['MDP_PERMSN_TBLID'];

    final result = await apiClient.rapidRepo.getPermissionMenuTable(
      metaDataTableIdColumn: metaDataTableIdColumn,
      permissionTableName: permissionTableName,
      permissionTableIdColumn: permissionTableIdColumn,
    );

    return result;
  }

  void _changeLoginUserId({
    required dynamic metaData,
    required dynamic loginData,
  }) {
    String loginTableIdColumn = metaData[0]['MDP_LGNFIELD_USERID'];
    RapidPref().changeLoginUserId(loginData[0][loginTableIdColumn]);
  }

  void _savePermissionMenuResponseToDb(dynamic permissionData) {
    for (int i = 0; i < permissionData.length; ++i) {
      String res = json.encode(permissionData[i]);
      final jsonDecode = json.decode(res);
      final data = MetadataTableResponse.fromJson(jsonDecode);
      addMetadataTable(data);
    }
  }
}
