/// status : true
/// message : "Applied Job Status"
/// data : [{"job_id":"16","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"51","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"47","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"48","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"48","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"48","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"48","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"46","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"52","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"17","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"55","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"73","applied":"1","application_sent":"1","application_view":"1","application_approved":"1","face_to_face":"1","cleared":"0"},{"job_id":"71","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"71","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"71","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"},{"job_id":"64","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0"}]

class ApplyStatusModel {
  ApplyStatusModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ApplyStatusModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
ApplyStatusModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => ApplyStatusModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// job_id : "16"
/// applied : "1"
/// application_sent : "1"
/// application_view : "0"
/// application_approved : "0"
/// face_to_face : "0"
/// cleared : "0"

class Data {
  Data({
      String? jobId, 
      String? applied, 
      String? applicationSent, 
      String? applicationView, 
      String? applicationApproved, 
      String? faceToFace, 
      String? cleared,}){
    _jobId = jobId;
    _applied = applied;
    _applicationSent = applicationSent;
    _applicationView = applicationView;
    _applicationApproved = applicationApproved;
    _faceToFace = faceToFace;
    _cleared = cleared;
}

  Data.fromJson(dynamic json) {
    _jobId = json['job_id'];
    _applied = json['applied'];
    _applicationSent = json['application_sent'];
    _applicationView = json['application_view'];
    _applicationApproved = json['application_approved'];
    _faceToFace = json['face_to_face'];
    _cleared = json['cleared'];
  }
  String? _jobId;
  String? _applied;
  String? _applicationSent;
  String? _applicationView;
  String? _applicationApproved;
  String? _faceToFace;
  String? _cleared;
Data copyWith({  String? jobId,
  String? applied,
  String? applicationSent,
  String? applicationView,
  String? applicationApproved,
  String? faceToFace,
  String? cleared,
}) => Data(  jobId: jobId ?? _jobId,
  applied: applied ?? _applied,
  applicationSent: applicationSent ?? _applicationSent,
  applicationView: applicationView ?? _applicationView,
  applicationApproved: applicationApproved ?? _applicationApproved,
  faceToFace: faceToFace ?? _faceToFace,
  cleared: cleared ?? _cleared,
);
  String? get jobId => _jobId;
  String? get applied => _applied;
  String? get applicationSent => _applicationSent;
  String? get applicationView => _applicationView;
  String? get applicationApproved => _applicationApproved;
  String? get faceToFace => _faceToFace;
  String? get cleared => _cleared;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['job_id'] = _jobId;
    map['applied'] = _applied;
    map['application_sent'] = _applicationSent;
    map['application_view'] = _applicationView;
    map['application_approved'] = _applicationApproved;
    map['face_to_face'] = _faceToFace;
    map['cleared'] = _cleared;
    return map;
  }

}