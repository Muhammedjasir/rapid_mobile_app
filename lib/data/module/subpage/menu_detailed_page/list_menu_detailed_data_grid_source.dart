import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/data/model/metadata_columns_model/metadata_columns_response.dart';
import 'package:rapid_mobile_app/data/widget/text/text_widget.dart';
import 'package:rapid_mobile_app/res/values/colours.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListMenuDetailedDataGridSource extends DataGridSource {
  ListMenuDetailedDataGridSource({
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
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 5),
      child: TextWidget(
          text: (summaryColumn == null)
              ? ''
              : (summaryColumn.summaryType
                          .toString()
                          .replaceAll('GridSummaryType.', ''))
                      .toUpperCase() +
                  ":" +
                  summaryValue,
          textSize: 15,
          textColor: colours.black),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (e) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              e.value.toString(),
            ),
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
