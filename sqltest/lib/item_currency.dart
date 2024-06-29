import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sqltest/items.dart';
import 'my_logger.dart';

class ItemCurrency extends ItemType {
  ItemCurrency(String name) : super(name, 'CURRENCY');

  @override
  Future<double> load(String at) async {
    var url = 'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.json';
    log.d('call ItemCurrency[$name] load $url');
    final res = await http.get(Uri.parse(url));
    String body = utf8.decode(res.bodyBytes);
    if (res.statusCode == 200) {
      dynamic list = jsonDecode(body);
      // print(list);
      return list['usd']['krw'];
    } else {
      throw Exception('Failed to load currency');
    }
  }
}
