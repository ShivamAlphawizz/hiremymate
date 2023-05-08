/// status : true
/// data : [{"id":"67","user_id":"84","job_type":"Full Time","designation":"Front End Developer","qualification":"B.Tech","specialization":"DevOps Engineer Jobs","passing_year":"null","experience":"4","salary_range":"monthly","min":"60000","max":"90000","language":"french","no_of_vaccancies":"7","job_role":"Education / Training","end_date":"2023-04-12","hiring_process":"Face to Face,HR Round","location":"Mumbai","description":"This is dummy description\n","created_at":"2023-04-11 08:21:49","updated_at":"2023-04-11 08:21:49","rec_name":"Daniel","company_name":"Alphawizz Tech","compny_description":"This is company detail section here this section is just for testing here and we wll add content in it after some time of testing. New data are here","company_phone":"9874561234","veri":"--","company_email":"alpha@gmail.com","img":"uploads/resume/image_cropper_1681114059383.jpg","is_applied":false,"is_fav":false,"days":0},{"id":"65","user_id":"84","job_type":"Full Time","designation":"Executive","qualification":"B.Tech","specialization":"BPO - Outbound Call Center Jobs","passing_year":"1990","experience":"10","salary_range":"monthly","min":"35000","max":"50000","language":"french","no_of_vaccancies":"4","job_role":"FinTech / Payments","end_date":"2023-04-07","hiring_process":"Face to Face,HR Round","location":"Mumbai","description":"hahaha\n\n","created_at":"2023-04-07 06:35:02","updated_at":"2023-04-11 08:19:46","rec_name":"Daniel","company_name":"Alphawizz Tech","compny_description":"This is company detail section here this section is just for testing here and we wll add content in it after some time of testing. New data are here","company_phone":"9874561234","veri":"--","company_email":"alpha@gmail.com","img":"uploads/resume/image_cropper_1681114059383.jpg","is_applied":false,"is_fav":true,"days":4},{"id":"64","user_id":"126","job_type":"Full Time","designation":"Sr. Executive","qualification":"B.E","specialization":"Ant Jobs Apache Commons Jobs ","passing_year":"1989","experience":"4","salary_range":"monthly","min":"1","max":"2","language":"","no_of_vaccancies":"2","job_role":"Engineering","end_date":"2023-04-13","hiring_process":"Face to Face","location":"--","description":"hfgjgdg","created_at":"2023-04-07 06:31:33","updated_at":"2023-04-07 06:31:33","rec_name":"hiremy mate","company_name":"","compny_description":null,"company_phone":null,"veri":"--","company_email":null,"img":"uploads/resume/Screenshot_20230330-123551.jpg","is_applied":false,"is_fav":true,"days":4},{"id":"63","user_id":"126","job_type":"Full Time","designation":"Sr. Executive","qualification":"B.E","specialization":"Ant Jobs Apache Commons Jobs ","passing_year":"1989","experience":"4","salary_range":"monthly","min":"1","max":"2","language":"","no_of_vaccancies":"2","job_role":"Engineering","end_date":"2023-04-13","hiring_process":"Face to Face","location":"--","description":"hfgjgdg","created_at":"2023-04-07 06:31:20","updated_at":"2023-04-07 06:31:20","rec_name":"hiremy mate","company_name":"","compny_description":null,"company_phone":null,"veri":"--","company_email":null,"img":"uploads/resume/Screenshot_20230330-123551.jpg","is_applied":false,"is_fav":false,"days":4},{"id":"62","user_id":"126","job_type":"Full Time","designation":"Sr. Executive","qualification":"B.E","specialization":"Ant Jobs Apache Commons Jobs ","passing_year":"1989","experience":"4","salary_range":"monthly","min":"1","max":"2","language":"","no_of_vaccancies":"2","job_role":"Engineering","end_date":"2023-04-13","hiring_process":"Face to Face","location":"--","description":"hfgjgdg","created_at":"2023-04-07 06:31:15","updated_at":"2023-04-07 06:31:15","rec_name":"hiremy mate","company_name":"","compny_description":null,"company_phone":null,"veri":"--","company_email":null,"img":"uploads/resume/Screenshot_20230330-123551.jpg","is_applied":false,"is_fav":true,"days":4}]
/// message : "Edit job posts"

class RecentJobModel {
  RecentJobModel({
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  RecentJobModel.fromJson(dynamic json) {
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
RecentJobModel copyWith({  bool? status,
  List<Data>? data,
  String? message,
}) => RecentJobModel(  status: status ?? _status,
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

/// id : "67"
/// user_id : "84"
/// job_type : "Full Time"
/// designation : "Front End Developer"
/// qualification : "B.Tech"
/// specialization : "DevOps Engineer Jobs"
/// passing_year : "null"
/// experience : "4"
/// salary_range : "monthly"
/// min : "60000"
/// max : "90000"
/// language : "french"
/// no_of_vaccancies : "7"
/// job_role : "Education / Training"
/// end_date : "2023-04-12"
/// hiring_process : "Face to Face,HR Round"
/// location : "Mumbai"
/// description : "This is dummy description\n"
/// created_at : "2023-04-11 08:21:49"
/// updated_at : "2023-04-11 08:21:49"
/// rec_name : "Daniel"
/// company_name : "Alphawizz Tech"
/// compny_description : "This is company detail section here this section is just for testing here and we wll add content in it after some time of testing. New data are here"
/// company_phone : "9874561234"
/// veri : "--"
/// company_email : "alpha@gmail.com"
/// img : "uploads/resume/image_cropper_1681114059383.jpg"
/// is_applied : false
/// is_fav : false
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
      String? compnyDescription, 
      String? companyPhone, 
      String? veri, 
      String? companyEmail, 
      String? img, 
      bool? isApplied, 
      bool? isFav, 
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
    _compnyDescription = compnyDescription;
    _companyPhone = companyPhone;
    _veri = veri;
    _companyEmail = companyEmail;
    _img = img;
    _isApplied = isApplied;
    _isFav = isFav;
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
    _compnyDescription = json['compny_description'];
    _companyPhone = json['company_phone'];
    _veri = json['veri'];
    _companyEmail = json['company_email'];
    _img = json['img'];
    _isApplied = json['is_applied'];
    _isFav = json['is_fav'];
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
  String? _compnyDescription;
  String? _companyPhone;
  String? _veri;
  String? _companyEmail;
  String? _img;
  bool? _isApplied;
  bool? _isFav;
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
  String? compnyDescription,
  String? companyPhone,
  String? veri,
  String? companyEmail,
  String? img,
  bool? isApplied,
  bool? isFav,
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
  compnyDescription: compnyDescription ?? _compnyDescription,
  companyPhone: companyPhone ?? _companyPhone,
  veri: veri ?? _veri,
  companyEmail: companyEmail ?? _companyEmail,
  img: img ?? _img,
  isApplied: isApplied ?? _isApplied,
  isFav: isFav ?? _isFav,
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
  String? get compnyDescription => _compnyDescription;
  String? get companyPhone => _companyPhone;
  String? get veri => _veri;
  String? get companyEmail => _companyEmail;
  String? get img => _img;
  bool? get isApplied => _isApplied;
  bool? get isFav => _isFav;
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
    map['compny_description'] = _compnyDescription;
    map['company_phone'] = _companyPhone;
    map['veri'] = _veri;
    map['company_email'] = _companyEmail;
    map['img'] = _img;
    map['is_applied'] = _isApplied;
    map['is_fav'] = _isFav;
    map['days'] = _days;
    return map;
  }

}