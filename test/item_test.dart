import 'package:intl/intl.dart';
import 'package:sqltest/db_items.dart';
import 'package:sqltest/db_helper.dart';

void main() async {

  print('db test assetDB start');
  AssetDB tDB = AssetDB("test");

  var date = DateTime.now().add(const Duration(days: -6));
  var at = DateFormat('yyy-MM-dd').format(date.add(const Duration(days: -6)));
  // at = "2024-06-10"

  await clearAllItems(tDB);

  await updateAllItems(tDB, at);

  var items = await readAllItems(tDB, at);
  print('show all items $items');

  print('db test assetDB end');
}
