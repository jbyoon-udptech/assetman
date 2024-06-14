class ItemType {
  String name;
  String type;

  ItemType(this.name, this.type);

  Future<double> load(String at) async {
    print('call ItemType load');
    return 1;
  }
}
