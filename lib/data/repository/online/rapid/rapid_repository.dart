import 'package:rapid_mobile_app/data/api/api_client.dart';
import 'package:rapid_mobile_app/data/api/http_method.dart';
import 'package:rapid_mobile_app/data/model/base/base_response.dart';
import 'package:rapid_mobile_app/res/utils/generate_random_string.dart';
import 'package:rapid_mobile_app/res/utils/rapid_pref.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

abstract class IRapidRepository {
  /// Getting meta data using the Rapid REST API
  Future<BaseResponse> getMetaData({
    required String projectId,
  });

  Future<BaseResponse> getLoginTable(
      {required String loginTableName,
      required String userNameColumn,
      required String userPasswordColumn,
      required String loginTableIdColumn,
      required String permissionTableName,
      required String permissionTableIdColumn,
      required String metaDataTableIdColumn});

  Future<BaseResponse> getPermissionMenuTable({
    required String metaDataTableIdColumn,
    required String permissionTableName,
    required String permissionTableIdColumn,
  });
}

class RapidRepository extends IRapidRepository {
  RapidRepository(
    this._apiClient,
  );

  final ApiClient _apiClient;

  /// api call
  Future<BaseResponse> getBaseData(query) async {
    // body
    dynamic body = {Strings.kQuery: query};
    // header
    Map<String, String>? headers = {
      Strings.kAuthorization: "${Strings.kBearer} ${RapidPref().getToken()}",
      Strings.kHeaderKey: "$generateRandomString()",
    };
    // request and response
    BaseResponse result = await _apiClient.executeRequest(
      url: 'GetData',
      method: HttpMethod.POST,
      body: body,
      headers: headers,
    );
    return result;
  }

  @override
  Future<BaseResponse> getLoginTable({
    required String loginTableName,
    required String userNameColumn,
    required String userPasswordColumn,
    required String loginTableIdColumn,
    required String permissionTableName,
    required String permissionTableIdColumn,
    required String metaDataTableIdColumn,
  }) async {
    String userTableQuery =
        "SELECT $loginTableIdColumn FROM $loginTableName WHERE"
        " $userNameColumn = '${RapidPref().getUserName().toString()}'";
    final result = await getBaseData(userTableQuery);
    return result;
  }

  @override
  Future<BaseResponse> getMetaData({required String projectId}) async {
    String metadataProjectQuery =
        'SELECT MDP_TBL_LOGIN, MDP_LGNFIELD_USERNAME, MDP_LGNFIELD_PASSWORD, '
                'MDP_LGNFIELD_USERID, MDP_TBL_PERMISSION, MDP_PERMSNFIELD_USERID, '
                'MDP_PERMSN_TBLID FROM METADATA_PROJECT WHERE MDP_SYS_ID = ' +
            projectId;

    final result = await getBaseData(metadataProjectQuery);
    return result;
  }

  @override
  Future<BaseResponse> getPermissionMenuTable({
    required String metaDataTableIdColumn,
    required String permissionTableName,
    required String permissionTableIdColumn,
  }) async {
    String menuQuery = "SELECT * FROM METADATA_TABLES WHERE MDT_SYS_ID IN "
        "(SELECT $metaDataTableIdColumn FROM $permissionTableName WHERE "
        "$permissionTableIdColumn = ${RapidPref().getLoginUserId()})";
    final result = await getBaseData(menuQuery);
    return result;
  }
}
