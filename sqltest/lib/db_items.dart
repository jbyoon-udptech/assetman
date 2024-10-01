import 'package:intl/intl.dart';
import 'package:sqltest/db_helper.dart';
import 'package:sqltest/asset_model.dart';
import 'package:sqltest/item_stock_kr.dart';
import 'package:sqltest/item_stock_us.dart';
import 'package:sqltest/items.dart';
import 'package:sqltest/item_currency.dart';

var gItems = [ItemCurrency('KRW', 'USD'), ItemStockKR('042660', '한화오션'), ItemStockUS('NVDA', 'NVIDIA')];

AssetDB myDB = AssetDB("asset");

Future<void> updateItem(AssetDB db, ItemType item, String at) async {
  try {
    var value = await item.load(at);
    if (value < 0) return;
    print('updateItem ${item.name} $at $value');
    await db.upsert(Asset(item.name, at, value));
  } on Exception catch (e) {
    print('updateItem error $e');
  }
}

Future<void> clearAllItems(AssetDB db) async {
  await db.initDatabase();
  await db.deleteAll();
}

Future<void> updateAllItems(AssetDB db, String at) async {
  await db.initDatabase();
  var now = DateTime.now();
  String date = DateFormat('yyy-MM-dd').format(now);
  if (at != "") {
    date = at;
  }
  for (int i = 0; i < gItems.length; i++) {
    await updateItem(db, gItems[i], date);
  }
}

Future<List<Asset>> readAllItems(AssetDB db, String at) async {
  await db.initDatabase();

  var now = DateTime.now();
  String date = DateFormat('yyy-MM-dd').format(now);
  if (at != "") {
    date = at;
  }
  List<Asset> items = [];
  for (int i = 0; i < gItems.length; i++) {
    var d = await db.getLastofAt(gItems[i].name, date);
    if (d != null) {
      items.add(d);
    }
  }
  return items;
}

Future<List<Asset>> loadAllItems() async {
  var date = DateTime.now().add(const Duration(days: -6));
  var at = DateFormat('yyy-MM-dd').format(date.add(const Duration(days: -6)));
  // at = "2024-06-10"

  await updateAllItems(myDB, at);
  var items = await readAllItems(myDB, at);
  print('show all items $items');
  return items;
}
