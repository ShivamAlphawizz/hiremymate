/// status : "true"
/// data : {"id":"66","user_id":"84","job_type":"Full Time","designation":"Front End Developer","qualification":"B.Tech","specialization":"IT Recruitment Job","passing_year":"null","experience":"3","salary_range":"monthly","min":"33000","max":"60000","language":"english","no_of_vaccancies":"5","job_role":"Engineering","end_date":"2023-04-20","hiring_process":"Face to Face,HR Round","location":"Indore","description":"This job description is dummy description here\n\n","created_at":"2023-04-11 07:39:19","updated_at":"2023-04-11 07:39:19","rec_name":"Daniel","company_name":"Alphawizz Tech","days":0}
/// message : "Edit job posts"

class ViewJobModel {
  ViewJobModel({
      String? status, 
      Data? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  ViewJobModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  String? _status;
  Data? _data;
  String? _message;
ViewJobModel copyWith({  String? status,
  Data? data,
  String? message,
}) => ViewJobModel(  status: status ?? _status,
  data: data ?? _data,
  message: message ?? _message,
);
  String? get status => _status;
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

/// id : "66"
/// user_id : "84"
/// job_type : "Full Time"
/// designation : "Front End Developer"
/// qualification : "B.Tech"
/// specialization : "IT Recruitment Job"
/// passing_year : "null"
/// experience : "3"
/// salary_range : "monthly"
/// min : "33000"
/// max : "60000"
/// language : "english"
/// no_of_vaccancies : "5"
/// job_role : "Engineering"
/// end_date : "2023-04-20"
/// hiring_process : "Face to Face,HR Round"
/// location : "Indore"
/// description : "This job description is dummy description here\n\n"
/// created_at : "2023-04-11 07:39:19"
/// updated_at : "2023-04-11 07:39:19"
/// rec_name : "Daniel"
/// company_name : "Alphawizz Tech"
/// days : 0

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
      num? days,}){
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
    _days = days;
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
    _days = json['days'];
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
  num? _days;
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
  num? days,
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
  days: days ?? _days,
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
  num? get days => _days;

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
    map['days'] = _days;
    return map;
  }

}