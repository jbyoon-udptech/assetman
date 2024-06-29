import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sqltest/items.dart';

class ItemCurrency extends ItemType {
  ItemCurrency(String name) : super(name, 'CURRENCY');

  @override
  Future<double> load(String at) async {
    // var url =
    //     'https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.$name';
    var url = 'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/usd.json';
    print('call ItemCurrency[$name] load $url');
    final res = await http.get(Uri.parse(url));
    // print("statusCode: ${res.statusCode}");
    // print("responseHeaders: ${res.headers}");
    String body = utf8.decode(res.bodyBytes);
    // print("responseBody: ${body}");
    if (res.statusCode == 200) {
      dynamic list = jsonDecode(body);
      // print(list);
      // print(list['usd']['krw']);
      return list['usd']['krw'];
    } else {
      throw Exception('Failed to load currency');
    }
  }
}
