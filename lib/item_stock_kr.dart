
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqltest/items.dart';

/*
function getStockKR(code, date) {
  var edate = toYYYYMMDD(date)
  var sd = new Date(date)
  sd.setDate(date.getDate()-6) // 주말의 경우, 금요일 데이터 얻기 위해서
  var sdate = toYYYYMMDD(sd)
  // https://api.finance.naver.com/siseJson.naver?symbol=039130&requestType=1&startTime=20230419&endTime=20230419&timeframe=day
  var url = `https://api.finance.naver.com/siseJson.naver?symbol=${code}&requestType=1&startTime=${sdate}&endTime=${edate}&timeframe=day`
  var response = UrlFetchApp.fetch(url);
  var tstr = response.getContentText();
  var data = eval(tstr);
  //Logger.log(code, data);
  return data[data.length-1][4]; // 종가
}

    {pos: {r: 6, c: 11}, code: "042660", name: "한화오션"},
    {pos: {r: 6, c: 12}, code: "352820", name: "하이브"},
    {pos: {r: 6, c: 13}, code: "047810", name: "한국항공우주"},
    {pos: {r: 6, c: 14}, code: "012450", name: "한화에어로스페이스"}

*/

class ItemStockKR extends ItemType {
  final String code;
  ItemStockKR(this.code, String name) : super(name, 'StockKR');

  @override
  Future<double> load(String at) async {
    final dtAt = DateTime.parse(at);
    var edate = DateFormat('yyyMMdd').format(dtAt);
    var sdate = DateFormat('yyyMMdd').format(dtAt.add(const Duration(days: -6)));
    var url = 'https://api.finance.naver.com/siseJson.naver?symbol=$code&requestType=1&startTime=$sdate&endTime=$edate&timeframe=day';
    var res = await http.read(Uri.parse(url));
    // print('call ItemStockKR[$code][$name] load $url');
    // print(res);
    // [['날짜', '시가', '고가', '저가', '종가', '거래량', '외국인소진율'], => "날짜"로 변환
    var d = jsonDecode(res.replaceAll("'", '"'));
    var last = d[d.length-1];
    // print(last[4]);
    return last[4].toDouble();
  }
}
