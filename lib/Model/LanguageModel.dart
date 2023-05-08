/// status : true
/// data : [{"name":"english"},{"name":"french"},{"name":"greek"},{"name":"russian"}]
/// message : "Language Get Successfully"

class LanguageModel {
  LanguageModel({
      bool? status,
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  LanguageModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  bool? _status;
  List<Data>? _data;
  String? _message;
LanguageModel copyWith({  bool? status,
  List<Data>? data,
  String? message,
}) => LanguageModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get status => _status;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// name : "english"

class Data {
  Data({
      String? name,}){
    _name = name;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;
Data copyWith({  String? name,
}) => Data(  name: name ?? _name,
);
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}