import 'package:sqltest/db_helper.dart';
import 'package:sqltest/asset_model.dart';

void main() async {
  print('db test assetDB start');
  AssetDB dh = AssetDB('test');
  await dh.initDatabase();
  const testKey = 'TESTUSD';

  var d1 = Asset(testKey, '2024-06-01', 1347);
  var d2 = Asset(testKey, '2024-06-03', 1447);
  await dh.delete(d1.name, d1.at);
  await dh.delete(d2.name, d2.at);

  var d = await dh.getAll();
  print('show all $d');

  print('update d1 1200');
  await dh.update(Asset(d1.name, d1.at, 1200));

  print('show all ${await dh.getAll()}');
  print('get lastofAt ${await dh.getLastofAt(testKey, '2024-06-02')}');

  print('delete all');
  await dh.delete(d1.name, d1.at);
  await dh.delete(d2.name, d2.at);

  d = await dh.getAll();
  print('show all $d');

  print('db test assetDB end');
}
