/// status : "true"
/// data : [{"id":"258","name":"prem","surname":"kanathe ","email":"prem@gmail.com","city":"","certification_title":null,"about_certificate":null,"certification_number":null,"certification_uni":null,"certification_end":null,"certification_start":null,"home_town":null,"key_skill":null,"preferred_place":null,"hq":"","yp":"1984","mno":"2323232323","ps":"e10adc3949ba59abbe56e057f20f883e","gender":"male","current":"4-6 Lakhs","expected":"10 Lakhs & Above","current_address":"Indore ","language":null,"location":"Indore","job_type":"Full Time","job_role":"Engineering","industry":null,"designation":"Sr. Manager","company_name":null,"qua":"B.Tech","university":null,"highest_qualification":null,"p_year":null,"cgpa":"67","otp":"5137","keyskills":"Flutter ","aofs":null,"exp":"5","resume":"https://developmentalphawizz.com/hiremymate/uploads/resume/Screenshot_20230104_132819_com_huawei_android_launcher.jpg","specialization":"Analytics Jobs","veri":null,"img":"https://developmentalphawizz.com/hiremymate/assets/images/user.svg","certificate":null,"counter":"0","status":"Active","work_here":null,"work_shift":null,"course_type":null,"course_name":null,"m_status":null,"token":null,"project":null,"project_start":null,"project_end":null,"project_role":null,"skill_used":null,"project_description":null,"google_id":null,"profile":"","insert_date":"2023-01-26 08:41:16","joining_date":null,"end_date":null,"course_start":null,"course_end":null,"dob":null,"ps2":"","age":"25","notice_period":"30 Days","is_profile_updated":"1"},{"id":"259","name":"test","surname":"one","email":"testone@gmail.com","city":"","certification_title":null,"about_certificate":null,"certification_number":null,"certification_uni":null,"certification_end":null,"certification_start":null,"home_town":null,"key_skill":null,"preferred_place":null,"hq":"","yp":"2021","mno":"2222222222","ps":"e10adc3949ba59abbe56e057f20f883e","gender":"male","current":"4-6 Lakhs","expected":"0-2 Lakhs","current_address":"Indore ","language":null,"location":"Indore","job_type":"Full Time","job_role":"Engineering","industry":null,"designation":"Manager","company_name":null,"qua":"B.Tech","university":null,"highest_qualification":null,"p_year":null,"cgpa":"55","otp":"4849","keyskills":"Flutter ","aofs":null,"exp":"4","resume":"https://developmentalphawizz.com/hiremymate/uploads/resume/Screenshot_20230104_132819_com_huawei_android_launcher1.jpg","specialization":"Analytics Jobs","veri":null,"img":"https://developmentalphawizz.com/hiremymate/uploads/resume/image_picker4739044352513037158.jpg","certificate":null,"counter":"0","status":"Active","work_here":null,"work_shift":null,"course_type":null,"course_name":null,"m_status":null,"token":null,"project":null,"project_start":null,"project_end":null,"project_role":null,"skill_used":null,"project_description":null,"google_id":null,"profile":"","insert_date":"2023-01-26 08:45:30","joining_date":null,"end_date":null,"course_start":null,"course_end":null,"dob":null,"ps2":"","age":"88","notice_period":"30 Days","is_profile_updated":"1"}]
/// message : "Seekers found"

class SearchCandidateModel {
  SearchCandidateModel({
      String? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  SearchCandidateModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  String? _status;
  List<Data>? _data;
  String? _message;
SearchCandidateModel copyWith({  String? status,
  List<Data>? data,
  String? message,
}) => SearchCandidateModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  String? get status => _status;
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

/// id : "258"
/// name : "prem"
/// surname : "kanathe "
/// email : "prem@gmail.com"
/// city : ""
/// certification_title : null
/// about_certificate : null
/// certification_number : null
/// certification_uni : null
/// certification_end : null
/// certification_start : null
/// home_town : null
/// key_skill : null
/// preferred_place : null
/// hq : ""
/// yp : "1984"
/// mno : "2323232323"
/// ps : "e10adc3949ba59abbe56e057f20f883e"
/// gender : "male"
/// current : "4-6 Lakhs"
/// expected : "10 Lakhs & Above"
/// current_address : "Indore "
/// language : null
/// location : "Indore"
/// job_type : "Full Time"
/// job_role : "Engineering"
/// industry : null
/// designation : "Sr. Manager"
/// company_name : null
/// qua : "B.Tech"
/// university : null
/// highest_qualification : null
/// p_year : null
/// cgpa : "67"
/// otp : "5137"
/// keyskills : "Flutter "
/// aofs : null
/// exp : "5"
/// resume : "https://developmentalphawizz.com/hiremymate/uploads/resume/Screenshot_20230104_132819_com_huawei_android_launcher.jpg"
/// specialization : "Analytics Jobs"
/// veri : null
/// img : "https://developmentalphawizz.com/hiremymate/assets/images/user.svg"
/// certificate : null
/// counter : "0"
/// status : "Active"
/// work_here : null
/// work_shift : null
/// course_type : null
/// course_name : null
/// m_status : null
/// token : null
/// project : null
/// project_start : null
/// project_end : null
/// project_role : null
/// skill_used : null
/// project_description : null
/// google_id : null
/// profile : ""
/// insert_date : "2023-01-26 08:41:16"
/// joining_date : null
/// end_date : null
/// course_start : null
/// course_end : null
/// dob : null
/// ps2 : ""
/// age : "25"
/// notice_period : "30 Days"
/// is_profile_updated : "1"

class Data {
  Data({
      String? id, 
      String? name, 
      String? surname, 
      String? email, 
      String? city, 
      dynamic certificationTitle, 
      dynamic aboutCertificate, 
      dynamic certificationNumber, 
      dynamic certificationUni, 
      dynamic certificationEnd, 
      dynamic certificationStart, 
      dynamic homeTown, 
      dynamic keySkill, 
      dynamic preferredPlace, 
      String? hq, 
      String? yp, 
      String? mno, 
      String? ps, 
      String? gender, 
      String? current, 
      String? expected, 
      String? currentAddress, 
      dynamic language, 
      String? location, 
      String? jobType, 
      String? jobRole, 
      dynamic industry, 
      String? designation, 
      dynamic companyName, 
      String? qua, 
      dynamic university, 
      dynamic highestQualification, 
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
      dynamic certificate, 
      String? counter, 
      String? status, 
      dynamic workHere, 
      dynamic workShift, 
      dynamic courseType, 
      dynamic courseName, 
      dynamic mStatus, 
      dynamic token, 
      dynamic project, 
      dynamic projectStart, 
      dynamic projectEnd, 
      dynamic projectRole, 
      dynamic skillUsed, 
      dynamic projectDescription, 
      dynamic googleId, 
      String? profile, 
      String? insertDate, 
      dynamic joiningDate, 
      dynamic endDate, 
      dynamic courseStart, 
      dynamic courseEnd, 
      dynamic dob, 
      String? ps2, 
      String? age, 
      String? noticePeriod, 
      String? isProfileUpdated,}){
    _id = id;
    _name = name;
    _surname = surname;
    _email = email;
    _city = city;
    _certificationTitle = certificationTitle;
    _aboutCertificate = aboutCertificate;
    _certificationNumber = certificationNumber;
    _certificationUni = certificationUni;
    _certificationEnd = certificationEnd;
    _certificationStart = certificationStart;
    _homeTown = homeTown;
    _keySkill = keySkill;
    _preferredPlace = preferredPlace;
    _hq = hq;
    _yp = yp;
    _mno = mno;
    _ps = ps;
    _gender = gender;
    _current = current;
    _expected = expected;
    _currentAddress = currentAddress;
    _language = language;
    _location = location;
    _jobType = jobType;
    _jobRole = jobRole;
    _industry = industry;
    _designation = designation;
    _companyName = companyName;
    _qua = qua;
    _university = university;
    _highestQualification = highestQualification;
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
    _certificate = certificate;
    _counter = counter;
    _status = status;
    _workHere = workHere;
    _workShift = workShift;
    _courseType = courseType;
    _courseName = courseName;
    _mStatus = mStatus;
    _token = token;
    _project = project;
    _projectStart = projectStart;
    _projectEnd = projectEnd;
    _projectRole = projectRole;
    _skillUsed = skillUsed;
    _projectDescription = projectDescription;
    _googleId = googleId;
    _profile = profile;
    _insertDate = insertDate;
    _joiningDate = joiningDate;
    _endDate = endDate;
    _courseStart = courseStart;
    _courseEnd = courseEnd;
    _dob = dob;
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
    _certificationTitle = json['certification_title'];
    _aboutCertificate = json['about_certificate'];
    _certificationNumber = json['certification_number'];
    _certificationUni = json['certification_uni'];
    _certificationEnd = json['certification_end'];
    _certificationStart = json['certification_start'];
    _homeTown = json['home_town'];
    _keySkill = json['key_skill'];
    _preferredPlace = json['preferred_place'];
    _hq = json['hq'];
    _yp = json['yp'];
    _mno = json['mno'];
    _ps = json['ps'];
    _gender = json['gender'];
    _current = json['current'];
    _expected = json['expected'];
    _currentAddress = json['current_address'];
    _language = json['language'];
    _location = json['location'];
    _jobType = json['job_type'];
    _jobRole = json['job_role'];
    _industry = json['industry'];
    _designation = json['designation'];
    _companyName = json['company_name'];
    _qua = json['qua'];
    _university = json['university'];
    _highestQualification = json['highest_qualification'];
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
    _certificate = json['certificate'];
    _counter = json['counter'];
    _status = json['status'];
    _workHere = json['work_here'];
    _workShift = json['work_shift'];
    _courseType = json['course_type'];
    _courseName = json['course_name'];
    _mStatus = json['m_status'];
    _token = json['token'];
    _project = json['project'];
    _projectStart = json['project_start'];
    _projectEnd = json['project_end'];
    _projectRole = json['project_role'];
    _skillUsed = json['skill_used'];
    _projectDescription = json['project_description'];
    _googleId = json['google_id'];
    _profile = json['profile'];
    _insertDate = json['insert_date'];
    _joiningDate = json['joining_date'];
    _endDate = json['end_date'];
    _courseStart = json['course_start'];
    _courseEnd = json['course_end'];
    _dob = json['dob'];
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
  dynamic _certificationTitle;
  dynamic _aboutCertificate;
  dynamic _certificationNumber;
  dynamic _certificationUni;
  dynamic _certificationEnd;
  dynamic _certificationStart;
  dynamic _homeTown;
  dynamic _keySkill;
  dynamic _preferredPlace;
  String? _hq;
  String? _yp;
  String? _mno;
  String? _ps;
  String? _gender;
  String? _current;
  String? _expected;
  String? _currentAddress;
  dynamic _language;
  String? _location;
  String? _jobType;
  String? _jobRole;
  dynamic _industry;
  String? _designation;
  dynamic _companyName;
  String? _qua;
  dynamic _university;
  dynamic _highestQualification;
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
  dynamic _certificate;
  String? _counter;
  String? _status;
  dynamic _workHere;
  dynamic _workShift;
  dynamic _courseType;
  dynamic _courseName;
  dynamic _mStatus;
  dynamic _token;
  dynamic _project;
  dynamic _projectStart;
  dynamic _projectEnd;
  dynamic _projectRole;
  dynamic _skillUsed;
  dynamic _projectDescription;
  dynamic _googleId;
  String? _profile;
  String? _insertDate;
  dynamic _joiningDate;
  dynamic _endDate;
  dynamic _courseStart;
  dynamic _courseEnd;
  dynamic _dob;
  String? _ps2;
  String? _age;
  String? _noticePeriod;
  String? _isProfileUpdated;
Data copyWith({  String? id,
  String? name,
  String? surname,
  String? email,
  String? city,
  dynamic certificationTitle,
  dynamic aboutCertificate,
  dynamic certificationNumber,
  dynamic certificationUni,
  dynamic certificationEnd,
  dynamic certificationStart,
  dynamic homeTown,
  dynamic keySkill,
  dynamic preferredPlace,
  String? hq,
  String? yp,
  String? mno,
  String? ps,
  String? gender,
  String? current,
  String? expected,
  String? currentAddress,
  dynamic language,
  String? location,
  String? jobType,
  String? jobRole,
  dynamic industry,
  String? designation,
  dynamic companyName,
  String? qua,
  dynamic university,
  dynamic highestQualification,
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
  dynamic certificate,
  String? counter,
  String? status,
  dynamic workHere,
  dynamic workShift,
  dynamic courseType,
  dynamic courseName,
  dynamic mStatus,
  dynamic token,
  dynamic project,
  dynamic projectStart,
  dynamic projectEnd,
  dynamic projectRole,
  dynamic skillUsed,
  dynamic projectDescription,
  dynamic googleId,
  String? profile,
  String? insertDate,
  dynamic joiningDate,
  dynamic endDate,
  dynamic courseStart,
  dynamic courseEnd,
  dynamic dob,
  String? ps2,
  String? age,
  String? noticePeriod,
  String? isProfileUpdated,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  surname: surname ?? _surname,
  email: email ?? _email,
  city: city ?? _city,
  certificationTitle: certificationTitle ?? _certificationTitle,
  aboutCertificate: aboutCertificate ?? _aboutCertificate,
  certificationNumber: certificationNumber ?? _certificationNumber,
  certificationUni: certificationUni ?? _certificationUni,
  certificationEnd: certificationEnd ?? _certificationEnd,
  certificationStart: certificationStart ?? _certificationStart,
  homeTown: homeTown ?? _homeTown,
  keySkill: keySkill ?? _keySkill,
  preferredPlace: preferredPlace ?? _preferredPlace,
  hq: hq ?? _hq,
  yp: yp ?? _yp,
  mno: mno ?? _mno,
  ps: ps ?? _ps,
  gender: gender ?? _gender,
  current: current ?? _current,
  expected: expected ?? _expected,
  currentAddress: currentAddress ?? _currentAddress,
  language: language ?? _language,
  location: location ?? _location,
  jobType: jobType ?? _jobType,
  jobRole: jobRole ?? _jobRole,
  industry: industry ?? _industry,
  designation: designation ?? _designation,
  companyName: companyName ?? _companyName,
  qua: qua ?? _qua,
  university: university ?? _university,
  highestQualification: highestQualification ?? _highestQualification,
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
  certificate: certificate ?? _certificate,
  counter: counter ?? _counter,
  status: status ?? _status,
  workHere: workHere ?? _workHere,
  workShift: workShift ?? _workShift,
  courseType: courseType ?? _courseType,
  courseName: courseName ?? _courseName,
  mStatus: mStatus ?? _mStatus,
  token: token ?? _token,
  project: project ?? _project,
  projectStart: projectStart ?? _projectStart,
  projectEnd: projectEnd ?? _projectEnd,
  projectRole: projectRole ?? _projectRole,
  skillUsed: skillUsed ?? _skillUsed,
  projectDescription: projectDescription ?? _projectDescription,
  googleId: googleId ?? _googleId,
  profile: profile ?? _profile,
  insertDate: insertDate ?? _insertDate,
  joiningDate: joiningDate ?? _joiningDate,
  endDate: endDate ?? _endDate,
  courseStart: courseStart ?? _courseStart,
  courseEnd: courseEnd ?? _courseEnd,
  dob: dob ?? _dob,
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
  dynamic get certificationTitle => _certificationTitle;
  dynamic get aboutCertificate => _aboutCertificate;
  dynamic get certificationNumber => _certificationNumber;
  dynamic get certificationUni => _certificationUni;
  dynamic get certificationEnd => _certificationEnd;
  dynamic get certificationStart => _certificationStart;
  dynamic get homeTown => _homeTown;
  dynamic get keySkill => _keySkill;
  dynamic get preferredPlace => _preferredPlace;
  String? get hq => _hq;
  String? get yp => _yp;
  String? get mno => _mno;
  String? get ps => _ps;
  String? get gender => _gender;
  String? get current => _current;
  String? get expected => _expected;
  String? get currentAddress => _currentAddress;
  dynamic get language => _language;
  String? get location => _location;
  String? get jobType => _jobType;
  String? get jobRole => _jobRole;
  dynamic get industry => _industry;
  String? get designation => _designation;
  dynamic get companyName => _companyName;
  String? get qua => _qua;
  dynamic get university => _university;
  dynamic get highestQualification => _highestQualification;
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
  dynamic get certificate => _certificate;
  String? get counter => _counter;
  String? get status => _status;
  dynamic get workHere => _workHere;
  dynamic get workShift => _workShift;
  dynamic get courseType => _courseType;
  dynamic get courseName => _courseName;
  dynamic get mStatus => _mStatus;
  dynamic get token => _token;
  dynamic get project => _project;
  dynamic get projectStart => _projectStart;
  dynamic get projectEnd => _projectEnd;
  dynamic get projectRole => _projectRole;
  dynamic get skillUsed => _skillUsed;
  dynamic get projectDescription => _projectDescription;
  dynamic get googleId => _googleId;
  String? get profile => _profile;
  String? get insertDate => _insertDate;
  dynamic get joiningDate => _joiningDate;
  dynamic get endDate => _endDate;
  dynamic get courseStart => _courseStart;
  dynamic get courseEnd => _courseEnd;
  dynamic get dob => _dob;
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
    map['certification_title'] = _certificationTitle;
    map['about_certificate'] = _aboutCertificate;
    map['certification_number'] = _certificationNumber;
    map['certification_uni'] = _certificationUni;
    map['certification_end'] = _certificationEnd;
    map['certification_start'] = _certificationStart;
    map['home_town'] = _homeTown;
    map['key_skill'] = _keySkill;
    map['preferred_place'] = _preferredPlace;
    map['hq'] = _hq;
    map['yp'] = _yp;
    map['mno'] = _mno;
    map['ps'] = _ps;
    map['gender'] = _gender;
    map['current'] = _current;
    map['expected'] = _expected;
    map['current_address'] = _currentAddress;
    map['language'] = _language;
    map['location'] = _location;
    map['job_type'] = _jobType;
    map['job_role'] = _jobRole;
    map['industry'] = _industry;
    map['designation'] = _designation;
    map['company_name'] = _companyName;
    map['qua'] = _qua;
    map['university'] = _university;
    map['highest_qualification'] = _highestQualification;
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
    map['certificate'] = _certificate;
    map['counter'] = _counter;
    map['status'] = _status;
    map['work_here'] = _workHere;
    map['work_shift'] = _workShift;
    map['course_type'] = _courseType;
    map['course_name'] = _courseName;
    map['m_status'] = _mStatus;
    map['token'] = _token;
    map['project'] = _project;
    map['project_start'] = _projectStart;
    map['project_end'] = _projectEnd;
    map['project_role'] = _projectRole;
    map['skill_used'] = _skillUsed;
    map['project_description'] = _projectDescription;
    map['google_id'] = _googleId;
    map['profile'] = _profile;
    map['insert_date'] = _insertDate;
    map['joining_date'] = _joiningDate;
    map['end_date'] = _endDate;
    map['course_start'] = _courseStart;
    map['course_end'] = _courseEnd;
    map['dob'] = _dob;
    map['ps2'] = _ps2;
    map['age'] = _age;
    map['notice_period'] = _noticePeriod;
    map['is_profile_updated'] = _isProfileUpdated;
    return map;
  }

}