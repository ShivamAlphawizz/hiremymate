/// status : "true"
/// data : {"id":"79","name":"new","email":"new@gmail.com","mno":"8989898989","ps":"1ab107ac24ed8d3fc4dccffbc2043e0a","org_type":"--","location":"--","address":"--","website":"--","company":"new company","token":"","des":"","veri":"--","img":"https://developmentalphawizz.com/job_portal/assets/images/user.svg","plan":null,"otp":"7273","pay":"no","pay_date":null,"type":null,"month":null,"show_on_reg":null,"status":"Active","description":"","pay_count":"0","paypal":null,"counter":"0","google_id":null,"insert_date":"2023-01-18 10:39:37","ps2":"","is_profile_updated":"1"}
/// message : "Updated recruiter profile"

class RecruiterProfileModel {
  RecruiterProfileModel({
    String? status,
    Data? data,
    String? message,}){
    _status = status;
    _data = data;
    _message = message;
  }

  RecruiterProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  String? _status;
  Data? _data;
  String? _message;
  RecruiterProfileModel copyWith({  String? status,
    Data? data,
    String? message,
  }) => RecruiterProfileModel(  status: status ?? _status,
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

/// id : "79"
/// name : "new"
/// email : "new@gmail.com"
/// mno : "8989898989"
/// ps : "1ab107ac24ed8d3fc4dccffbc2043e0a"
/// org_type : "--"
/// location : "--"
/// address : "--"
/// website : "--"
/// company : "new company"
/// token : ""
/// des : ""
/// veri : "--"
/// img : "https://developmentalphawizz.com/job_portal/assets/images/user.svg"
/// plan : null
/// otp : "7273"
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
    String? isProfileUpdated,}){
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
    return map;
  }

}