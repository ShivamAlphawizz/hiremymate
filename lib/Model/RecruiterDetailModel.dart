/// status : "true"
/// data : [{"id":"79","name":" New user","email":"new@gmail.com","mno":"8989898989","ps":"1ab107ac24ed8d3fc4dccffbc2043e0a","org_type":"A Consultant","location":" Mumbai","address":" Prince nagar indore","website":" https://shivamakanthe.com","company":" Shiva Infotech Pvt. Ltd.","token":"","des":" We are the one who works in team better now","veri":"--","img":"uploads/resume/image_picker2328367854700467497.png","plan":null,"otp":"7508","pay":"no","pay_date":null,"type":null,"month":null,"show_on_reg":null,"status":"Active","description":"","pay_count":"0","paypal":null,"counter":"0","google_id":null,"insert_date":"2023-01-18 10:39:37","ps2":"","is_profile_updated":"1","job":[{"id":"6","user_id":"79","job_type":"Full Time","designation":"Sr. Executive","qualification":"B.Tech","passing_year":"2016","experience":"6","salary_range":"monthly","min":"35000.00","max":"100000.00","no_of_vaccancies":"3","job_role":"IT Services & Consulting","end_date":"2023-01-31","hiring_process":"Face to Face,HR Round","location":"Palasiya indore madhya pradesh","description":"Looking for quality candidate yere\n","created_at":"2023-01-19 07:36:06","updated_at":"2023-01-20 11:57:27","rec_name":" New user","company_name":" Shiva Infotech Pvt. Ltd."},{"id":"7","user_id":"79","job_type":"Full Time","designation":"BackEnd Developer","qualification":"B.E.","passing_year":"2017","experience":"4","salary_range":"monthly","min":"20000.00","max":"90000.00","no_of_vaccancies":"4","job_role":"IT Services & Consulting","end_date":"0000-00-00","hiring_process":"Face to Face,HR Round","location":"Bhavarkua indore madhya pradesh india","description":"This is dummy description here for the job you are posting here\n","created_at":"2023-01-19 07:45:00","updated_at":"2023-01-19 07:45:00","rec_name":" New user","company_name":" Shiva Infotech Pvt. Ltd."},{"id":"8","user_id":"79","job_type":"Full Time","designation":"Assistant Manager","qualification":"M.Com","passing_year":"2016","experience":"3","salary_range":"yearly","min":"55888.00","max":"98655.00","no_of_vaccancies":"5","job_role":"Film / Music / Entertainment","end_date":"2023-01-27","hiring_process":"Face to Face,Written-test,Group Discussion,HR Round","location":"g tvgvgvg g g g ","description":"vhggybyybyh hbgv\nyhvgvbhhbhbhbh h. hh h h h h h g g gvgvgvgvvgv","created_at":"2023-01-19 10:01:58","updated_at":"2023-01-19 10:01:58","rec_name":" New user","company_name":" Shiva Infotech Pvt. Ltd."}]}]
/// message : "All recruiters"

class RecruiterDetailModel {
  RecruiterDetailModel({
      String? status, 
      List<Data>? data, 
      String? message,}){
    _status = status;
    _data = data;
    _message = message;
}

  RecruiterDetailModel.fromJson(dynamic json) {
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
RecruiterDetailModel copyWith({  String? status,
  List<Data>? data,
  String? message,
}) => RecruiterDetailModel(  status: status ?? _status,
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

/// id : "79"
/// name : " New user"
/// email : "new@gmail.com"
/// mno : "8989898989"
/// ps : "1ab107ac24ed8d3fc4dccffbc2043e0a"
/// org_type : "A Consultant"
/// location : " Mumbai"
/// address : " Prince nagar indore"
/// website : " https://shivamakanthe.com"
/// company : " Shiva Infotech Pvt. Ltd."
/// token : ""
/// des : " We are the one who works in team better now"
/// veri : "--"
/// img : "uploads/resume/image_picker2328367854700467497.png"
/// plan : null
/// otp : "7508"
/// pay : "no"
/// pay_date : null
/// type : null
/// month : null
/// show_on_reg : null
/// status : "Active"
/// description : ""
/// pay_count : "0"
/// paypal : null
/// counter : "0"
/// google_id : null
/// insert_date : "2023-01-18 10:39:37"
/// ps2 : ""
/// is_profile_updated : "1"
/// job : [{"id":"6","user_id":"79","job_type":"Full Time","designation":"Sr. Executive","qualification":"B.Tech","passing_year":"2016","experience":"6","salary_range":"monthly","min":"35000.00","max":"100000.00","no_of_vaccancies":"3","job_role":"IT Services & Consulting","end_date":"2023-01-31","hiring_process":"Face to Face,HR Round","location":"Palasiya indore madhya pradesh","description":"Looking for quality candidate yere\n","created_at":"2023-01-19 07:36:06","updated_at":"2023-01-20 11:57:27","rec_name":" New user","company_name":" Shiva Infotech Pvt. Ltd."},{"id":"7","user_id":"79","job_type":"Full Time","designation":"BackEnd Developer","qualification":"B.E.","passing_year":"2017","experience":"4","salary_range":"monthly","min":"20000.00","max":"90000.00","no_of_vaccancies":"4","job_role":"IT Services & Consulting","end_date":"0000-00-00","hiring_process":"Face to Face,HR Round","location":"Bhavarkua indore madhya pradesh india","description":"This is dummy description here for the job you are posting here\n","created_at":"2023-01-19 07:45:00","updated_at":"2023-01-19 07:45:00","rec_name":" New user","company_name":" Shiva Infotech Pvt. Ltd."},{"id":"8","user_id":"79","job_type":"Full Time","designation":"Assistant Manager","qualification":"M.Com","passing_year":"2016","experience":"3","salary_range":"yearly","min":"55888.00","max":"98655.00","no_of_vaccancies":"5","job_role":"Film / Music / Entertainment","end_date":"2023-01-27","hiring_process":"Face to Face,Written-test,Group Discussion,HR Round","location":"g tvgvgvg g g g ","description":"vhggybyybyh hbgv\nyhvgvbhhbhbhbh h. hh h h h h h g g gvgvgvgvvgv","created_at":"2023-01-19 10:01:58","updated_at":"2023-01-19 10:01:58","rec_name":" New user","company_name":" Shiva Infotech Pvt. Ltd."}]

class Data {
  Data({
      String? id, 
      String? name, 
      String? email, 
      String? mno, 
      String? ps, 
      String? orgType, 
      String? location, 
      String? address, 
      String? website, 
      String? company, 
      String? token, 
      String? des, 
      String? veri, 
      String? img, 
      dynamic plan, 
      String? otp, 
      String? pay, 
      dynamic payDate, 
      dynamic type, 
      dynamic month, 
      dynamic showOnReg, 
      String? status, 
      String? description, 
      String? payCount, 
      dynamic paypal, 
      String? counter, 
      dynamic googleId, 
      String? insertDate, 
      String? ps2, 
      String? isProfileUpdated, 
      List<Job>? job,}){
    _id = id;
    _name = name;
    _email = email;
    _mno = mno;
    _ps = ps;
    _orgType = orgType;
    _location = location;
    _address = address;
    _website = website;
    _company = company;
    _token = token;
    _des = des;
    _veri = veri;
    _img = img;
    _plan = plan;
    _otp = otp;
    _pay = pay;
    _payDate = payDate;
    _type = type;
    _month = month;
    _showOnReg = showOnReg;
    _status = status;
    _description = description;
    _payCount = payCount;
    _paypal = paypal;
    _counter = counter;
    _googleId = googleId;
    _insertDate = insertDate;
    _ps2 = ps2;
    _isProfileUpdated = isProfileUpdated;
    _job = job;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _mno = json['mno'];
    _ps = json['ps'];
    _orgType = json['org_type'];
    _location = json['location'];
    _address = json['address'];
    _website = json['website'];
    _company = json['company'];
    _token = json['token'];
    _des = json['des'];
    _veri = json['veri'];
    _img = json['img'];
    _plan = json['plan'];
    _otp = json['otp'];
    _pay = json['pay'];
    _payDate = json['pay_date'];
    _type = json['type'];
    _month = json['month'];
    _showOnReg = json['show_on_reg'];
    _status = json['status'];
    _description = json['description'];
    _payCount = json['pay_count'];
    _paypal = json['paypal'];
    _counter = json['counter'];
    _googleId = json['google_id'];
    _insertDate = json['insert_date'];
    _ps2 = json['ps2'];
    _isProfileUpdated = json['is_profile_updated'];
    if (json['job'] != null) {
      _job = [];
      json['job'].forEach((v) {
        _job?.add(Job.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _email;
  String? _mno;
  String? _ps;
  String? _orgType;
  String? _location;
  String? _address;
  String? _website;
  String? _company;
  String? _token;
  String? _des;
  String? _veri;
  String? _img;
  dynamic _plan;
  String? _otp;
  String? _pay;
  dynamic _payDate;
  dynamic _type;
  dynamic _month;
  dynamic _showOnReg;
  String? _status;
  String? _description;
  String? _payCount;
  dynamic _paypal;
  String? _counter;
  dynamic _googleId;
  String? _insertDate;
  String? _ps2;
  String? _isProfileUpdated;
  List<Job>? _job;
Data copyWith({  String? id,
  String? name,
  String? email,
  String? mno,
  String? ps,
  String? orgType,
  String? location,
  String? address,
  String? website,
  String? company,
  String? token,
  String? des,
  String? veri,
  String? img,
  dynamic plan,
  String? otp,
  String? pay,
  dynamic payDate,
  dynamic type,
  dynamic month,
  dynamic showOnReg,
  String? status,
  String? description,
  String? payCount,
  dynamic paypal,
  String? counter,
  dynamic googleId,
  String? insertDate,
  String? ps2,
  String? isProfileUpdated,
  List<Job>? job,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  mno: mno ?? _mno,
  ps: ps ?? _ps,
  orgType: orgType ?? _orgType,
  location: location ?? _location,
  address: address ?? _address,
  website: website ?? _website,
  company: company ?? _company,
  token: token ?? _token,
  des: des ?? _des,
  veri: veri ?? _veri,
  img: img ?? _img,
  plan: plan ?? _plan,
  otp: otp ?? _otp,
  pay: pay ?? _pay,
  payDate: payDate ?? _payDate,
  type: type ?? _type,
  month: month ?? _month,
  showOnReg: showOnReg ?? _showOnReg,
  status: status ?? _status,
  description: description ?? _description,
  payCount: payCount ?? _payCount,
  paypal: paypal ?? _paypal,
  counter: counter ?? _counter,
  googleId: googleId ?? _googleId,
  insertDate: insertDate ?? _insertDate,
  ps2: ps2 ?? _ps2,
  isProfileUpdated: isProfileUpdated ?? _isProfileUpdated,
  job: job ?? _job,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get mno => _mno;
  String? get ps => _ps;
  String? get orgType => _orgType;
  String? get location => _location;
  String? get address => _address;
  String? get website => _website;
  String? get company => _company;
  String? get token => _token;
  String? get des => _des;
  String? get veri => _veri;
  String? get img => _img;
  dynamic get plan => _plan;
  String? get otp => _otp;
  String? get pay => _pay;
  dynamic get payDate => _payDate;
  dynamic get type => _type;
  dynamic get month => _month;
  dynamic get showOnReg => _showOnReg;
  String? get status => _status;
  String? get description => _description;
  String? get payCount => _payCount;
  dynamic get paypal => _paypal;
  String? get counter => _counter;
  dynamic get googleId => _googleId;
  String? get insertDate => _insertDate;
  String? get ps2 => _ps2;
  String? get isProfileUpdated => _isProfileUpdated;
  List<Job>? get job => _job;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['mno'] = _mno;
    map['ps'] = _ps;
    map['org_type'] = _orgType;
    map['location'] = _location;
    map['address'] = _address;
    map['website'] = _website;
    map['company'] = _company;
    map['token'] = _token;
    map['des'] = _des;
    map['veri'] = _veri;
    map['img'] = _img;
    map['plan'] = _plan;
    map['otp'] = _otp;
    map['pay'] = _pay;
    map['pay_date'] = _payDate;
    map['type'] = _type;
    map['month'] = _month;
    map['show_on_reg'] = _showOnReg;
    map['status'] = _status;
    map['description'] = _description;
    map['pay_count'] = _payCount;
    map['paypal'] = _paypal;
    map['counter'] = _counter;
    map['google_id'] = _googleId;
    map['insert_date'] = _insertDate;
    map['ps2'] = _ps2;
    map['is_profile_updated'] = _isProfileUpdated;
    if (_job != null) {
      map['job'] = _job?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "6"
/// user_id : "79"
/// job_type : "Full Time"
/// designation : "Sr. Executive"
/// qualification : "B.Tech"
/// passing_year : "2016"
/// experience : "6"
/// salary_range : "monthly"
/// min : "35000.00"
/// max : "100000.00"
/// no_of_vaccancies : "3"
/// job_role : "IT Services & Consulting"
/// end_date : "2023-01-31"
/// hiring_process : "Face to Face,HR Round"
/// location : "Palasiya indore madhya pradesh"
/// description : "Looking for quality candidate yere\n"
/// created_at : "2023-01-19 07:36:06"
/// updated_at : "2023-01-20 11:57:27"
/// rec_name : " New user"
/// company_name : " Shiva Infotech Pvt. Ltd."

class Job {
  Job({
      String? id, 
      String? userId, 
      String? jobType, 
      String? designation, 
      String? qualification, 
      String? passingYear, 
      String? experience, 
      String? salaryRange, 
      String? min,
      String? img,
      String? max, 
      String? noOfVaccancies, 
      String? jobRole,
      String? specialization,
      String? endDate, 
      String? hiringProcess, 
      String? location, 
      String? description, 
      String? createdAt, 
      String? updatedAt, 
      String? recName,
      bool? isApplied,
      String? companyName,}){
    _id = id;
    _userId = userId;
    _isApplied = isApplied;
    _img = img;
    _jobType = jobType;
    _designation = designation;
    _qualification = qualification;
    _passingYear = passingYear;
    _experience = experience;
    _specialization = specialization;
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
}

  Job.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _img = json['img'];
    _isApplied = json['is_applied'];
    _jobType = json['job_type'];
    _designation = json['designation'];
    _specialization = json['specialization'];
    _qualification = json['qualification'];
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
  }
  String? _id;
  String? _userId;
  String? _jobType;
  String? _designation;
  String? _specialization;
  String? _qualification;
  String? _passingYear;
  String? _experience;
  bool? _isApplied;
  String? _img;
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
Job copyWith({  String? id,
  String? userId,
  String? jobType,
  String? designation,
  String? qualification,
  String? passingYear,
  String? experience,
  String? specialization,
  String? salaryRange,
  bool? isApplied,
  String? min,
  String? max,
  String? img,
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
}) => Job(  id: id ?? _id,
  userId: userId ?? _userId,
  jobType: jobType ?? _jobType,
  designation: designation ?? _designation,
  qualification: qualification ?? _qualification,
  isApplied: isApplied ?? _isApplied,
  passingYear: passingYear ?? _passingYear,
  img:img ?? _img,
  experience: experience ?? _experience,
  salaryRange: salaryRange ?? _salaryRange,
  min: min ?? _min,
  specialization : specialization ?? _specialization,
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
);
  String? get id => _id;
  String? get userId => _userId;
  String? get jobType => _jobType;
  String? get designation => _designation;
  String? get qualification => _qualification;
  String? get passingYear => _passingYear;
  String? get experience => _experience;
  String? get img => _img;
  String? get salaryRange => _salaryRange;
  bool? get isApplied => _isApplied;
  String? get min => _min;
  String? get specialization => _specialization;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['job_type'] = _jobType;
    map['is_applied'] = _isApplied;
    map['designation'] = _designation;
    map['img'] = _img;
    map['qualification'] = _qualification;
    map['passing_year'] = _passingYear;
    map['experience'] = _experience;
    map['salary_range'] = _salaryRange;
    map['specialization'] = _specialization;
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
    return map;
  }
}