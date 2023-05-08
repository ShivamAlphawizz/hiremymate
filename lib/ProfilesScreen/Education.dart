import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/loginScreen.dart';
import '../Helper/ColorClass.dart';
import '../Model/AddJobDataModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';
import 'package:http/http.dart' as http;


class Education extends StatefulWidget {
  const Education({Key? key}) : super(key: key);

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {

  final _formKey = GlobalKey<FormState>();
  String dropdownQalification = '10th ';
  var items =  [ '10th ','12th',"BCA","BE","MCA"];

    String dropdownCourse = 'Computer';
  var items1 =  [ 'Computer','BCA','PGDCA'];
  bool allSelected = false;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController joindatecontroller = TextEditingController();

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
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
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
        startController = TextEditingController(text: _dateValue);
       // joindatecontroller = TextEditingController(text: _dateValue);

      });
  }

  Future _selectDate1() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
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
       // datecontroller = TextEditingController(text: _dateValue);
        endController = TextEditingController(text: _dateValue);

      });
  }

  AddJobDataModel? addJobDataModel;
  addJobDataFunction()async{
    var headers = {
      'Cookie': 'ci_session=b54ea4dc21bb9562023ebd8c74e28340f129a573'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}job_post_lists'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddJobDataModel.fromJson(json.decode(finalResponse));
      setState(() {
        addJobDataModel = jsonResponse;
      });
      print("final data here ${addJobDataModel!.data!.jobRoles![0].name}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 400),(){
      return addJobDataFunction();
    });
    Future.delayed(Duration(milliseconds: 400),(){
      return getWorkExperienceData();
    });
  }

    String? highestQualification;
    TextEditingController  universityController = TextEditingController();
    TextEditingController courseController = TextEditingController();
    TextEditingController specializationController = TextEditingController();
    TextEditingController startController = TextEditingController();
    TextEditingController endController = TextEditingController();
    TextEditingController courseType = TextEditingController();

  updateJobPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=b35cee33a84c39c26f3cbba02e01c453c5dec95f'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}education'));
    request.fields.addAll({
      'id':userid.toString(),
      'highest_qualification':  highestQualification.toString(),
      'university': universityController.text,
      'qualification':'',
      'specialization': specializationController.text,
      'course_start': startController.text,
      'course_end': endController.text,
      'course_type': courseType.text,
      'course_name':courseController.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
        Navigator.pop(context);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  var jobPreferrence;

  getWorkExperienceData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=4ca4db028106c3b1f9d427ffefd3d6b5a5394040'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}education_list'));
    request.fields.addAll({
      'id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        jobPreferrence = jsonResponse['data'];
        print("checking pppppppppppppppppppppppppppppppppppppppppppppppppp ${jobPreferrence}");
        highestQualification = jobPreferrence[0]['highest_qualification'] == "" || jobPreferrence[0]['highest_qualification'] == "null" ? null : jobPreferrence[0]['highest_qualification'] ;
        universityController.text = jobPreferrence[0]['university'] == ""  || jobPreferrence[0]['university'] ==  'null' ? null : jobPreferrence[0]['university'];
        courseController.text = jobPreferrence[0]['course_name']  == "" || jobPreferrence[0]['course_name'] == "null" ? null : jobPreferrence[0]['course_name'] ;
        specializationController.text = jobPreferrence[0]['specialization'] == "" || jobPreferrence[0]['specialization'] == "null"  ? null : jobPreferrence[0]['specialization'];
        startController.text = jobPreferrence[0]['course_start'] == "" || jobPreferrence[0]['course_start'] == "null" ? null :   jobPreferrence[0]['course_start'];
        endController.text = jobPreferrence[0]['course_end'] == "" || jobPreferrence[0]['course_end'] == "null" ? null : jobPreferrence[0]['course_end'];
        courseType.text = jobPreferrence[0]['course_type'] == "" || jobPreferrence[0]['course_type'] == "null" ? null : jobPreferrence[0]['course_type'];

      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "Education",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body: addJobDataModel == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),

                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Highest Qalification",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text("Choose Highest Qalification"),
                                isExpanded: true,
                                elevation: 0,
                                value: highestQualification,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                items:addJobDataModel!.data!.qualifications!.map((items) {
                                  return DropdownMenuItem(
                                      value: items.name.toString(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(items.name.toString()),
                                      )
                                  );
                                }
                                ).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    highestQualification = newValue!;
                                  });
                                },

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("University / Institute",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: universityController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: 'Enter Your University / Institute',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),

                          ),
                        ),

                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Course Name",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: courseController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: 'Enter Your Course Name',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),

                          ),
                        ),


                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Specialization",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: specializationController,
                            decoration: InputDecoration(
                                hintText: 'Enter Your Specialization',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),

                          ),
                        ),
                        // SizedBox(height: 10,),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 5,top: 10),
                        //   child: Row (
                        //     children: [
                        //       InkWell(
                        //         onTap: (){
                        //           setState(() {
                        //             allSelected = ! allSelected;
                        //           });
                        //         },
                        //         child: Container(
                        //           height: 20,
                        //           width: 20,
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(5),
                        //               shape: BoxShape.rectangle,
                        //               border: Border.all(color: CustomColors.lightblackAllText)
                        //           ),
                        //           child: allSelected ?
                        //           Icon( Icons.check ,size: 18,)
                        //               :  SizedBox(),
                        //         ),
                        //       ),
                        //       SizedBox(width: 5,),
                        //       Text("I am Currently working here",style: TextStyle(color: CustomColors.lightblackAllText,fontSize: 13,),),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 15,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Started from",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: startController,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(onTap: (){
                                  _selectDate();
                                },
                                    child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose Joining Date',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("End on",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: endController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: (){
                                      _selectDate1();
                                    },
                                    child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose End Date',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Course type",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: courseType,
                            decoration: InputDecoration(
                                hintText: 'Enter course type',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),

                          ),
                        ),
                        SizedBox(height: 40,),

                          Align(
                            alignment: Alignment.center,
                            child: CustomAppBtn(
                            height: 50,
                            width: 320,
                            title: 'SAVE',
                            onPress: () {
                              updateJobPreference();
                              // if (_formKey.currentState!.validate()) {
                              // } else {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (context) =>LoginScreen()));
                              //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                              // }
                              // const snackBar = SnackBar(
                              //   content: Text('All Fields are required!'),
                              // );
                              // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            },
                        ),
                          ),
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
