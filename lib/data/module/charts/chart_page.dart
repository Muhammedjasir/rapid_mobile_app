import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rapid_mobile_app/data/model/chart_graph_model/chart_graph_response.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_controller.dart';
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
          const SizedBox(
            height: 20,
          ),
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
                const SizedBox(
                  height: 10,
                ),
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
                            title: _PriceWidget(
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
                  height: 10,
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
                                primaryXAxis: DateTimeAxis(
                                    // arrangeByIndex: true,
                                    ),
                                enableSideBySideSeriesPlacement: false,
                                tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                ),
                                series: _getColumns(
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

  List<ColumnSeries<ChartGraphResponse, DateTime>> _getColumns(
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
          name: distinctKey[i].toString()
        ),
    ];
  }
}

class _PriceWidget extends GetView<ChartController> {
  const _PriceWidget({
    required this.id,
    Key? key,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final price = controller.price(id: id);
        return Row(
          children: [
            SizedBox(
              child: price != null
                  ? Text(
                      price.price,
                    )
                  : const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        );
      },
    );
  }
}
