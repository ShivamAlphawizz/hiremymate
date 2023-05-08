/// staus : "true"
/// message : "Success"
/// data : [{"id":"12","name":"Free","amount_inr":"0","duration":"1","description":"First 2 Job Post","amount_usd":"0","condation1":"number_job_post","value1":"2","value2":"ALL","status":"Active","plan_duration_type":"Days","plan_duration_count":"1"},{"id":"13","name":"1.5K","amount_inr":"1500","duration":"30","description":"10 Job Post","amount_usd":"0","condation1":"number_job_post","value1":"10","value2":"ALL","status":"Active","plan_duration_type":"Months","plan_duration_count":"1"},{"id":"14","name":"2K","amount_inr":"2000","duration":"365","description":"20 Job Post","amount_usd":"0","condation1":"number_job_post","value1":"20","value2":"1","status":"Active","plan_duration_type":"Years","plan_duration_count":"1"},{"id":"15","name":"5K","amount_inr":"5000","duration":"365","description":"50 Job Post","amount_usd":"0","condation1":"number_job_post","value1":"50","value2":"1","status":"Active","plan_duration_type":"Years","plan_duration_count":"1"},{"id":"16","name":"10K","amount_inr":"10000","duration":"365","description":"Life Time Free Subscription","amount_usd":"0","condation1":"number_job_post","value1":"ALL","value2":"1","status":"Active","plan_duration_type":"Years","plan_duration_count":"1"}]

class MyPlanModel {
  MyPlanModel({
      String? staus, 
      String? message,
      List<Data>? data,}){
    _staus = staus;
    _message = message;
    _data = data;
}

  MyPlanModel.fromJson(dynamic json) {
    _staus = json['staus'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _staus;
  String? _message;
  List<Data>? _data;
MyPlanModel copyWith({  String? staus,
  String? message,
  List<Data>? data,
}) => MyPlanModel(  staus: staus ?? _staus,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get staus => _staus;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['staus'] = _staus;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "12"
/// name : "Free"
/// amount_inr : "0"
/// duration : "1"
/// description : "First 2 Job Post"
/// amount_usd : "0"
/// condation1 : "number_job_post"
/// value1 : "2"
/// value2 : "ALL"
/// status : "Active"
/// plan_duration_type : "Days"
/// plan_duration_count : "1"

class Data {
  Data({
      String? id, 
      String? name, 
      String? amountInr, 
      String? duration, 
      String? description, 
      String? amountUsd, 
      String? condation1, 
      String? value1, 
      String? value2, 
      String? status, 
      String? planDurationType, 
      String? planDurationCount,}){
    _id = id;
    _name = name;
    _amountInr = amountInr;
    _duration = duration;
    _description = description;
    _amountUsd = amountUsd;
    _condation1 = condation1;
    _value1 = value1;
    _value2 = value2;
    _status = status;
    _planDurationType = planDurationType;
    _planDurationCount = planDurationCount;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _amountInr = json['amount_inr'];
    _duration = json['duration'];
    _description = json['description'];
    _amountUsd = json['amount_usd'];
    _condation1 = json['condation1'];
    _value1 = json['value1'];
    _value2 = json['value2'];
    _status = json['status'];
    _planDurationType = json['plan_duration_type'];
    _planDurationCount = json['plan_duration_count'];
  }
  String? _id;
  String? _name;
  String? _amountInr;
  String? _duration;
  String? _description;
  String? _amountUsd;
  String? _condation1;
  String? _value1;
  String? _value2;
  String? _status;
  String? _planDurationType;
  String? _planDurationCount;
Data copyWith({  String? id,
  String? name,
  String? amountInr,
  String? duration,
  String? description,
  String? amountUsd,
  String? condation1,
  String? value1,
  String? value2,
  String? status,
  String? planDurationType,
  String? planDurationCount,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  amountInr: amountInr ?? _amountInr,
  duration: duration ?? _duration,
  description: description ?? _description,
  amountUsd: amountUsd ?? _amountUsd,
  condation1: condation1 ?? _condation1,
  value1: value1 ?? _value1,
  value2: value2 ?? _value2,
  status: status ?? _status,
  planDurationType: planDurationType ?? _planDurationType,
  planDurationCount: planDurationCount ?? _planDurationCount,
);
  String? get id => _id;
  String? get name => _name;
  String? get amountInr => _amountInr;
  String? get duration => _duration;
  String? get description => _description;
  String? get amountUsd => _amountUsd;
  String? get condation1 => _condation1;
  String? get value1 => _value1;
  String? get value2 => _value2;
  String? get status => _status;
  String? get planDurationType => _planDurationType;
  String? get planDurationCount => _planDurationCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['amount_inr'] = _amountInr;
    map['duration'] = _duration;
    map['description'] = _description;
    map['amount_usd'] = _amountUsd;
    map['condation1'] = _condation1;
    map['value1'] = _value1;
    map['value2'] = _value2;
    map['status'] = _status;
    map['plan_duration_type'] = _planDurationType;
    map['plan_duration_count'] = _planDurationCount;
    return map;
  }

}