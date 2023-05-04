class BatchDataAPI {
  BatchDataAPI({
    required this.id,
    required this.sapId,
    required this.name,
  });
  late final int id;
  late final int sapId;
  late final String name;

  BatchDataAPI.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sapId = json['sap_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sap_id'] = sapId;
    _data['name'] = name;
    return _data;
  }
}