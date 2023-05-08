
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../AuthenticationView/loginScreen.dart';
import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();


  TextEditingController nameController =  TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController addressController  = TextEditingController();

  String? userType;
  getSharedData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('Role');
    print("user type here ${userType}");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getSharedData();
    });
    Future.delayed(Duration(milliseconds: 400),(){
      // if(userType == 'seeker'){
      //   return getPersonalData();
      // }
      // else{
      //   return getRecruiterDetail();
      // }
      return getPersonalDetail();

    });
    // Future.delayed(Duration(milliseconds: 300),(){
    //   return getRecruiterDetail();
    // });
  }

  getPersonalDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType  = prefs.getString('Role');
    if(userType == "seeker"){
      return getPersonalData();
    }
    else{
      return getRecruiterDetail();
    }
  }

  var recruiterData;
  getRecruiterDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=f1ec907c5cc3c27da75b5336623f196926b2a903'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}recruiter_profile'));
    request.fields.addAll({
      'id': '${userid}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        recruiterData = jsonResponse['data'];
         nameController.text = recruiterData['name'] == "" || recruiterData['name'] == "null" ? null : recruiterData['name'];
         emailController.text = recruiterData['email'] == "" || recruiterData['email'] == "null" ? null :recruiterData['email'];
         mobileController.text = recruiterData['mno'] == "" || recruiterData['mno'] == "null"  ? null : recruiterData['mno'];
         dobcontroller.text = recruiterData['dob'] == "" || recruiterData['dob'] == "null" ? null : recruiterData['dob'];
         dropdowngender =  recruiterData['gender'] == "M" ? "Male" : "Female";
         addressController.text = recruiterData['address'] == "" || recruiterData['address'] == "null"  ? null : recruiterData['address'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String dropdowngender = 'Male';
  var items =  [ 'Male','Female'];
  String dropdownstatus = 'Married ';
  var items1 =  [ 'Married ','Unmarried'];

  String _dateValue = '';
  var dateFormate;
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now(),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: CustomColors.primaryColor,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  CustomColors.primaryColor),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
        dobcontroller = TextEditingController(text: _dateValue);


      });
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  /// for recruiter udpate
  updatePersonalDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=5f3902fb6f3bf35eee79bf1f4acdebb05e626cd7'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}update_recruiter/${userid}'));
    request.fields.addAll({
      'type': 'personal',
      'name': nameController.text,
      'email': emailController.text,
      'mobile': mobileController.text,
      'dob': dobcontroller.text,
      'gender': dropdowngender.toString(),
      'permanent_address': addressController.text
    });
    print("reqest here now ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
      });
      Navigator.pop(context,true);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  /// get personal data
  var personalData;

  getPersonalData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=4ca4db028106c3b1f9d427ffefd3d6b5a5394040'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}personal_details_list'));
    request.fields.addAll({
      'id': '${userid}'
    });
    print("Hello result ${ApiPath.baseUrl}personal_details_list  and ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print("ddddd ${jsonResponse['data'][0]['current_address']}");
      setState(() {
        personalData = jsonResponse['data'];
        nameController.text = personalData[0]['name'];
        emailController.text = personalData[0]['email'];
        mobileController.text = personalData[0]['mno'] == "" || personalData[0]['mno'] == null || personalData[0]['mno'] == "null" ? "" : personalData[0]['mno'];
        dobcontroller.text = personalData[0]['dob'] == "" || personalData[0]['dob'] == "null" || personalData[0]['dob'] == null ? "" :personalData[0]['dob'] ;
        dropdowngender = personalData[0]['gender'];
        addressController.text =  personalData[0]['current_address'];
        dropdownstatus = personalData[0]['m_status'] == "" || personalData[0]['m_status'] == "null"  || personalData[0]['m_status'] == null ? null : personalData[0]['m_status'];

      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  /// for seeker update

  updateSeekerPersonalDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=251268d5b58770849eedf299e59258b59cbf8d64'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}personal_details'));
    request.fields.addAll({
      'id':userid.toString(),
      'first_name': nameController.text,
      'email':emailController.text,
      'mobile': mobileController.text,
      'date_of_birth': dobcontroller.text,
      'gender': dropdowngender.toString(),
      'm_status': dropdownstatus.toString(),
      'current_address': addressController.text
    });
    print("hello here now ${request.fields} and ${ApiPath.baseUrl}personal_details");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true) {
        // setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // });
        Navigator.pop(context);
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(text: "Personal Details",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body:  SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 15,bottom: 15,left: 12,right: 12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Full Name",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: 'Enter Your Name',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Name is required";
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Email",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: ' Enter Your Email',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Email is required";
                                }
                                if (!v.contains("@")) {
                                  return "Enter Valid Email Id";
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Mobile Number",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              maxLength: 10,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              controller: mobileController,
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: 'Enter Your Mobile Number',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Mobile is required";
                                }
                                if(v.length != 10){
                                  return "Enter valid number";
                                }
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Date of birth",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                             onTap: (){
                               _selectDate();
                             },
                              controller: dobcontroller,
                              maxLength: 10,
                              maxLines: 1,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: 'Enter Your Date of birth',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return " Your Date of birth is required";
                                }

                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Gender",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0,right: 0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Choose gender"),
                                  isExpanded: true,
                                  elevation: 0,
                                  value: dropdowngender,
                                  icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                  items:items.map((String items) {
                                    return DropdownMenuItem(
                                        value: items,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(items),
                                        )
                                    );
                                  }
                                  ).toList(),
                                  onChanged: (String? newValue){
                                    setState(() {
                                      dropdowngender = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),
                     userType == "recruiter" ? SizedBox.shrink() :
                     Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Marital Status",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        userType == "recruiter" ? SizedBox.shrink() :    SizedBox(height: 5,),
                        userType == "recruiter" ? SizedBox.shrink() :     Padding(
                          padding: const EdgeInsets.only(left: 0,right: 0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Choose Marital Status"),
                                  isExpanded: true,
                                  elevation: 0,
                                  value: dropdownstatus,
                                  icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                  items:items1.map((String items) {
                                    return DropdownMenuItem(
                                        value: items,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(items),
                                        )
                                    );
                                  }
                                  ).toList(),
                                  onChanged: (String? newValue){
                                    setState(() {
                                      dropdownstatus = newValue!;
                                    });
                                  },

                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Permanent Address",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/4.2,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              child: TextFormField(
                                controller: addressController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    counterText: "",
                                    hintText: 'Enter Your Permanent Address',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 10)
                                ),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Date of Permanent Address";
                                  }

                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),

                        CustomAppBtn(
                          height: 50,
                          title: 'SAVE',
                          onPress: () {
                            if(userType == 'recruiter'){
                              //if (emailController.text.isNotEmpty && nameController.text.isNotEmpty && mobileController.text.isNotEmpty && dobcontroller.text.isNotEmpty) {
                                updatePersonalDetail();

                            }
                            else{
                             // if (emailController.text.isNotEmpty && nameController.text.isNotEmpty && mobileController.text.isNotEmpty && dobcontroller.text.isNotEmpty) {
                              updateSeekerPersonalDetail();
                              // } else {
                              //   const snackBar = SnackBar(
                              //     content: Text('All Fields are required!'),
                              //   );
                              //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              // }
                            }

                          },
                        ),
                        SizedBox(height: 10,),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

}
