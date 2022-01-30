import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_mobile_app/data/module/charts/chart_controller.dart';
import 'package:rapid_mobile_app/data/widget/container/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/card_container_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';

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
              ],
            ),
          ),
        ],
      ),
    );
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
