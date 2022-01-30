import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rapid_mobile_app/data/model/chart_dashboard_model/chart_dashboard_response.dart';
import 'package:rapid_mobile_app/data/model/chart_tab_model/chart_tab_response.dart';
import 'package:rapid_mobile_app/res/utils/rapid_controller.dart';
import 'package:rapid_mobile_app/res/values/strings.dart';

class PriceMap {
  int id;
  String price;

  PriceMap({
    required this.id,
    required this.price,
  });
}

class ChartController extends RapidController
    with GetSingleTickerProviderStateMixin {
  RxList<Tab> tabs = <Tab>[].obs;
  RxList<ChartTabResponse> chartTabTable = RxList<ChartTabResponse>([]);
  late TabController tabController;
  RxList<ChartDashboardResponse> chartDashboardTable =
      RxList<ChartDashboardResponse>([]);

  RxList<PriceMap> priceMaps = RxList([]);

  @override
  void onInit() {
    super.onInit();
    _fetchChartTabs();
    _fetchChartDashboard();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    tabs.clear();
    chartTabTable.clear();
  }

  /// chart tabs

  void _fetchChartTabs() async {
    final isChartTabEmpty = await dbAccess.isTableEmpty(Strings.kChartTabTable);
    if (isChartTabEmpty) {
      await fetchChartTabFromApi();
    } else {
      fetchChartTabFromLocalDb();
    }
  }

  Future<void> fetchChartTabFromApi() async {
    // Getting meta data frm the API
    final chartTabResponse = await apiClient.rapidRepo.getChartTabs();
    if (chartTabResponse.status) {
      _saveChartTabsToLocalDb(chartTabResponse.data);
      fetchChartTabFromLocalDb();
    }
  }

  Future<void> fetchChartTabFromLocalDb() async {
    //open database
    Box box = await dbAccess.openDatabase();
    chartTabTable.clear();
    // read metadata table values
    List<ChartTabResponse> chartTabTableData =
        box.get(Strings.kChartTabTable).toList().cast<ChartTabResponse>();
    if (chartTabTableData.isNotEmpty) {
      chartTabTable.value = chartTabTableData;
      onTapTab(0);
    }
    tabs = getTabs(chartTabTable);
    tabController = getTabController();
  }

  void _saveChartTabsToLocalDb(dynamic chartTabData) {
    for (int i = 0; i < chartTabData.length; ++i) {
      String res = json.encode(chartTabData[i]);
      final jsonDecode = json.decode(res);
      final data = ChartTabResponse.fromJson(jsonDecode);
      addChartTab(data);
    }
  }

  addChartTab(ChartTabResponse responseModel) async {
    chartTabTable.add(responseModel);
    //open database
    Box box = await dbAccess.openDatabase();
    // add value to table
    box.put(Strings.kChartTabTable, chartTabTable.toList());
  }

  RxList<Tab> getTabs(RxList<ChartTabResponse> chartTabs) {
    tabs.clear();
    for (int i = 0; i < chartTabs.length; i++) {
      tabs.add(getTab(chartTabs[i].cgGrpName.toString()));
    }
    return tabs;
  }

  TabController getTabController() {
    return TabController(length: tabs.length, vsync: this);
  }

  Tab getTab(String name) {
    return Tab(
      text: name,
    );
  }

  void onTapTab(int index) {
    final sysId = chartTabTable[index].cgSysId;
    fetchChartDashboardFromLocalDb(sysId: sysId);
  }

  /// chart dashboard
  void _fetchChartDashboard() async {
    final isChartDashboardEmpty =
        await dbAccess.isTableEmpty(Strings.kChartDashboardTable);
    if (isChartDashboardEmpty) {
      await fetchChartDashboardFromApi();
    }
  }

  Future<void> fetchChartDashboardFromApi() async {
    // Getting meta data frm the API
    final chartDashboardResponse =
        await apiClient.rapidRepo.getChartDashboard();
    if (chartDashboardResponse.status) {
      _saveChartDashboardToLocalDb(chartDashboardResponse.data);
    }
  }

  void _saveChartDashboardToLocalDb(dynamic chartDashboardData) {
    for (int i = 0; i < chartDashboardData.length; ++i) {
      String res = json.encode(chartDashboardData[i]);
      final jsonDecode = json.decode(res);
      final data = ChartDashboardResponse.fromJson(jsonDecode);
      addChartDashboard(data);
    }
  }

  addChartDashboard(ChartDashboardResponse responseModel) async {
    chartDashboardTable.add(responseModel);
    //open database
    Box box = await dbAccess.openDatabase();
    // add value to table
    box.put(Strings.kChartDashboardTable, chartDashboardTable.toList());
  }

  Future<void> fetchChartDashboardFromLocalDb({required int sysId}) async {
    //open database
    Box box = await dbAccess.openDatabase();
    chartDashboardTable.clear();
    // read metadata table values
    List<ChartDashboardResponse> chartDashboardTableData = box
        .get(Strings.kChartDashboardTable)
        .toList()
        .cast<ChartDashboardResponse>();
    if (chartDashboardTableData.isNotEmpty) {
      List<ChartDashboardResponse> dashboardTable = chartDashboardTableData
          .where((element) => element.mtduCgSysId == sysId)
          .toList();
      if (dashboardTable.isNotEmpty) {
        chartDashboardTable.value = dashboardTable;
      }
    }
  }

  Future<void> loadPrice({required int index}) async {
    final id = chartDashboardTable[index].mtdSysId;
    final response = await apiClient.rapidRepo.getChartDashboardPrice(
      query: chartDashboardTable[index].mtdQuery,
    );

    priceMaps.add(
      PriceMap(
        id: id,
        price: '${response.data[0]['COUNT']}',
      ),
    );
  }

  PriceMap? price({required int id}) {
    for (var value in priceMaps) {
      if (value.id == id) {
        return value;
      }
    }
    return null;
  }
}
