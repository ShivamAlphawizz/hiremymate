/// staus : "true"
/// message : "Success"
/// data : {"id":"129","name":"shivaKanathe","surname":"","email":"shiva11@gmail.com","city":"","hq":"","yp":"","mno":"3636363636","ps":"25d55ad283aa400af464c76d713c07ad","gender":"0","current":"","expected":"","current_address":"0","location":"0","job_type":"0","job_role":"","designation":"","qua":"0","p_year":"0","cgpa":"0","otp":"1604","keyskills":"","aofs":"0","exp":"0","resume":"0","specialization":"","veri":"0","img":"assets/images/user.svg","counter":"0","status":"Active","token":"0","google_id":"0","profile":"","insert_date":"2023-01-18 10:04:56","ps2":"","age":"1","notice_period":"0","is_profile_updated":"0"}

class SeekerProfileModel {
  SeekerProfileModel({
    String? staus,
    String? message,
    Data? data,}){
    _staus = staus;
    _message = message;
    _data = data;
  }

  SeekerProfileModel.fromJson(dynamic json) {
    _staus = json['staus'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _staus;
  String? _message;
  Data? _data;
  SeekerProfileModel copyWith({  String? staus,
    String? message,
    Data? data,
  }) => SeekerProfileModel(  staus: staus ?? _staus,
    message: message ?? _message,
    data: data ?? _data,
  );
  String? get staus => _staus;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['staus'] = _staus;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "129"
/// name : "shivaKanathe"
/// surname : ""
/// email : "shiva11@gmail.com"
/// city : ""
/// hq : ""
/// yp : ""
/// mno : "3636363636"
/// ps : "25d55ad283aa400af464c76d713c07ad"
/// gender : "0"
/// current : ""
/// expected : ""
/// current_address : "0"
/// location : "0"
/// job_type : "0"
/// job_role : ""
/// designation : ""
/// qua : "0"
/// p_year : "0"
/// cgpa : "0"
/// otp : "1604"
/// keyskills : ""
/// aofs : "0"
/// exp : "0"
/// resume : "0"
/// specialization : ""
/// veri : "0"
/// img : "assets/images/user.svg"
/// counter : "0"
/// status : "Active"
/// token : "0"
/// google_id : "0"
/// profile : ""
/// insert_date : "2023-01-18 10:04:56"
/// ps2 : ""
/// age : "1"
/// notice_period : "0"
/// is_profile_updated : "0"

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
    String? pYear,
    String? cgpa,
    String? otp,
    String? keyskills,
    String? aofs,
    String? exp,
    String? resume,
    String? specialization,
    String? veri,
    String? img,
    String? counter,
    String? status,
    String? token,
    String? googleId,
    String? profile,
    String? insertDate,
    String? ps2,
    String? age,
    String? noticePeriod,
    String? is_looking,
    String? isProfileUpdated,}){
    _id = id;
    _name = name;
    _surname = surname;
    _email = email;
    _city = city;
    _is_looking = is_looking;
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
    _is_looking = json['is_looking'];
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
  }
  String? _id;
  String? _name;
  String? _surname;
  String? _email;
  String? _city;
  String? _is_looking;
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
  String? _pYear;
  String? _cgpa;
  String? _otp;
  String? _keyskills;
  String? _aofs;
  String? _exp;
  String? _resume;
  String? _specialization;
  String? _veri;
  String? _img;
  String? _counter;
  String? _status;
  String? _token;
  String? _googleId;
  String? _profile;
  String? _insertDate;
  String? _ps2;
  String? _age;
  String? _noticePeriod;
  String? _isProfileUpdated;
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
    String? pYear,
    String? cgpa,
    String? otp,
    String? keyskills,
    String? is_looking,
    String? aofs,
    String? exp,
    String? resume,
    String? specialization,
    String? veri,
    String? img,
    String? counter,
    String? status,
    String? token,
    String? googleId,
    String? profile,
    String? insertDate,
    String? ps2,
    String? age,
    String? noticePeriod,
    String? isProfileUpdated,
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
    is_looking : is_looking ?? _is_looking,
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
  String? get is_looking => _is_looking;
  String? get expected => _expected;
  String? get currentAddress => _currentAddress;
  String? get location => _location;
  String? get jobType => _jobType;
  String? get jobRole => _jobRole;
  String? get designation => _designation;
  String? get qua => _qua;
  String? get pYear => _pYear;
  String? get cgpa => _cgpa;
  String? get otp => _otp;
  String? get keyskills => _keyskills;
  String? get aofs => _aofs;
  String? get exp => _exp;
  String? get resume => _resume;
  String? get specialization => _specialization;
  String? get veri => _veri;
  String? get img => _img;
  String? get counter => _counter;
  String? get status => _status;
  String? get token => _token;
  String? get googleId => _googleId;
  String? get profile => _profile;
  String? get insertDate => _insertDate;
  String? get ps2 => _ps2;
  String? get age => _age;
  String? get noticePeriod => _noticePeriod;
  String? get isProfileUpdated => _isProfileUpdated;

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
    map['is_looking'] = _is_looking;
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
    return map;
  }

}