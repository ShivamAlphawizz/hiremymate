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

class JobPreference extends StatefulWidget {
  const JobPreference({Key? key}) : super(key: key);

  @override
  State<JobPreference> createState() => _JobPreferenceState();
}

class _JobPreferenceState extends State<JobPreference> {
  final _formKey = GlobalKey<FormState>();
  String? jobRole;

  String? noticePeriod;
  bool allSelected = false;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController joindatecontroller = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController currentSalaryController = TextEditingController();
  TextEditingController skillUsedController  = TextEditingController();


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
        datecontroller = TextEditingController(text: _dateValue);


      });
  }
  Future _selectDate1() async {
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

        joindatecontroller = TextEditingController(text: _dateValue);

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
    Future.delayed(Duration(milliseconds: 300),(){
      return getPreferrencedData();
    });
  }

    /// update job preference

  updateJobPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=b1dbb5f6123dd5280a3c6529078fdddb380841b8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}job_preference'));
    request.fields.addAll({
        'id':userid.toString(),
      'job_role': jobRole.toString(),
      'company_name': companyNameController.text,
      'joining_date': joindatecontroller.text,
      'end_date': datecontroller.text,
      'work_here': allSelected == true ? 'yes': 'no',
      'current_ctc': currentSalaryController.text,
      'key_skills': skillUsedController.text,
      'notice_period': noticePeriod.toString()
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


  ///  job preferrence data
  var jobPreferrence;

  getPreferrencedData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=4ca4db028106c3b1f9d427ffefd3d6b5a5394040'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}job_preference_list'));
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
        print("checking final answer here ${jobPreferrence[0]} andsdsd ${jobPreferrence[0]['joining_date']}");
        jobRole = jobPreferrence[0]['job_role'] == "" || jobPreferrence[0]['job_role'] == "null" ? null : jobPreferrence[0]['job_role'] ;
        companyNameController.text = jobPreferrence[0]['company_name'];
        joindatecontroller.text = jobPreferrence[0]['joining_date'];
        datecontroller.text = jobPreferrence[0]['end_date'];
        currentSalaryController.text = jobPreferrence[0]['current'];
        skillUsedController.text = jobPreferrence[0]['keyskills'];
        noticePeriod = jobPreferrence[0]['notice_period'] == "" || jobPreferrence[0]['notice_period'] == "null" ? null : jobPreferrence[0]['notice_period'];
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
          appBar: customAppBar(text: "Job Preference",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body:addJobDataModel == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
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
                          child: Text("Job role",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                      addJobDataModel == null ? Center(child: CircularProgressIndicator(),) : addJobDataModel!.data!.jobRoles!.length == 0 ? SizedBox() :  Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Choose Job role"),
                              isExpanded: true,
                              elevation: 0,
                              value: jobRole,
                              icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                              items:addJobDataModel!.data!.designations!.map((items) {
                                return DropdownMenuItem(
                                    value: items.name.toString(),
                                    child: Padding(
                                      padding:EdgeInsets.all(8.0),
                                      child: Text(items.name.toString()),
                                    )
                                );
                              }
                              ).toList(),
                              onChanged: (String? newValue){
                                setState(() {
                                  jobRole = newValue!;
                                });
                              },

                            ),
                          ),
                        ),
                      ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Company Name",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: companyNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Your Company Name',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Company Name is required";
                              }
                            },
                          ),
                        ),


                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Joining Date",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: joindatecontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(onTap: (){
                                  _selectDate1();
                                },
                                    child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose Joining Date',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Choose Joining Date is required";
                              }

                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("End Date",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: datecontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: (){
                                  _selectDate();
                                },
                                  child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose End Date',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Choose End Date is required";
                              }

                            },
                          ),
                        ),
                        // SizedBox(height: 5,),
                        //
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
                          child: Text("Current Salary/ Month",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: currentSalaryController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: 'Current Salary/ Month',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Current Salary/ Month is required";
                              }

                            },
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.only(left: 5,top: 5),
                          child: Text("Skill used",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                                controller: skillUsedController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: 'Enter Your Skill used',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Enter Your Skill used";
                                }

                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Notice period",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(2.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text("Choose Notice Period"),
                                isExpanded: true,
                                elevation: 0,
                                value: noticePeriod,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                items:addJobDataModel!.data!.noticePeriod!.map((items) {
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
                                    noticePeriod = newValue!;
                                  });
                                },

                              ),
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
