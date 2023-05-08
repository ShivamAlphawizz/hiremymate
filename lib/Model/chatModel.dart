/// status : true
/// data : [{"id":"70","user_from":"recruiter-84","user_to":"seeker-288","job_id":null,"msg":"C:\\fakepath\\38107768-e0ae504c58f1c37f0c78f9218b199078.png","msg_type":"","sender_type":"recruiter","deliver":"0","date":"2023-03-25 12:46:11"},{"id":"69","user_from":"recruiter-84","user_to":"seeker-288","job_id":null,"msg":"hh","msg_type":null,"sender_type":null,"deliver":"0","date":"2023-03-25 12:05:13"},{"id":"48","user_from":"seeker-84","user_to":"recruiter-124","job_id":null,"msg":"how are you i am foine","msg_type":null,"sender_type":null,"deliver":null,"date":"2023-03-25 08:17:56"},{"id":"45","user_from":"seeker-84","user_to":"recruiter-124","job_id":null,"msg":null,"msg_type":null,"sender_type":null,"deliver":null,"date":"2023-03-25 08:06:15"},{"id":"37","user_from":"recruiter-84","user_to":"seeker-287","job_id":null,"msg":"hiiii","msg_type":null,"sender_type":null,"deliver":"1","date":"2023-03-25 05:17:02"},{"id":"36","user_from":"recruiter-84","user_to":"seeker-287","job_id":null,"msg":"hi","msg_type":null,"sender_type":null,"deliver":"1","date":"2023-03-25 05:10:01"},{"id":"28","user_from":"recruiter-84","user_to":"seeker-287","job_id":null,"msg":"fhgjh","msg_type":null,"sender_type":null,"deliver":"1","date":"2023-03-24 10:59:41"}]
/// message : "All Message"

class ChatModel {
  ChatModel({
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  ChatModel.fromJson(dynamic json) {
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
ChatModel copyWith({  bool? status,
  List<Data>? data,
  String? message,
}) => ChatModel(  status: status ?? _status,
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

/// id : "70"
/// user_from : "recruiter-84"
/// user_to : "seeker-288"
/// job_id : null
/// msg : "C:\\fakepath\\38107768-e0ae504c58f1c37f0c78f9218b199078.png"
/// msg_type : ""
/// sender_type : "recruiter"
/// deliver : "0"
/// date : "2023-03-25 12:46:11"

class Data {
  Data({
      String? id, 
      String? userFrom, 
      String? userTo, 
      dynamic jobId, 
      String? msg, 
      String? msgType, 
      String? senderType, 
      String? deliver, 
      String? date,}){
    _id = id;
    _userFrom = userFrom;
    _userTo = userTo;
    _jobId = jobId;
    _msg = msg;
    _msgType = msgType;
    _senderType = senderType;
    _deliver = deliver;
    _date = date;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userFrom = json['user_from'];
    _userTo = json['user_to'];
    _jobId = json['job_id'];
    _msg = json['msg'];
    _msgType = json['msg_type'];
    _senderType = json['sender_type'];
    _deliver = json['deliver'];
    _date = json['date'];
  }
  String? _id;
  String? _userFrom;
  String? _userTo;
  dynamic _jobId;
  String? _msg;
  String? _msgType;
  String? _senderType;
  String? _deliver;
  String? _date;
Data copyWith({  String? id,
  String? userFrom,
  String? userTo,
  dynamic jobId,
  String? msg,
  String? msgType,
  String? senderType,
  String? deliver,
  String? date,
}) => Data(  id: id ?? _id,
  userFrom: userFrom ?? _userFrom,
  userTo: userTo ?? _userTo,
  jobId: jobId ?? _jobId,
  msg: msg ?? _msg,
  msgType: msgType ?? _msgType,
  senderType: senderType ?? _senderType,
  deliver: deliver ?? _deliver,
  date: date ?? _date,
);
  String? get id => _id;
  String? get userFrom => _userFrom;
  String? get userTo => _userTo;
  dynamic get jobId => _jobId;
  String? get msg => _msg;
  String? get msgType => _msgType;
  String? get senderType => _senderType;
  String? get deliver => _deliver;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_from'] = _userFrom;
    map['user_to'] = _userTo;
    map['job_id'] = _jobId;
    map['msg'] = _msg;
    map['msg_type'] = _msgType;
    map['sender_type'] = _senderType;
    map['deliver'] = _deliver;
    map['date'] = _date;
    return map;
  }

}