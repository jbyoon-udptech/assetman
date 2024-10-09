abstract class ItemType {
  final String name; // from KRWUSD : KRW(from) USD(to)
  final String type;

  ItemType(this.name, this.type);

  Future<double> load(String at) async {
    //print('call ItemType load');
    return -1;
  }
}
