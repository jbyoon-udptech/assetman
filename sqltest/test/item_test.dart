
import 'package:sqltest/db_init.dart';

void main() async {
  print('item test start');

  await updateAllItems('2024-06-10');

  var items = await readAllItems('2024-06-10');
  print('show all items $items');

  print('db test assetDB end');
}
