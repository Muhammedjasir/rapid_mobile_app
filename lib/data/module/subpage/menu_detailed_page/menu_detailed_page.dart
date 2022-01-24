import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:rapid_mobile_app/data/model/metadata_columns_model/metadata_columns_response.dart';
import 'package:rapid_mobile_app/data/module/subpage/menu_detailed_page/menu_detailed_controller.dart';
import 'package:rapid_mobile_app/data/widget/app_bar/app_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_bar/menu_bottom_bar_widget.dart';
import 'package:rapid_mobile_app/data/widget/bottom_sheet/common_search_bottom_sheet_widget.dart';
import 'package:rapid_mobile_app/data/widget/container/background_widget.dart';
import 'package:rapid_mobile_app/data/widget/loading_indicator/loading_indicator_widget.dart';
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
    _alertBoxCommonSearch();
  }

  _onTapAppbarLeadingIcon() {
    Get.back();
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

  void _alertBoxCommonSearch() {
    Get.bottomSheet(
      CommonSearchBottomSheetWidget(
        onTap: () => {
          controller.loadMenuData(),
        },
        controller: controller.controllerSearch,
      ),
      enableDrag: true,
      // isDismissible: true,
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
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
      alignment: Alignment.topLeft,
      childWidget: Obx(
        () => SfDataGrid(
          source: ListDataGridSource(
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
          allowSorting: true,
          allowMultiColumnSorting: true,
          showSortNumbers: true,
          columns: _getColumns(),
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
    required this.loadMore,
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

  Future<void> Function() loadMore;

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

  @override
  Future<void> handleLoadMoreRows() async {
    await Future.delayed(const Duration(seconds: 4));
    loadMore();
    notifyListeners();
  }
}
