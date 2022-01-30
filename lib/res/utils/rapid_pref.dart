import 'package:get_storage/get_storage.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class RapidPref {
  final storage = GetStorage();

  String? getToken() => storage.read(Strings.keyToken);

  void changeToken(String token) => storage.write(Strings.keyToken, token);

  String? getProjectId() => storage.read(Strings.keyProjectId);

  void changeProjectId(String projectId) =>
      storage.write(Strings.keyProjectId, projectId);

  String? getUserName() => storage.read(Strings.keyUserName);

  void changeUserName(String userName) =>
      storage.write(Strings.keyUserName, userName);

  String? getUserPassword() => storage.read(Strings.keyPassword);

  void changeUserPassword(String password) =>
      storage.write(Strings.keyPassword, password);

  int? getLoginUserId() => storage.read(Strings.keyLoginUserId);

  void changeLoginUserId(int loginUserId) =>
      storage.write(Strings.keyLoginUserId, loginUserId);

  String? getBaseUrl() => storage.read(Strings.kGetBaseUrl);

  void setBaseUrl(String baseUrl) =>
      storage.write(Strings.kGetBaseUrl, baseUrl);

  String? getProjectKey() => storage.read(Strings.kDatabase);

  void setProjectKey(String baseUrl) =>
      storage.write(Strings.kDatabase, baseUrl);

  String? getProjectName() => storage.read(Strings.kDatabase);

  void setProjectName(String baseUrl) =>
      storage.write(Strings.kDatabase, baseUrl);
}
