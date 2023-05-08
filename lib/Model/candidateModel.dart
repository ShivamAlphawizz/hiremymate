/// status : true
/// data : [{"id":"214","name":"aditya","surname":"more","email":"aditya@gmail.com","city":"","hq":"","yp":"2010","mno":"8108103344","ps":"e10adc3949ba59abbe56e057f20f883e","gender":"male","current":"400000","expected":"800000","current_address":"Navi Mumbai sector 28","location":"Thane","job_type":"Full Time","job_role":"BPO / Call Centre","designation":"Manager","qua":"M.Com","p_year":null,"cgpa":"66","otp":"8651","keyskills":"Automation and Vba devloper","aofs":null,"exp":"9","resume":"uploads/resume/Resum_testing1.pdf","specialization":"","veri":null,"img":"uploads/resume/image_picker1951989347088607780.jpg","counter":"0","status":"0","token":null,"google_id":null,"profile":"","insert_date":"2023-01-22 13:30:42","ps2":"","age":"34","notice_period":"30 Days","is_profile_updated":"1","job_id":"13","applied_date":"2023-01-22 14:14:41"},{"id":"214","name":"aditya","surname":"more","email":"aditya@gmail.com","city":"","hq":"","yp":"2010","mno":"8108103344","ps":"e10adc3949ba59abbe56e057f20f883e","gender":"male","current":"400000","expected":"800000","current_address":"Navi Mumbai sector 28","location":"Thane","job_type":"Full Time","job_role":"BPO / Call Centre","designation":"Manager","qua":"M.Com","p_year":null,"cgpa":"66","otp":"8651","keyskills":"Automation and Vba devloper","aofs":null,"exp":"9","resume":"uploads/resume/Resum_testing1.pdf","specialization":"","veri":null,"img":"uploads/resume/image_picker1951989347088607780.jpg","counter":"0","status":"0","token":null,"google_id":null,"profile":"","insert_date":"2023-01-22 13:30:42","ps2":"","age":"34","notice_period":"30 Days","is_profile_updated":"1","job_id":"13","applied_date":"2023-01-22 14:51:45"},{"id":"215","name":"rishi","surname":"sawant","email":"rishi@gmail.com","city":"Navi Mumbai","hq":"","yp":"2010","mno":"8108107788","ps":"e10adc3949ba59abbe56e057f20f883e","gender":"male","current":"4-6 Lakhs","expected":"6-8 Lakhs","current_address":"Indore, Pali Hills","location":"Thane","job_type":"Part Time","job_role":"Engineering","designation":"Sr. Manager","qua":"M.Com","p_year":"2003","cgpa":"88","otp":"7332","keyskills":"Handelling Various Project and other Techchcal Knowlige","aofs":null,"exp":"10","resume":"uploads/resume/Text_Resume14.docx","specialization":"","veri":null,"img":"assets/images/user.svg","counter":"0","status":"0","token":null,"google_id":null,"profile":"","insert_date":"2023-01-22 15:20:07","ps2":"123456","age":"55","notice_period":"30 Days","is_profile_updated":"1","job_id":"13","applied_date":"2023-01-22 15:45:55"}]
/// message : "User list applied job"

class CandidateModel {
  CandidateModel({
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  CandidateModel.fromJson(dynamic json) {
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
CandidateModel copyWith({  bool? status,
  List<Data>? data,
  String? message,
}) => CandidateModel(  status: status ?? _status,
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

/// id : "214"
/// name : "aditya"
/// surname : "more"
/// email : "aditya@gmail.com"
/// city : ""
/// hq : ""
/// yp : "2010"
/// mno : "8108103344"
/// ps : "e10adc3949ba59abbe56e057f20f883e"
/// gender : "male"
/// current : "400000"
/// expected : "800000"
/// current_address : "Navi Mumbai sector 28"
/// location : "Thane"
/// job_type : "Full Time"
/// job_role : "BPO / Call Centre"
/// designation : "Manager"
/// qua : "M.Com"
/// p_year : null
/// cgpa : "66"
/// otp : "8651"
/// keyskills : "Automation and Vba devloper"
/// aofs : null
/// exp : "9"
/// resume : "uploads/resume/Resum_testing1.pdf"
/// specialization : ""
/// veri : null
/// img : "uploads/resume/image_picker1951989347088607780.jpg"
/// counter : "0"
/// status : "0"
/// token : null
/// google_id : null
/// profile : ""
/// insert_date : "2023-01-22 13:30:42"
/// ps2 : ""
/// age : "34"
/// notice_period : "30 Days"
/// is_profile_updated : "1"
/// job_id : "13"
/// applied_date : "2023-01-22 14:14:41"

class Data {
  Data({
      String? id, 
      String? name, 
      String? surname, 
      String? email, 
      String? city, 
      String? hq, 
      String? yp, 
      String? mno, 
      String? ps, 
      String? gender, 
      String? current, 
      String? expected, 
      String? currentAddress, 
      String? location, 
      String? jobType, 
      String? jobRole, 
      String? designation, 
      String? qua, 
      dynamic pYear, 
      String? cgpa, 
      String? otp, 
      String? keyskills, 
      dynamic aofs, 
      String? exp, 
      String? resume, 
      String? specialization, 
      dynamic veri, 
      String? img, 
      String? counter, 
      String? status, 
      dynamic token, 
      dynamic googleId, 
      String? profile, 
      String? insertDate, 
      String? ps2, 
      String? age, 
      String? noticePeriod, 
      String? isProfileUpdated, 
      String? jobId, 
      String? appliedDate,}){
    _id = id;
    _name = name;
    _surname = surname;
    _email = email;
    _city = city;
    _hq = hq;
    _yp = yp;
    _mno = mno;
    _ps = ps;
    _gender = gender;
    _current = current;
    _expected = expected;
    _currentAddress = currentAddress;
    _location = location;
    _jobType = jobType;
    _jobRole = jobRole;
    _designation = designation;
    _qua = qua;
    _pYear = pYear;
    _cgpa = cgpa;
    _otp = otp;
    _keyskills = keyskills;
    _aofs = aofs;
    _exp = exp;
    _resume = resume;
    _specialization = specialization;
    _veri = veri;
    _img = img;
    _counter = counter;
    _status = status;
    _token = token;
    _googleId = googleId;
    _profile = profile;
    _insertDate = insertDate;
    _ps2 = ps2;
    _age = age;
    _noticePeriod = noticePeriod;
    _isProfileUpdated = isProfileUpdated;
    _jobId = jobId;
    _appliedDate = appliedDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _surname = json['surname'];
    _email = json['email'];
    _city = json['city'];
    _hq = json['hq'];
    _yp = json['yp'];
    _mno = json['mno'];
    _ps = json['ps'];
    _gender = json['gender'];
    _current = json['current'];
    _expected = json['expected'];
    _currentAddress = json['current_address'];
    _location = json['location'];
    _jobType = json['job_type'];
    _jobRole = json['job_role'];
    _designation = json['designation'];
    _qua = json['qua'];
    _pYear = json['p_year'];
    _cgpa = json['cgpa'];
    _otp = json['otp'];
    _keyskills = json['keyskills'];
    _aofs = json['aofs'];
    _exp = json['exp'];
    _resume = json['resume'];
    _specialization = json['specialization'];
    _veri = json['veri'];
    _img = json['img'];
    _counter = json['counter'];
    _status = json['status'];
    _token = json['token'];
    _googleId = json['google_id'];
    _profile = json['profile'];
    _insertDate = json['insert_date'];
    _ps2 = json['ps2'];
    _age = json['age'];
    _noticePeriod = json['notice_period'];
    _isProfileUpdated = json['is_profile_updated'];
    _jobId = json['job_id'];
    _appliedDate = json['applied_date'];
  }
  String? _id;
  String? _name;
  String? _surname;
  String? _email;
  String? _city;
  String? _hq;
  String? _yp;
  String? _mno;
  String? _ps;
  String? _gender;
  String? _current;
  String? _expected;
  String? _currentAddress;
  String? _location;
  String? _jobType;
  String? _jobRole;
  String? _designation;
  String? _qua;
  dynamic _pYear;
  String? _cgpa;
  String? _otp;
  String? _keyskills;
  dynamic _aofs;
  String? _exp;
  String? _resume;
  String? _specialization;
  dynamic _veri;
  String? _img;
  String? _counter;
  String? _status;
  dynamic _token;
  dynamic _googleId;
  String? _profile;
  String? _insertDate;
  String? _ps2;
  String? _age;
  String? _noticePeriod;
  String? _isProfileUpdated;
  String? _jobId;
  String? _appliedDate;
Data copyWith({  String? id,
  String? name,
  String? surname,
  String? email,
  String? city,
  String? hq,
  String? yp,
  String? mno,
  String? ps,
  String? gender,
  String? current,
  String? expected,
  String? currentAddress,
  String? location,
  String? jobType,
  String? jobRole,
  String? designation,
  String? qua,
  dynamic pYear,
  String? cgpa,
  String? otp,
  String? keyskills,
  dynamic aofs,
  String? exp,
  String? resume,
  String? specialization,
  dynamic veri,
  String? img,
  String? counter,
  String? status,
  dynamic token,
  dynamic googleId,
  String? profile,
  String? insertDate,
  String? ps2,
  String? age,
  String? noticePeriod,
  String? isProfileUpdated,
  String? jobId,
  String? appliedDate,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  surname: surname ?? _surname,
  email: email ?? _email,
  city: city ?? _city,
  hq: hq ?? _hq,
  yp: yp ?? _yp,
  mno: mno ?? _mno,
  ps: ps ?? _ps,
  gender: gender ?? _gender,
  current: current ?? _current,
  expected: expected ?? _expected,
  currentAddress: currentAddress ?? _currentAddress,
  location: location ?? _location,
  jobType: jobType ?? _jobType,
  jobRole: jobRole ?? _jobRole,
  designation: designation ?? _designation,
  qua: qua ?? _qua,
  pYear: pYear ?? _pYear,
  cgpa: cgpa ?? _cgpa,
  otp: otp ?? _otp,
  keyskills: keyskills ?? _keyskills,
  aofs: aofs ?? _aofs,
  exp: exp ?? _exp,
  resume: resume ?? _resume,
  specialization: specialization ?? _specialization,
  veri: veri ?? _veri,
  img: img ?? _img,
  counter: counter ?? _counter,
  status: status ?? _status,
  token: token ?? _token,
  googleId: googleId ?? _googleId,
  profile: profile ?? _profile,
  insertDate: insertDate ?? _insertDate,
  ps2: ps2 ?? _ps2,
  age: age ?? _age,
  noticePeriod: noticePeriod ?? _noticePeriod,
  isProfileUpdated: isProfileUpdated ?? _isProfileUpdated,
  jobId: jobId ?? _jobId,
  appliedDate: appliedDate ?? _appliedDate,
);
  String? get id => _id;
  String? get name => _name;
  String? get surname => _surname;
  String? get email => _email;
  String? get city => _city;
  String? get hq => _hq;
  String? get yp => _yp;
  String? get mno => _mno;
  String? get ps => _ps;
  String? get gender => _gender;
  String? get current => _current;
  String? get expected => _expected;
  String? get currentAddress => _currentAddress;
  String? get location => _location;
  String? get jobType => _jobType;
  String? get jobRole => _jobRole;
  String? get designation => _designation;
  String? get qua => _qua;
  dynamic get pYear => _pYear;
  String? get cgpa => _cgpa;
  String? get otp => _otp;
  String? get keyskills => _keyskills;
  dynamic get aofs => _aofs;
  String? get exp => _exp;
  String? get resume => _resume;
  String? get specialization => _specialization;
  dynamic get veri => _veri;
  String? get img => _img;
  String? get counter => _counter;
  String? get status => _status;
  dynamic get token => _token;
  dynamic get googleId => _googleId;
  String? get profile => _profile;
  String? get insertDate => _insertDate;
  String? get ps2 => _ps2;
  String? get age => _age;
  String? get noticePeriod => _noticePeriod;
  String? get isProfileUpdated => _isProfileUpdated;
  String? get jobId => _jobId;
  String? get appliedDate => _appliedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['surname'] = _surname;
    map['email'] = _email;
    map['city'] = _city;
    map['hq'] = _hq;
    map['yp'] = _yp;
    map['mno'] = _mno;
    map['ps'] = _ps;
    map['gender'] = _gender;
    map['current'] = _current;
    map['expected'] = _expected;
    map['current_address'] = _currentAddress;
    map['location'] = _location;
    map['job_type'] = _jobType;
    map['job_role'] = _jobRole;
    map['designation'] = _designation;
    map['qua'] = _qua;
    map['p_year'] = _pYear;
    map['cgpa'] = _cgpa;
    map['otp'] = _otp;
    map['keyskills'] = _keyskills;
    map['aofs'] = _aofs;
    map['exp'] = _exp;
    map['resume'] = _resume;
    map['specialization'] = _specialization;
    map['veri'] = _veri;
    map['img'] = _img;
    map['counter'] = _counter;
    map['status'] = _status;
    map['token'] = _token;
    map['google_id'] = _googleId;
    map['profile'] = _profile;
    map['insert_date'] = _insertDate;
    map['ps2'] = _ps2;
    map['age'] = _age;
    map['notice_period'] = _noticePeriod;
    map['is_profile_updated'] = _isProfileUpdated;
    map['job_id'] = _jobId;
    map['applied_date'] = _appliedDate;
    return map;
  }

}