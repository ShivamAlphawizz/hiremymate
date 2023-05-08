/// status : true
/// data : [{"id":"23","user_id":"84","job_type":"Full Time","designation":"Executive","qualification":"B.Tech","specialization":"Banking Jobs","passing_year":"2021","experience":"8","salary_range":"monthly","min":"10","max":"15","no_of_vaccancies":"5","job_role":"Film / Music / Entertainment","end_date":"2023-01-31","hiring_process":"Face to Face,HR Round","location":"mumbai","description":"ggfffgg","created_at":"2023-01-23 14:19:16","updated_at":"2023-03-20 13:27:16","rec_name":"Daniel","company_name":"Alphawizz Tech","img":"uploads/resume/image_picker2517057969233359949.jpg","is_applied":false,"is_fav":false,"days":29},{"id":"29","user_id":"84","job_type":"Full Time","designation":"Executive","qualification":"MBA/PGDM","specialization":"BPO - Inbound Call Center Jobs","passing_year":"2019","experience":"4","salary_range":"monthly","min":"15","max":"30","no_of_vaccancies":"4","job_role":"Financial Services","end_date":"2023-01-31","hiring_process":"Face to Face,HR Round","location":"Indore","description":"Dummy description here","created_at":"2023-01-25 05:09:07","updated_at":"2023-01-25 05:09:07","rec_name":"Daniel","company_name":"Alphawizz Tech","img":"uploads/resume/image_picker2517057969233359949.jpg","is_applied":false,"is_fav":false,"days":27},{"id":"33","user_id":"84","job_type":"Part Time","designation":"Sr. Executive","qualification":"B.Tech","specialization":"Banking Jobs","passing_year":"2005","experience":"7","salary_range":"monthly","min":"2000","max":"50000","no_of_vaccancies":"5","job_role":"FinTech / Payments","end_date":"2023-01-31","hiring_process":"Face to Face,HR Round","location":"Indore","description":"zbahs","created_at":"2023-01-26 05:15:04","updated_at":"2023-01-26 05:15:04","rec_name":"Daniel","company_name":"Alphawizz Tech","img":"uploads/resume/image_picker2517057969233359949.jpg","is_applied":false,"is_fav":false,"days":26},{"id":"34","user_id":"84","job_type":"Specially Abled","designation":"Front End Developer","qualification":"B.Tech","specialization":"ADO Jobs 123","passing_year":"2010","experience":"5","salary_range":"monthly","min":"25000","max":"50000","no_of_vaccancies":"4","job_role":"IT Services & Consulting","end_date":"2023-01-31","hiring_process":"Face to Face,HR Round","location":"Mumbai","description":"This is test description","created_at":"2023-01-26 05:37:03","updated_at":"2023-01-27 12:11:38","rec_name":"Daniel","company_name":"Alphawizz Tech","img":"uploads/resume/image_picker2517057969233359949.jpg","is_applied":false,"is_fav":false,"days":26}]
/// message : "All job posts"

class AllJobModel {
  AllJobModel({
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  AllJobModel.fromJson(dynamic json) {
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
AllJobModel copyWith({  bool? status,
  List<Data>? data,
  String? message,
}) => AllJobModel(  status: status ?? _status,
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

/// id : "23"
/// user_id : "84"
/// job_type : "Full Time"
/// designation : "Executive"
/// qualification : "B.Tech"
/// specialization : "Banking Jobs"
/// passing_year : "2021"
/// experience : "8"
/// salary_range : "monthly"
/// min : "10"
/// max : "15"
/// no_of_vaccancies : "5"
/// job_role : "Film / Music / Entertainment"
/// end_date : "2023-01-31"
/// hiring_process : "Face to Face,HR Round"
/// location : "mumbai"
/// description : "ggfffgg"
/// created_at : "2023-01-23 14:19:16"
/// updated_at : "2023-03-20 13:27:16"
/// rec_name : "Daniel"
/// company_name : "Alphawizz Tech"
/// img : "uploads/resume/image_picker2517057969233359949.jpg"
/// is_applied : false
/// is_fav : false
/// days : 29

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
      String? recName, 
      String? companyName, 
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
    map['img'] = _img;
    map['is_applied'] = _isApplied;
    map['is_fav'] = _isFav;
    map['days'] = _days;
    return map;
  }

}