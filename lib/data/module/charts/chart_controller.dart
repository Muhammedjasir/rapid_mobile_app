import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rapid_mobile_app/data/model/chart_dashboard_model/chart_dashboard_response.dart';
import 'package:rapid_mobile_app/data/model/chart_graph_model/chart_graph_response.dart';
import 'package:rapid_mobile_app/data/model/chart_model/chart_response.dart';
import 'package:rapid_mobile_app/data/model/chart_tab_model/chart_tab_response.dart';
import 'package:rapid_mobile_app/res/utils/rapid_controller.dart';
import 'package:rapid_mobile_app/res/values/logs/logs.dart';
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
  RxList<ChartResponse> chartTable = RxList([]);
  RxList<ChartGraphResponse> chartGraphTable = RxList([]);

  @override
  void onInit() {
    super.onInit();
    _fetchChartTabs();
    _fetchChartDashboard();
    _fetchCharts();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    tabs.clear();
    chartTabTable.clear();
  }

  String convertDecimal(double? amount) {
    NumberFormat numberFormat = NumberFormat("#,###,##0.00");
    String convertedValue = numberFormat.format(amount);
    return convertedValue;
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

    chartTable.clear();
    chartGraphTable.clear();

    final sysId = chartTabTable[index].cgSysId;
    fetchChartDashboardFromLocalDb(sysId: sysId);
    fetchChartFromLocalDb(sysId: sysId);
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

  /// chart dashboard price
  Future<void> loadPrice({required int index}) async {
    final id = chartDashboardTable[index].mtdSysId;
    final response = await apiClient.rapidRepo.getChartDashboardPrice(
      query: chartDashboardTable[index].mtdQuery,
    );

    priceMaps.add(
      PriceMap(
        id: id,
        price: convertDecimal(response.data[0]['COUNT']),
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

  /// charts
  void _fetchCharts() async {
    final isChartDataEmpty = await dbAccess.isTableEmpty(Strings.kCharts);
    if (isChartDataEmpty) {
      await fetchChartFromApi();
    }
  }

  Future<void> fetchChartFromApi() async {
    final chartDataResponse = await apiClient.rapidRepo.getCharts();
    if (chartDataResponse.status) {
      _saveChartToLocalDb(chartDataResponse.data);
    }
  }

  Future<void> fetchChartFromLocalDb({required int sysId}) async {
    //open database
    Box box = await dbAccess.openDatabase();
    chartTable.clear();
    // read metadata table values
    List<ChartResponse> chartTableData =
        box.get(Strings.kCharts).toList().cast<ChartResponse>();
    if (chartTableData.isNotEmpty) {
      List<ChartResponse> chartResponse = chartTableData
          .where((element) => element.cCgGroupId == sysId)
          .toList();
      if (chartResponse.isNotEmpty) {
        chartTable.value = chartResponse;
      }
    }
  }

  void _saveChartToLocalDb(dynamic chartTableData) {
    for (int i = 0; i < chartTableData.length; ++i) {
      String res = json.encode(chartTableData[i]);
      final jsonDecode = json.decode(res);
      final data = ChartResponse.fromJson(jsonDecode);
      addChart(data);
    }
  }

  addChart(ChartResponse responseModel) async {
    chartTable.add(responseModel);
    //open database
    Box box = await dbAccess.openDatabase();
    // add value to table
    box.put(Strings.kCharts, chartTable.toList());
  }

  /// chart graph
  Future<void> loadChartGraph({required int index}) async {
    final id = chartTable[index].cSysId;
    final response = await apiClient.rapidRepo.getChartGraph(
      query: chartTable[index].cQueryString,
    );
    if (response.status) {
      dynamic graphResponse = response.data;
      for (int i = 0; i < graphResponse.length; ++i) {
        String res = json.encode(graphResponse[i]);
        final jsonDecode = json.decode(res);
        final data = ChartGraphResponse.fromJson(jsonDecode, id);
        chartGraphTable.add(data);
        Logs.logData("graph data::", i.toString()+' '+chartGraphTable[i].csFilter
            +' '+chartGraphTable[i].csValue.toString()+' '+chartGraphTable[i].id.toString());
      }
    }
  }

  ChartGraphResponse? graphData({required int id}) {
    Logs.logData("id::",id.toString());
    for (var value in chartGraphTable) {
      if (value.id == id) {
        return value;
      }
    }
    return null;
  }

  List<ChartGraphResponse> filterData({required int id}) {
    List<ChartGraphResponse> data = [];
    for (var value in chartGraphTable) {
      if (value.id == id) {
        data.add(value);
      }
    }
    return data;
  }
}
