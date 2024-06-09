import 'package:sqltest/db_helper.dart';
import 'package:sqltest/asset_model.dart';
import 'package:intl/intl.dart';

AssetDB gDB = AssetDB();
var gItems = ['KWRUSD'];

void updateItem(String name, String at) async {
/*
  double value = await loadItem(name, at);
  var d = Asset(name, at, value)
  try {
    await gDB.add(d);
  } catch (e) {
    await dh.update(d);
  }
*/
  await gDB.add(Asset(name, at, 0));
}

void updateAll(String at) async {
  await gDB.initDatabase();
  //print(await gDB.getAll());
  var now = DateTime.now();
  String date = DateFormat('yyy-MM-dd').format(now);
  if (at != "") {
    date = at;
  }
  for (int i = 0; i < gItems.length; i++) {
    updateItem(gItems[i], date);
  }
}

Future<List<Asset>> readAll(String at) async {
  var now = DateTime.now();
  String date = DateFormat('yyy-MM-dd').format(now);
  if (at != "") {
    date = at;
  }
  List<Asset> items = [];
  for (int i = 0; i < gItems.length; i++) {
    var d = await gDB.getLastofAt(gItems[i], date);
    if (d != null) {
      items.add(d);
    }
  }
  return items;
}
