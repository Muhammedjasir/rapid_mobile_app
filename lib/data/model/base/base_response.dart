import 'dart:convert';

class BaseResponse {
  BaseResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  dynamic data;

  factory BaseResponse.fromRawJson(String str) => BaseResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseResponse.fromJson(dynamic json) => BaseResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
