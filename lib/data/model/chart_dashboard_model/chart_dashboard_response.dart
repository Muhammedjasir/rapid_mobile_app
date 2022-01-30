import 'dart:convert';

import 'package:hive/hive.dart';

part 'chart_dashboard_response.g.dart';

@HiveType(typeId: 4, adapterName: 'ChartDashboardResponseAdapter')
class ChartDashboardResponse extends HiveObject {
  @HiveField(1)
  int mtdSysId;
  @HiveField(2)
  String? mtdText;
  @HiveField(3)
  String? mtdImage;
  @HiveField(4)
  String? mtdQuery;
  @HiveField(5)
  String? mtdBgColor;
  @HiveField(6)
  String? mtdDisplayFormat;
  @HiveField(7)
  int mtdSeqNo;
  @HiveField(8)
  String? mtdSubtext;
  @HiveField(9)
  int? mtduSysId;
  @HiveField(10)
  int? mtduMtdDashId;
  @HiveField(11)
  int? mtduMtlUserId;
  @HiveField(12)
  int? mtduCgSysId;

  ChartDashboardResponse({
    required this.mtdSysId,
    this.mtdText,
    this.mtdImage,
    this.mtdQuery,
    this.mtdBgColor,
    this.mtdDisplayFormat,
    required this.mtdSeqNo,
    this.mtdSubtext,
    this.mtduSysId,
    this.mtduMtdDashId,
    this.mtduMtlUserId,
    this.mtduCgSysId,
  });

  factory ChartDashboardResponse.fromRawJson(String str) =>
      ChartDashboardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChartDashboardResponse.fromJson(Map<String, dynamic> json) =>
      ChartDashboardResponse(
        mtdSysId: json["MTD_SYS_ID"].toInt(),
        mtdText: json["MTD_TEXT"],
        mtdImage: json["MTD_IMAGE"],
        mtdQuery: json["MTD_QUERY"],
        mtdBgColor: json["MTD_BG_COLOR"],
        mtdDisplayFormat: json["MTD_DISPLAY_FORMAT"],
        mtdSeqNo: json["MTD_SEQ_NO"]?.toInt(),
        mtdSubtext: json["MTD_SUBTEXT"],
        mtduSysId: json["MTDU_SYS_ID"]?.toInt(),
        mtduMtdDashId: json["MTDU_MTD_DASH_ID"]?.toInt(),
        mtduMtlUserId: json["MTDU_MTL_USER_ID"]?.toInt(),
        mtduCgSysId: json["MTDU_CG_SYS_ID"]?.toInt(),
      );

  Map<String, dynamic> toJson() => {
        "MTD_SYS_ID": mtdSysId,
        "MTD_TEXT": mtdText,
        "MTD_IMAGE": mtdImage,
        "MTD_QUERY": mtdQuery,
        "MTD_BG_COLOR": mtdBgColor,
        "MTD_DISPLAY_FORMAT": mtdDisplayFormat,
        "MTD_SEQ_NO": mtdSeqNo,
        "MTD_SUBTEXT": mtdSubtext,
        "MTDU_SYS_ID": mtduSysId,
        "MTDU_MTD_DASH_ID": mtduMtdDashId,
        "MTDU_MTL_USER_ID": mtduMtlUserId,
        "MTDU_CG_SYS_ID": mtduCgSysId,
      };
}
