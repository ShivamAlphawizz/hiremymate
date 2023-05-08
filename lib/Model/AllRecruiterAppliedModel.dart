/// status : true
/// data : [{"id":"14","recruiter_id":"84","user_id":"245","job_id":"23","status":"1","applied":"1","application_sent":"1","application_view":"1","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-01-24 05:40:37","updated_at":"2023-03-23 10:12:10","name":"Shiva","designation":"Manager","exp":"9","img":"assets/images/user.svg","location":"Hyderabad","email":"shiva11@gmail.com","mno":"8080808080","qua":"B.Tech","language":null,"current":"666","specialization":"","days":28},{"id":"37","recruiter_id":"84","user_id":"251","job_id":"33","status":"0","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-01-27 05:18:09","updated_at":"2023-01-27 05:18:09","name":"manish","designation":"Vice President","exp":"9","img":"uploads/resume/image_picker1890204561808830073.jpg","location":"Thane","email":"manish@gmail.com","mno":"8108102525","qua":"MBA/PGDM","language":null,"current":"6-8 Lakhs","specialization":"Client Servicing Jobs","days":25},{"id":"39","recruiter_id":"84","user_id":"251","job_id":"23","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-01-27 09:29:03","updated_at":"2023-03-23 07:03:54","name":"manish","designation":"Vice President","exp":"9","img":"uploads/resume/image_picker1890204561808830073.jpg","location":"Thane","email":"manish@gmail.com","mno":"8108102525","qua":"MBA/PGDM","language":null,"current":"6-8 Lakhs","specialization":"Client Servicing Jobs","days":25},{"id":"40","recruiter_id":"84","user_id":"251","job_id":"23","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-01-27 09:36:01","updated_at":"2023-03-23 07:03:54","name":"manish","designation":"Vice President","exp":"9","img":"uploads/resume/image_picker1890204561808830073.jpg","location":"Thane","email":"manish@gmail.com","mno":"8108102525","qua":"MBA/PGDM","language":null,"current":"6-8 Lakhs","specialization":"Client Servicing Jobs","days":25},{"id":"49","recruiter_id":"84","user_id":"286","job_id":"23","status":"1","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-03-20 12:30:17","updated_at":"2023-03-23 07:16:42","name":"Shivam kanathe","designation":"","exp":null,"img":"","location":null,"email":"shivam111@gmail.com","mno":"9696969696","qua":"","language":"","current":"","specialization":"","days":3}]
/// message : "Total Job Apply"

class AllRecruiterAppliedModel {
  AllRecruiterAppliedModel({
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  AllRecruiterAppliedModel.fromJson(dynamic json) {
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
AllRecruiterAppliedModel copyWith({  bool? status,
  List<Data>? data,
  String? message,
}) => AllRecruiterAppliedModel(  status: status ?? _status,
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

/// id : "14"
/// recruiter_id : "84"
/// user_id : "245"
/// job_id : "23"
/// status : "1"
/// applied : "1"
/// application_sent : "1"
/// application_view : "1"
/// application_approved : "0"
/// face_to_face : "0"
/// cleared : "0"
/// created_at : "2023-01-24 05:40:37"
/// updated_at : "2023-03-23 10:12:10"
/// name : "Shiva"
/// designation : "Manager"
/// exp : "9"
/// img : "assets/images/user.svg"
/// location : "Hyderabad"
/// email : "shiva11@gmail.com"
/// mno : "8080808080"
/// qua : "B.Tech"
/// language : null
/// current : "666"
/// specialization : ""
/// days : 28

class Data {
  Data({
      String? id, 
      String? recruiterId, 
      String? userId, 
      String? jobId, 
      String? status, 
      String? applied, 
      String? applicationSent, 
      String? applicationView, 
      String? applicationApproved, 
      String? faceToFace, 
      String? cleared, 
      String? createdAt, 
      String? updatedAt, 
      String? name, 
      String? designation, 
      String? exp, 
      String? img, 
      String? location, 
      String? email, 
      String? mno, 
      String? qua, 
      dynamic language, 
      String? current, 
      String? specialization, 
      num? days,}){
    _id = id;
    _recruiterId = recruiterId;
    _userId = userId;
    _jobId = jobId;
    _status = status;
    _applied = applied;
    _applicationSent = applicationSent;
    _applicationView = applicationView;
    _applicationApproved = applicationApproved;
    _faceToFace = faceToFace;
    _cleared = cleared;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
    _designation = designation;
    _exp = exp;
    _img = img;
    _location = location;
    _email = email;
    _mno = mno;
    _qua = qua;
    _language = language;
    _current = current;
    _specialization = specialization;
    _days = days;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _recruiterId = json['recruiter_id'];
    _userId = json['user_id'];
    _jobId = json['job_id'];
    _status = json['status'];
    _applied = json['applied'];
    _applicationSent = json['application_sent'];
    _applicationView = json['application_view'];
    _applicationApproved = json['application_approved'];
    _faceToFace = json['face_to_face'];
    _cleared = json['cleared'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _name = json['name'];
    _designation = json['designation'];
    _exp = json['exp'];
    _img = json['img'];
    _location = json['location'];
    _email = json['email'];
    _mno = json['mno'];
    _qua = json['qua'];
    _language = json['language'];
    _current = json['current'];
    _specialization = json['specialization'];
    _days = json['days'];
  }
  String? _id;
  String? _recruiterId;
  String? _userId;
  String? _jobId;
  String? _status;
  String? _applied;
  String? _applicationSent;
  String? _applicationView;
  String? _applicationApproved;
  String? _faceToFace;
  String? _cleared;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  String? _designation;
  String? _exp;
  String? _img;
  String? _location;
  String? _email;
  String? _mno;
  String? _qua;
  dynamic _language;
  String? _current;
  String? _specialization;
  num? _days;
Data copyWith({  String? id,
  String? recruiterId,
  String? userId,
  String? jobId,
  String? status,
  String? applied,
  String? applicationSent,
  String? applicationView,
  String? applicationApproved,
  String? faceToFace,
  String? cleared,
  String? createdAt,
  String? updatedAt,
  String? name,
  String? designation,
  String? exp,
  String? img,
  String? location,
  String? email,
  String? mno,
  String? qua,
  dynamic language,
  String? current,
  String? specialization,
  num? days,
}) => Data(  id: id ?? _id,
  recruiterId: recruiterId ?? _recruiterId,
  userId: userId ?? _userId,
  jobId: jobId ?? _jobId,
  status: status ?? _status,
  applied: applied ?? _applied,
  applicationSent: applicationSent ?? _applicationSent,
  applicationView: applicationView ?? _applicationView,
  applicationApproved: applicationApproved ?? _applicationApproved,
  faceToFace: faceToFace ?? _faceToFace,
  cleared: cleared ?? _cleared,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  name: name ?? _name,
  designation: designation ?? _designation,
  exp: exp ?? _exp,
  img: img ?? _img,
  location: location ?? _location,
  email: email ?? _email,
  mno: mno ?? _mno,
  qua: qua ?? _qua,
  language: language ?? _language,
  current: current ?? _current,
  specialization: specialization ?? _specialization,
  days: days ?? _days,
);
  String? get id => _id;
  String? get recruiterId => _recruiterId;
  String? get userId => _userId;
  String? get jobId => _jobId;
  String? get status => _status;
  String? get applied => _applied;
  String? get applicationSent => _applicationSent;
  String? get applicationView => _applicationView;
  String? get applicationApproved => _applicationApproved;
  String? get faceToFace => _faceToFace;
  String? get cleared => _cleared;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get name => _name;
  String? get designation => _designation;
  String? get exp => _exp;
  String? get img => _img;
  String? get location => _location;
  String? get email => _email;
  String? get mno => _mno;
  String? get qua => _qua;
  dynamic get language => _language;
  String? get current => _current;
  String? get specialization => _specialization;
  num? get days => _days;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['recruiter_id'] = _recruiterId;
    map['user_id'] = _userId;
    map['job_id'] = _jobId;
    map['status'] = _status;
    map['applied'] = _applied;
    map['application_sent'] = _applicationSent;
    map['application_view'] = _applicationView;
    map['application_approved'] = _applicationApproved;
    map['face_to_face'] = _faceToFace;
    map['cleared'] = _cleared;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['name'] = _name;
    map['designation'] = _designation;
    map['exp'] = _exp;
    map['img'] = _img;
    map['location'] = _location;
    map['email'] = _email;
    map['mno'] = _mno;
    map['qua'] = _qua;
    map['language'] = _language;
    map['current'] = _current;
    map['specialization'] = _specialization;
    map['days'] = _days;
    return map;
  }

}