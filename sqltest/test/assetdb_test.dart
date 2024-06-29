
import 'package:sqltest/my_logger.dart';
import 'package:sqltest/db_helper.dart';
import 'package:sqltest/asset_model.dart';

void main() async {
  log.d('db test assetDB start');
  AssetDB dh = AssetDB();
  await dh.initDatabase();
  const testKey = 'TESTUSD';

  var d1 = Asset(testKey, '2024-06-01', 1347);
  var d2 = Asset(testKey, '2024-06-03', 1447);
  await dh.delete(d1.name, d1.at);
  await dh.delete(d2.name, d2.at);

  var d = await dh.getAll();
  log.d('show all $d');

  log.d('update d1 1200');
  await dh.update(Asset(d1.name, d1.at, 1200));

  log.d('show all ${await dh.getAll()}');
  log.d('get lastofAt ${await dh.getLastofAt(testKey, '2024-06-02')}');

  log.d('delete all');
  await dh.delete(d1.name, d1.at);
  await dh.delete(d2.name, d2.at);

  d = await dh.getAll();
  log.d('show all $d');

  log.d('db test assetDB end');
}
