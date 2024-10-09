import 'package:flutter/material.dart';
import 'package:sqltest/asset_model.dart';

class MyDataTable extends StatelessWidget {
  final int counter;
  final List<Asset> items;
  const MyDataTable({super.key, required this.items, required this.counter});

  @override
  Widget build(BuildContext context) {
    print('MyDataTable build : $counter');
    var headers = ['Date', 'Name', 'Value']
        .map((e) => DataColumn(label: Text(e, style: const TextStyle(fontStyle: FontStyle.italic))))
        .toList();
    var rows = items
        .map((e) => DataRow(cells: [
              DataCell(Text('${e.at} ($counter)')),
              DataCell(Text(e.name)),
              DataCell(Text(e.value.toString())),
            ]))
        .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: headers,
        rows: rows,
      ),
    );
  }
}
