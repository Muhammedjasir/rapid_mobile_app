import 'package:rapid_mobile_app/data/model/base/rapid_response.dart';

class LoginData {
  LoginData({
    required this.token,
    required this.tokenExpireTime,
    required this.projectId,
  });

  String token;
  String tokenExpireTime;
  int projectId;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json["token"],
        tokenExpireTime: json["token_expire_time"],
        projectId: json["Project_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_expire_time": tokenExpireTime,
        "Project_id": projectId,
      };
}

class LoginResponse extends RapidResponse {
  LoginResponse({
    required int? status,
    required String? message,
    this.data,
  }) : super(status: status, message: message);

  static LoginResponse fromJson(dynamic json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        data: LoginData.fromJson(json["data"]),
      );

  LoginData? data;
}
