import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rapid_mobile_app/data/model/chart_graph_model/chart_graph_response.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_controller.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_dashboard_amount_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/card_container_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:darq/darq.dart';

class ChartPage extends GetView<ChartController> {
  const ChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ChartTabs();
  }
}

class _ChartTabs extends GetView<ChartController> {
  const _ChartTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      childWidget: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Obx(() {
              if (controller.tabs.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBar(
                  indicator: BoxDecoration(
                    color: colours.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  isScrollable: true,
                  controller: controller.tabController,
                  tabs: controller.tabs,
                  onTap: controller.onTapTab,
                );
              }
            }),
          ),
          Expanded(
            child: ListView(
              children: [
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.chartDashboardTable.length,
                    itemBuilder: (context, index) {
                      controller.loadPrice(index: index);
                      return CardContainerWidget(
                        cardWidget: Obx(
                          () => ListTile(
                            leading: const Icon(Icons.downloading),
                            title: ChartDashboardAmountWidget(
                              id: controller
                                  .chartDashboardTable[index].mtdSysId,
                            ),
                            subtitle: Text(controller
                                .chartDashboardTable[index].mtdSubtext
                                .toString()),
                            trailing: Text(controller
                                .chartDashboardTable[index].mtdText
                                .toString()),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.chartTable.length,
                    itemBuilder: (context, index) {
                      controller.loadChartGraph(index: index);
                      return CardContainerWidget(
                        cardWidget: Column(
                          children: <Widget>[
                            Obx(
                              () => SfCartesianChart(
                                title: ChartTitle(
                                  text: controller.chartTable[index].cChartName
                                      .toString(),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                  toggleSeriesVisibility: true,
                                  isResponsive: false,
                                ),
                                primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                    text: controller.chartTable[index].caName
                                        .toString(),
                                  ),
                                  numberFormat: NumberFormat.compact(),
                                ),
                                primaryXAxis: controller
                                            .chartTable[index].caIsArgument ==
                                        'key'
                                    ? CategoryAxis()
                                    : DateTimeAxis(
                                        dateFormat: _AxisLabelFormat(controller
                                            .chartTable[index].caLabelFormat),
                                      ),
                                enableSideBySideSeriesPlacement: false,
                                tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                ),
                                series: controller
                                            .chartTable[index].caIsArgument ==
                                        'key'
                                    ? _getColumnsByString(
                                        id: controller.chartTable[index].cSysId,
                                      )
                                    : _getColumnsByDate(
                                        id: controller.chartTable[index].cSysId,
                                      ),
                                plotAreaBorderWidth: 0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ColumnSeries<ChartGraphResponse, DateTime>> _getColumnsByDate(
      {required int id}) {
    List<ChartGraphResponse> data = controller.filterData(id: id);

    List<String> distinctKey = data
        .distinct((d) => d.csFilter)
        .select((element, index) => element.csFilter)
        .toList();

    return <ColumnSeries<ChartGraphResponse, DateTime>>[
      for (int i = 0; i < distinctKey.length; ++i)
        ColumnSeries<ChartGraphResponse, DateTime>(
          dataSource: data
              .where((element) => element.csFilter == distinctKey[i].toString())
              .toList(),
          xValueMapper: (ChartGraphResponse value, _) => value.csDate,
          yValueMapper: (ChartGraphResponse value, _) => value.csValue,
          name: distinctKey[i].toString(),
        ),
    ];
  }

  List<ColumnSeries<ChartGraphResponse, String>> _getColumnsByString(
      {required int id}) {
    List<ChartGraphResponse> data = controller.filterData(id: id);

    List<String> distinctKey = data
        .distinct((d) => d.csFilter)
        .select((element, index) => element.csFilter)
        .toList();

    return <ColumnSeries<ChartGraphResponse, String>>[
      for (int i = 0; i < distinctKey.length; ++i)
        ColumnSeries<ChartGraphResponse, String>(
          dataSource: data
              .where((element) => element.csFilter == distinctKey[i].toString())
              .toList(),
          xValueMapper: (ChartGraphResponse value, _) => value.csKey,
          yValueMapper: (ChartGraphResponse value, _) => value.csValue,
          name: distinctKey[i].toString(),
        ),
    ];
  }

  _AxisLabelFormat(int? labelFormat) {
    switch (labelFormat) {
      case 2:
        return DateFormat('dd-MM-yyyy');
      case 11:
        return DateFormat('MMM');
      case 21:
        return DateFormat('YYY');
      case 22:
        return DateFormat('EEE');
    }
  }
}
