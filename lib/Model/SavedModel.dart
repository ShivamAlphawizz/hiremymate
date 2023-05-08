/// status : true
/// message : "Saved List"
/// data : [{"id":"16","user_id":"85","job_type":"Full Time","designation":"Sr. Manager","qualification":"B.Tech","specialization":"Banking Jobs","passing_year":"2016","experience":"10","salary_range":"monthly","min":"100000","max":"100000","no_of_vaccancies":"2","job_role":"Financial Services","end_date":"2023-01-25","hiring_process":"Face to Face,HR Round,Group Discussion,Written-test","location":"Mumbai","description":"Below is the Job Description\n\nMinimum 5 years of experience in developing Excel Macro using VBA\nAdvanced Excel skills (i.e. complex formulas)\n\nAble to debug/code difficult functions/macros using VBA\n\nAbility to normalize complex data/define referential integrity in Excel/Access\n\nAbility to programmatically manipulate worksheet and cell properties using VBA","created_at":"2023-01-22 13:17:50","updated_at":"2023-01-24 08:22:07","img":"https://developmentalphawizz.com/hiremymate/uploads/resume/image_picker849213644679362589.jpg","rec_name":"Hemal Shah","company_name":"hdfc india pvt ltd","is_applied":false,"is_fav":true}]

class SavedModel {
  SavedModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SavedModel.fromJson(dynamic json) {
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
SavedModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => SavedModel(  status: status ?? _status,
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

/// id : "16"
/// user_id : "85"
/// job_type : "Full Time"
/// designation : "Sr. Manager"
/// qualification : "B.Tech"
/// specialization : "Banking Jobs"
/// passing_year : "2016"
/// experience : "10"
/// salary_range : "monthly"
/// min : "100000"
/// max : "100000"
/// no_of_vaccancies : "2"
/// job_role : "Financial Services"
/// end_date : "2023-01-25"
/// hiring_process : "Face to Face,HR Round,Group Discussion,Written-test"
/// location : "Mumbai"
/// description : "Below is the Job Description\n\nMinimum 5 years of experience in developing Excel Macro using VBA\nAdvanced Excel skills (i.e. complex formulas)\n\nAble to debug/code difficult functions/macros using VBA\n\nAbility to normalize complex data/define referential integrity in Excel/Access\n\nAbility to programmatically manipulate worksheet and cell properties using VBA"
/// created_at : "2023-01-22 13:17:50"
/// updated_at : "2023-01-24 08:22:07"
/// img : "https://developmentalphawizz.com/hiremymate/uploads/resume/image_picker849213644679362589.jpg"
/// rec_name : "Hemal Shah"
/// company_name : "hdfc india pvt ltd"
/// is_applied : false
/// is_fav : true

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
      String? noOfVaccancies, 
      String? jobRole, 
      String? endDate, 
      String? hiringProcess, 
      String? location, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      String? img, 
      String? recName, 
      String? companyName, 
      bool? isApplied, 
      bool? isFav,}){
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
    _noOfVaccancies = noOfVaccancies;
    _jobRole = jobRole;
    _endDate = endDate;
    _hiringProcess = hiringProcess;
    _location = location;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _img = img;
    _recName = recName;
    _companyName = companyName;
    _isApplied = isApplied;
    _isFav = isFav;
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
    _noOfVaccancies = json['no_of_vaccancies'];
    _jobRole = json['job_role'];
    _endDate = json['end_date'];
    _hiringProcess = json['hiring_process'];
    _location = json['location'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _img = json['img'];
    _recName = json['rec_name'];
    _companyName = json['company_name'];
    _isApplied = json['is_applied'];
    _isFav = json['is_fav'];
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
  String? _noOfVaccancies;
  String? _jobRole;
  String? _endDate;
  String? _hiringProcess;
  String? _location;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  String? _img;
  String? _recName;
  String? _companyName;
  bool? _isApplied;
  bool? _isFav;
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
  String? noOfVaccancies,
  String? jobRole,
  String? endDate,
  String? hiringProcess,
  String? location,
  String? description,
  String? createdAt,
  String? updatedAt,
  String? img,
  String? recName,
  String? companyName,
  bool? isApplied,
  bool? isFav,
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
  noOfVaccancies: noOfVaccancies ?? _noOfVaccancies,
  jobRole: jobRole ?? _jobRole,
  endDate: endDate ?? _endDate,
  hiringProcess: hiringProcess ?? _hiringProcess,
  location: location ?? _location,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  img: img ?? _img,
  recName: recName ?? _recName,
  companyName: companyName ?? _companyName,
  isApplied: isApplied ?? _isApplied,
  isFav: isFav ?? _isFav,
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
  String? get noOfVaccancies => _noOfVaccancies;
  String? get jobRole => _jobRole;
  String? get endDate => _endDate;
  String? get hiringProcess => _hiringProcess;
  String? get location => _location;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get img => _img;
  String? get recName => _recName;
  String? get companyName => _companyName;
  bool? get isApplied => _isApplied;
  bool? get isFav => _isFav;

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
    map['no_of_vaccancies'] = _noOfVaccancies;
    map['job_role'] = _jobRole;
    map['end_date'] = _endDate;
    map['hiring_process'] = _hiringProcess;
    map['location'] = _location;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['img'] = _img;
    map['rec_name'] = _recName;
    map['company_name'] = _companyName;
    map['is_applied'] = _isApplied;
    map['is_fav'] = _isFav;
    return map;
  }

}