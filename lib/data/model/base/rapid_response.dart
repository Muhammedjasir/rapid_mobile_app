class RapidResponse {
  RapidResponse({
    required this.status,
    required this.message,
  });

  int? status;
  String? message;

  factory RapidResponse.fromJson(Map<String, dynamic> json) => RapidResponse(
        status: json["status"],
        message: json["message"],
      );
}
