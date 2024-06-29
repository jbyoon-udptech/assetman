import 'package:flutter/material.dart';
import 'asset_model.dart';

class ItemTable extends StatelessWidget {
  final List<Asset> items;
  const ItemTable(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    var tablerow = [
      TableRow(
        children: [
          TableCell(child: Text('Name')),
          TableCell(child: Text('At')),
          TableCell(child: Text('Value')),
        ],
      ),
    ];

    for (var item in items) {
      tablerow.add(
        TableRow(
          children: [
            TableCell(child: Text(item.name)),
            TableCell(child: Text(item.at)),
            TableCell(child: Text(item.value.toString())),
          ],
        ),
      );
    }

    return Table(
      border: TableBorder.all(),
      children: tablerow,
    );
  }
}
