
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqltest/items.dart';

/*
https://www.alphavantage.co/documentation/
FZ3A82KR6LZ6KZXK

The API will return the most recent 100 intraday OHLCV bars by default when the outputsize parameter is not set
https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=1hour5min&apikey=FZ3A82KR6LZ6KZXK

https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=FZ3A82KR6LZ6KZXK

Query the most recent full 30 days of intraday data by setting outputsize=full
https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=demo

Query intraday data for a given month in history (e.g., 2009-01). Any month in the last 20+ years (since 2000-01) is supported
https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&month=2009-01&outputsize=full&apikey=demo

*/

class ItemStockUS extends ItemType {
  final String code;
  ItemStockUS(this.code, String name) : super(name, 'StockUS');

  @override
  Future<double> load(String at) async {
    // at = "2024-06-10"
    // final dtAt = DateTime.parse(at);
    // var sdate = DateFormat('yyy-MM-dd').format(dtAt.add(const Duration(days: -1)));

    const apikey = 'FZ3A82KR6LZ6KZXK';
    var url = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$code&apikey=$apikey';
    var res = await http.read(Uri.parse(url));
    //print(res);
    var all = jsonDecode(res)["Time Series (Daily)"];
    if (all == null) {
      return -1;
    }
    Map<String, dynamic> d;
    if (all.containsKey(at)) {
      d = all[at] as Map<String, dynamic>;
    } else {
      d = all[all.keys.first] as Map<String, dynamic>;
    }
    return double.parse(d["4. close"]);
  }
}
