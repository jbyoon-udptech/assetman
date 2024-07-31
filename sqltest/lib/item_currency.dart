
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqltest/items.dart';

/*
class Currency {
  final int userId;
  final int id;
  final String title;

  const Currency({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Currency(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
*/

class ItemCurrency extends ItemType {
  final String fname; // from KRWUSD : KRW(to) USD(from)
  final String tname; // to
  ItemCurrency(this.tname, this.fname) : super('$tname$fname', 'CURRENCY');

  @override
  Future<double> load(String at) async {
    const apikey = 'FZ3A82KR6LZ6KZXK';
    var url = 'https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=$fname&to_symbol=$tname&apikey=$apikey';
    var res = await http.read(Uri.parse(url));
    //print('call ItemCurrency[$name] load $url');
    var d = jsonDecode(res)["Time Series FX (Daily)"][at] as Map<String, dynamic>;
    return double.parse(d["4. close"]);
  }
}
