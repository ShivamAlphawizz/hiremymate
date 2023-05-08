/// status : true
/// data : {"id":"71","user_id":"84","job_type":"Full Time","designation":"Assistant Manager","qualification":"MBA/PGDM","specialization":"Business Analysis Jobs","passing_year":"null","experience":"11","salary_range":"monthly","min":"55000","max":"68000","language":"french","no_of_vaccancies":"7","job_role":"FinTech / Payments","end_date":"2023-04-27","hiring_process":"Written-test,Group Discussion","location":"Jaipur","description":"hhhh","created_at":"2023-04-12 09:53:02","updated_at":"2023-04-12 09:53:02","rec_name":"Daniel","company_name":"Alphawizz Tech","applied":[{"id":"167","user_id":"288","job_id":"71","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-04-12 10:10:58","updated_at":"2023-04-12 11:33:32","resume":"uploads/resume/Invoice_3631.pdf","name":"Test","designation":"","exp":null,"img":"uploads/resume/image_cropper_1681134889436.jpg","location":"Indore","email":"test@gmail.com","mno":"9639639639","qua":"","language":"hindi,english,Marathi ,indori,Gujrati","current":"35888","specialization":"computer ","days":10},{"id":"168","user_id":"288","job_id":"71","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-04-12 10:11:09","updated_at":"2023-04-12 11:33:32","resume":"uploads/resume/Invoice_3631.pdf","name":"Test","designation":"","exp":null,"img":"uploads/resume/image_cropper_1681134889436.jpg","location":"Indore","email":"test@gmail.com","mno":"9639639639","qua":"","language":"hindi,english,Marathi ,indori,Gujrati","current":"35888","specialization":"computer ","days":10},{"id":"169","user_id":"288","job_id":"71","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-04-12 10:14:41","updated_at":"2023-04-12 11:33:32","resume":"uploads/resume/Invoice_3631.pdf","name":"Test","designation":"","exp":null,"img":"uploads/resume/image_cropper_1681134889436.jpg","location":"Indore","email":"test@gmail.com","mno":"9639639639","qua":"","language":"hindi,english,Marathi ,indori,Gujrati","current":"35888","specialization":"computer ","days":10}]}
/// message : "Job Post Details"

class AppliedStudentLIstModel {
  AppliedStudentLIstModel({
      bool? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  AppliedStudentLIstModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _status;
  Data? _data;
  String? _message;
AppliedStudentLIstModel copyWith({  bool? status,
  Data? data,
  String? message,
}) => AppliedStudentLIstModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get status => _status;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// id : "71"
/// user_id : "84"
/// job_type : "Full Time"
/// designation : "Assistant Manager"
/// qualification : "MBA/PGDM"
/// specialization : "Business Analysis Jobs"
/// passing_year : "null"
/// experience : "11"
/// salary_range : "monthly"
/// min : "55000"
/// max : "68000"
/// language : "french"
/// no_of_vaccancies : "7"
/// job_role : "FinTech / Payments"
/// end_date : "2023-04-27"
/// hiring_process : "Written-test,Group Discussion"
/// location : "Jaipur"
/// description : "hhhh"
/// created_at : "2023-04-12 09:53:02"
/// updated_at : "2023-04-12 09:53:02"
/// rec_name : "Daniel"
/// company_name : "Alphawizz Tech"
/// applied : [{"id":"167","user_id":"288","job_id":"71","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-04-12 10:10:58","updated_at":"2023-04-12 11:33:32","resume":"uploads/resume/Invoice_3631.pdf","name":"Test","designation":"","exp":null,"img":"uploads/resume/image_cropper_1681134889436.jpg","location":"Indore","email":"test@gmail.com","mno":"9639639639","qua":"","language":"hindi,english,Marathi ,indori,Gujrati","current":"35888","specialization":"computer ","days":10},{"id":"168","user_id":"288","job_id":"71","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-04-12 10:11:09","updated_at":"2023-04-12 11:33:32","resume":"uploads/resume/Invoice_3631.pdf","name":"Test","designation":"","exp":null,"img":"uploads/resume/image_cropper_1681134889436.jpg","location":"Indore","email":"test@gmail.com","mno":"9639639639","qua":"","language":"hindi,english,Marathi ,indori,Gujrati","current":"35888","specialization":"computer ","days":10},{"id":"169","user_id":"288","job_id":"71","status":"2","applied":"1","application_sent":"1","application_view":"0","application_approved":"0","face_to_face":"0","cleared":"0","created_at":"2023-04-12 10:14:41","updated_at":"2023-04-12 11:33:32","resume":"uploads/resume/Invoice_3631.pdf","name":"Test","designation":"","exp":null,"img":"uploads/resume/image_cropper_1681134889436.jpg","location":"Indore","email":"test@gmail.com","mno":"9639639639","qua":"","language":"hindi,english,Marathi ,indori,Gujrati","current":"35888","specialization":"computer ","days":10}]

class Data {
  Data({
      String? id, 
      String? userId, 
      String? jobType, 
      String? designation, 
      String? qualification, 
      String? specialization, 
      String? passingYear, 
      String? experience, 
      String? salaryRange, 
      String? min, 
      String? max, 
      String? language, 
      String? noOfVaccancies, 
      String? jobRole, 
      String? endDate, 
      String? hiringProcess, 
      String? location, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      String? recName, 
      String? companyName, 
      List<Applied>? applied,}){
    _id = id;
    _userId = userId;
    _jobType = jobType;
    _designation = designation;
    _qualification = qualification;
    _specialization = specialization;
    _passingYear = passingYear;
    _experience = experience;
    _salaryRange = salaryRange;
    _min = min;
    _max = max;
    _language = language;
    _noOfVaccancies = noOfVaccancies;
    _jobRole = jobRole;
    _endDate = endDate;
    _hiringProcess = hiringProcess;
    _location = location;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _recName = recName;
    _companyName = companyName;
    _applied = applied;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _jobType = json['job_type'];
    _designation = json['designation'];
    _qualification = json['qualification'];
    _specialization = json['specialization'];
    _passingYear = json['passing_year'];
    _experience = json['experience'];
    _salaryRange = json['salary_range'];
    _min = json['min'];
    _max = json['max'];
    _language = json['language'];
    _noOfVaccancies = json['no_of_vaccancies'];
    _jobRole = json['job_role'];
    _endDate = json['end_date'];
    _hiringProcess = json['hiring_process'];
    _location = json['location'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _recName = json['rec_name'];
    _companyName = json['company_name'];
    if (json['applied'] != null) {
      _applied = [];
      json['applied'].forEach((v) {
        _applied?.add(Applied.fromJson(v));
      });
    }
  }
  String? _id;
  String? _userId;
  String? _jobType;
  String? _designation;
  String? _qualification;
  String? _specialization;
  String? _passingYear;
  String? _experience;
  String? _salaryRange;
  String? _min;
  String? _max;
  String? _language;
  String? _noOfVaccancies;
  String? _jobRole;
  String? _endDate;
  String? _hiringProcess;
  String? _location;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  String? _recName;
  String? _companyName;
  List<Applied>? _applied;
Data copyWith({  String? id,
  String? userId,
  String? jobType,
  String? designation,
  String? qualification,
  String? specialization,
  String? passingYear,
  String? experience,
  String? salaryRange,
  String? min,
  String? max,
  String? language,
  String? noOfVaccancies,
  String? jobRole,
  String? endDate,
  String? hiringProcess,
  String? location,
  String? description,
  String? createdAt,
  String? updatedAt,
  String? recName,
  String? companyName,
  List<Applied>? applied,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  jobType: jobType ?? _jobType,
  designation: designation ?? _designation,
  qualification: qualification ?? _qualification,
  specialization: specialization ?? _specialization,
  passingYear: passingYear ?? _passingYear,
  experience: experience ?? _experience,
  salaryRange: salaryRange ?? _salaryRange,
  min: min ?? _min,
  max: max ?? _max,
  language: language ?? _language,
  noOfVaccancies: noOfVaccancies ?? _noOfVaccancies,
  jobRole: jobRole ?? _jobRole,
  endDate: endDate ?? _endDate,
  hiringProcess: hiringProcess ?? _hiringProcess,
  location: location ?? _location,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  recName: recName ?? _recName,
  companyName: companyName ?? _companyName,
  applied: applied ?? _applied,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get jobType => _jobType;
  String? get designation => _designation;
  String? get qualification => _qualification;
  String? get specialization => _specialization;
  String? get passingYear => _passingYear;
  String? get experience => _experience;
  String? get salaryRange => _salaryRange;
  String? get min => _min;
  String? get max => _max;
  String? get language => _language;
  String? get noOfVaccancies => _noOfVaccancies;
  String? get jobRole => _jobRole;
  String? get endDate => _endDate;
  String? get hiringProcess => _hiringProcess;
  String? get location => _location;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get recName => _recName;
  String? get companyName => _companyName;
  List<Applied>? get applied => _applied;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['job_type'] = _jobType;
    map['designation'] = _designation;
    map['qualification'] = _qualification;
    map['specialization'] = _specialization;
    map['passing_year'] = _passingYear;
    map['experience'] = _experience;
    map['salary_range'] = _salaryRange;
    map['min'] = _min;
    map['max'] = _max;
    map['language'] = _language;
    map['no_of_vaccancies'] = _noOfVaccancies;
    map['job_role'] = _jobRole;
    map['end_date'] = _endDate;
    map['hiring_process'] = _hiringProcess;
    map['location'] = _location;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['rec_name'] = _recName;
    map['company_name'] = _companyName;
    if (_applied != null) {
      map['applied'] = _applied?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "167"
/// user_id : "288"
/// job_id : "71"
/// status : "2"
/// applied : "1"
/// application_sent : "1"
/// application_view : "0"
/// application_approved : "0"
/// face_to_face : "0"
/// cleared : "0"
/// created_at : "2023-04-12 10:10:58"
/// updated_at : "2023-04-12 11:33:32"
/// resume : "uploads/resume/Invoice_3631.pdf"
/// name : "Test"
/// designation : ""
/// exp : null
/// img : "uploads/resume/image_cropper_1681134889436.jpg"
/// location : "Indore"
/// email : "test@gmail.com"
/// mno : "9639639639"
/// qua : ""
/// language : "hindi,english,Marathi ,indori,Gujrati"
/// current : "35888"
/// specialization : "computer "
/// days : 10

class Applied {
  Applied({
      String? id, 
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
      String? resume, 
      String? name, 
      String? designation, 
      dynamic exp, 
      String? img, 
      String? location, 
      String? email, 
      String? mno, 
      String? qua, 
      String? language, 
      String? current, 
      String? specialization, 
      num? days,}){
    _id = id;
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
    _resume = resume;
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

  Applied.fromJson(dynamic json) {
    _id = json['id'];
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
    _resume = json['resume'];
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
  String? _resume;
  String? _name;
  String? _designation;
  dynamic _exp;
  String? _img;
  String? _location;
  String? _email;
  String? _mno;
  String? _qua;
  String? _language;
  String? _current;
  String? _specialization;
  num? _days;
Applied copyWith({  String? id,
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
  String? resume,
  String? name,
  String? designation,
  dynamic exp,
  String? img,
  String? location,
  String? email,
  String? mno,
  String? qua,
  String? language,
  String? current,
  String? specialization,
  num? days,
}) => Applied(  id: id ?? _id,
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
  resume: resume ?? _resume,
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
  String? get resume => _resume;
  String? get name => _name;
  String? get designation => _designation;
  dynamic get exp => _exp;
  String? get img => _img;
  String? get location => _location;
  String? get email => _email;
  String? get mno => _mno;
  String? get qua => _qua;
  String? get language => _language;
  String? get current => _current;
  String? get specialization => _specialization;
  num? get days => _days;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
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
    map['resume'] = _resume;
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