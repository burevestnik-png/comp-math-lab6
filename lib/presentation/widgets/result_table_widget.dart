import 'package:comp_math_lab6/domain/controllers/table_results_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/text_styles.dart';

class ResultTable extends GetView<TableResultsController> {
  DataColumn createDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      numeric: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Obx(
          () => fieldText("Results for step ${controller.currentStep}:"),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(
              () => DataTable(
                columns: [
                  createDataColumn("i"),
                  createDataColumn("x"),
                  createDataColumn("y"),
                  createDataColumn("r"),
                ],
                rows: controller.results.map((result) {
                  return DataRow(
                    cells: [
                      DataCell(Text(result.iteration.toString())),
                      DataCell(Text(result.x.toStringAsFixed(5))),
                      DataCell(Text(result.y.toStringAsFixed(12))),
                      DataCell(Text(result.r.toStringAsFixed(12))),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
