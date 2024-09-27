import 'package:intl/intl.dart';
import 'package:sqltest/db_helper.dart';
import 'package:sqltest/asset_model.dart';
import 'package:sqltest/items.dart';
import 'package:sqltest/item_currency.dart';

var krwusd = ItemCurrency('KRW','USD');
var gItems = [krwusd];

AssetDB gDB = AssetDB("asset");

Future<void> updateItem(ItemType item, String at) async {
  var value = await item.load(at);
  await gDB.upsert(Asset(item.name, at, value));
}

Future<void> updateAllItems(String at) async {
  await gDB.initDatabase();
  var now = DateTime.now();
  String date = DateFormat('yyy-MM-dd').format(now);
  if (at != "") {
    date = at;
  }
  for (int i = 0; i < gItems.length; i++) {
    await updateItem(gItems[i], date);
  }
}

Future<List<Asset>> readAllItems(String at) async {
  await gDB.initDatabase();

  var now = DateTime.now();
  String date = DateFormat('yyy-MM-dd').format(now);
  if (at != "") {
    date = at;
  }
  List<Asset> items = [];
  for (int i = 0; i < gItems.length; i++) {
    var d = await gDB.getLastofAt(gItems[i].name, date);
    if (d != null) {
      items.add(d);
    }
  }
  return items;
}
