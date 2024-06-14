import 'package:sqltest/items.dart';

class ItemCurrency extends ItemType {
  ItemCurrency(String name) : super(name, 'CURRENCY');

  @override
  Future<double> load(String at) async {
    print('call ItemCurrency load');
    return 6;
  }
}
