import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:rapid_mobile_app/data/model/metadata_columns_model/metadata_columns_response.dart';
import 'package:rapid_mobile_app/data/module/subpage/menu_detailed_page/list_menu_detailed_data_grid_source.dart';
import 'package:rapid_mobile_app/data/module/subpage/menu_detailed_page/menu_detailed_controller.dart';
import 'package:rapid_mobile_app/data/widget/app_bar/app_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_bar/menu_bottom_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_sheet/common_search_bottom_sheet_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/loading_indicator/loading_indicator_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MenuDetailedPage extends GetView<MenuDetailedController> {
  const MenuDetailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: controller.argumentData['MENU_TITLE'],
        leadingIcon: Icons.keyboard_backspace,
        onTapLeadingIcon: _onTapAppbarLeadingIcon,
      ),
      body: const _BodyWidget(),
      bottomNavigationBar: MenuBottomBarWidget(
        onItemTap: _onItemTap,
      ),
    );
  }

  _onTapAppbarLeadingIcon() {
    Get.back();
  }

  _onItemTap(int onTapIndex) {
    switch (onTapIndex) {
      case 0:
        break;
      case 1:
        _alertBoxCommonSearch();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
    }
  }

  void _alertBoxCommonSearch() {
    Get.bottomSheet(
      CommonSearchBottomSheetWidget(
        onTap: () => {
          controller.loadMenuData(),
        Get.back(),
        },
        controller: controller.controllerSearch,
      ),
      enableDrag: true,
    );
  }
}

class _BodyWidget extends GetView<MenuDetailedController> {
  const _BodyWidget({Key? key}) : super(key: key);

  /// Determine to decide whether the device in landscape or in portrait
  final bool isLandscapeInMobileView = false;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      padding: const EdgeInsets.only(top: 15, left: 0, right: 0),
      alignment: Alignment.topLeft,
      childWidget: Obx(
        () => SfDataGrid(
          source: ListMenuDetailedDataGridSource(
            rowData: controller.menuData,
            columnData: controller.selectedMenuColumns,
            loadMore: controller.loadMenuData,
          ),
          loadMoreViewBuilder:
              (BuildContext context, LoadMoreRows loadMoreRows) {
            Future<String> loadRows() async {
              await loadMoreRows();
              return Future<String>.value('Completed');
            }

            return FutureBuilder<String>(
              initialData: 'loading',
              future: loadRows(),
              builder: (context, snapShot) {
                if (snapShot.data == 'loading') {
                  return const RapidLoadingIndicator();
                } else {
                  return SizedBox.fromSize(size: Size.zero);
                }
              },
            );
          },
          tableSummaryRows: _getSummaryColumns(),
          columns: _getColumns(),
          allowSorting: true,
          allowMultiColumnSorting: true,
          showSortNumbers: true,
        ),
      ),
    );
  }

  List<GridTableSummaryRow> _getSummaryColumns() {
    List<MetadataColumnsResponse> tableData = controller.selectedMenuColumns;
    List<GridTableSummaryRow> rows;
    rows = <GridTableSummaryRow>[
      GridTableSummaryRow(
        color: colours.icon_background_dark_grey,
        showSummaryInRow: false,
        columns: [
          for (var element in tableData)
            if (element.mdcSummaryType != null)
              GridSummaryColumn(
                name: element.mdcShowincoloumn.toString(),
                columnName: element.mdcShowincoloumn.toString() == 'ACTION'
                    ? tableData[0].mdcColName
                    : element.mdcShowincoloumn.toString(),
                summaryType: _onSummeryType(element.mdcSummaryType),
              ),
        ],
        position: GridTableSummaryRowPosition.bottom,
      ),
    ];
    return rows;
  }

  _onSummeryType(int? typeNumber) {
    switch (typeNumber) {
      case 1:
        return GridSummaryType.sum;
      case 2:
        return GridSummaryType.maximum;
      case 3:
        return GridSummaryType.minimum;
      case 4:
        return GridSummaryType.average;
      case 5:
        return GridSummaryType.count;
    }
  }

  List<GridColumn> _getColumns() {
    List<GridColumn> columns;
    columns = <GridColumn>[
      for (var element in controller.selectedMenuColumns)
        GridColumn(
          columnName: element.mdcColName.toString(),
          columnWidthMode: ColumnWidthMode.fitByColumnName,
          label: Container(
            padding: const EdgeInsets.only(left: 5),
            alignment: Alignment.centerLeft,
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

