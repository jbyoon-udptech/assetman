class Asset {
  late String name;
  late String at;   // "2023-10-23"
  late double value;
  Asset(this.name, this.at, this.value);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'at': at,
      'value': value,
    };
    return map;
  }

  Asset.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    at = map['at'];
    value = map['value'];
  }

  @override
  String toString() {
    return 'Asset{$name@$at = $value}';
  }
}
