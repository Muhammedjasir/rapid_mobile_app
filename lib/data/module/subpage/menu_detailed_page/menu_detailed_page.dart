import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:rapid_mobile_app/data/model/metadata_columns_model/metadata_columns_response.dart';
import 'package:rapid_mobile_app/data/module/subpage/menu_detailed_page/menu_detailed_controller.dart';
import 'package:rapid_mobile_app/data/widget/app_bar_widget/app_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_bar_widget/menu_bottom_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/container_widget/background_widget.dart';
import 'package:rapid_mobile_app/res/values/logs/logs.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MenuDetailedPage extends GetView<MenuDetailedController> {
  const MenuDetailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: controller.argumentData['MENU_TITLE'],
        leadingIcon: Icons.keyboard_backspace,
        actionIcon: Icons.search,
        onTapLeadingIcon: _onTapAppbarLeadingIcon,
        onTapActionIcon: _onTapAppbarActionIcon,
      ),
      body: const _BodyWidget(),
      bottomNavigationBar: MenuBottomBarWidget(
        onItemTap: _onItemTap,
      ),
    );
  }

  _onTapAppbarActionIcon() {
    // alertBoxCommonSearch(controller);
    Logs.logData("search click::", "true");
  }

  _onTapAppbarLeadingIcon() {
    // Get.back();
  }

  _onItemTap(int onTapIndex) {
    switch (onTapIndex) {
      case 0:
        return 0;
      case 1:
        return 0;
      case 2:
        return 0;
      case 3:
        return 0;
      case 4:
        return 0;
      case 5:
        return 0;
      case 6:
        return 0;
      default:
        return 0;
    }
  }

  void _alertBoxCommonSearch(MenuDetailedController controller) {
    // controller.listDataGridSource;
    // Get.bottomSheet(
    //   const SearchBottomSheet(),
    // );
  }
}

class _BodyWidget extends GetView<MenuDetailedController> {
  const _BodyWidget({Key? key}) : super(key: key);

  /// Determine to decide whether the device in landscape or in portrait
  final bool isLandscapeInMobileView = false;

  // late ListDataGridSource _listDataGridSource;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
      alignment: Alignment.topLeft,
      childWidget: Obx(
        () => SfDataGrid(
          columns: _getColumns(),
          source: ListDataGridSource(
            rowData: controller.menuData,
            columnData: controller.selectedMenuColumns,
          ),
        ),
      ),
    );
  }

  List<GridColumn> _getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      for (var element in controller.selectedMenuColumns)
        GridColumn(
          // width: double.nan,
          columnName: element.mdcColName.toString(),
          allowSorting: true,
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            child: Text(
              element.mdcMetatitle.toString(),
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ),
    ];
    return columns;
  }
}

class ListDataGridSource extends DataGridSource {
  ListDataGridSource({
    required List<dynamic> rowData,
    required List<MetadataColumnsResponse> columnData,
  }) {
    _rowData = rowData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              for (var item in columnData)
                DataGridCell<dynamic>(
                  columnName: item.mdcColName.toString(),
                  value: e[item.mdcColName],
                ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _rowData = [];

  @override
  List<DataGridRow> get rows => _rowData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (e) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Text(e.value.toString()),
          );
        },
      ).toList(),
    );
  }
}
