import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'chart_controller.dart';

class ChartDashboardAmountWidget extends GetView<ChartController> {
  const ChartDashboardAmountWidget({
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