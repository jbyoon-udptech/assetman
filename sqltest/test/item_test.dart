
import 'package:sqltest/my_logger.dart';
import 'package:sqltest/db_init.dart';

void main() async {
  log.d('item test start');

  await updateAllItems('2024-06-10');

  var items = await readAllItems('2024-06-10');
  log.d('show all items $items');

  log.d('db test assetDB end');
}
