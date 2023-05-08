/// staus : true
/// message : "Success"
/// data : [{"id":"465","notification_type":"recruiter","title":"Hiii Its Recruiter","message":"Its Recruiter","date1":"27th  January 2023 ","insert_date":"2023-01-27 12:33:08"},{"id":"463","notification_type":"recruiter","title":"Hello Recruiter","message":"Hello Recruiter","date1":"27th  January 2023 ","insert_date":"2023-01-27 07:41:46"},{"id":"461","notification_type":"recruiter","title":"Hello","message":"How are you?","date1":"27th  January 2023 ","insert_date":"2023-01-27 05:34:56"},{"id":"459","notification_type":"recruiter","title":"Vacancy | Urgent Opening for MIS Executive","message":"Company Location : Malad Mindspace No of Requirements: 50 positions Qualification: Minimum HSC Exp: Min 1 yr exp in any Industry can apply. Relieving Letter from all the previous Co. is a must Salary : Upto 3.6L (24K In hand) 6 Days Working Currently WFH but Flexible to WFO Team, JobDekho","date1":"26th  January 2023 ","insert_date":"2023-01-26 14:28:48"},{"id":"458","notification_type":"recruiter","title":"Dear Customer New Plan Introduced","message":"Dear Recruiters, \r\n\r\nA New Plan has been introduced. For Any Business Inquiry please contact to JobDekho Team.\r\n","date1":"26th  January 2023 ","insert_date":"2023-01-26 14:26:23"},{"id":"453","notification_type":"recruiter","title":"New Plan Introduced","message":"Dear Recruiters,\r\n\r\nA New Plan has been introduced.\r\n\r\nFor Any Business Inquiry please contact to JobDekho Team.\r\n\r\n\r\n","date1":"26th  January 2023 ","insert_date":"2023-01-26 05:12:31"},{"id":"446","notification_type":"recruiter","title":"hiiii","message":"hello","date1":"25th  January 2023 ","insert_date":"2023-01-25 06:05:33"}]

class NotificationModel {
  NotificationModel({
      bool? staus, 
      String? message, 
      List<Data>? data,}){
    _staus = staus;
    _message = message;
    _data = data;
}

  NotificationModel.fromJson(dynamic json) {
    _staus = json['staus'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _staus;
  String? _message;
  List<Data>? _data;
NotificationModel copyWith({  bool? staus,
  String? message,
  List<Data>? data,
}) => NotificationModel(  staus: staus ?? _staus,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get staus => _staus;
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

/// id : "465"
/// notification_type : "recruiter"
/// title : "Hiii Its Recruiter"
/// message : "Its Recruiter"
/// date1 : "27th  January 2023 "
/// insert_date : "2023-01-27 12:33:08"

class Data {
  Data({
      String? id, 
      String? notificationType, 
      String? title, 
      String? message, 
      String? date1, 
      String? insertDate,}){
    _id = id;
    _notificationType = notificationType;
    _title = title;
    _message = message;
    _date1 = date1;
    _insertDate = insertDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _notificationType = json['notification_type'];
    _title = json['title'];
    _message = json['message'];
    _date1 = json['date1'];
    _insertDate = json['insert_date'];
  }
  String? _id;
  String? _notificationType;
  String? _title;
  String? _message;
  String? _date1;
  String? _insertDate;
Data copyWith({  String? id,
  String? notificationType,
  String? title,
  String? message,
  String? date1,
  String? insertDate,
}) => Data(  id: id ?? _id,
  notificationType: notificationType ?? _notificationType,
  title: title ?? _title,
  message: message ?? _message,
  date1: date1 ?? _date1,
  insertDate: insertDate ?? _insertDate,
);
  String? get id => _id;
  String? get notificationType => _notificationType;
  String? get title => _title;
  String? get message => _message;
  String? get date1 => _date1;
  String? get insertDate => _insertDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['notification_type'] = _notificationType;
    map['title'] = _title;
    map['message'] = _message;
    map['date1'] = _date1;
    map['insert_date'] = _insertDate;
    return map;
  }

}