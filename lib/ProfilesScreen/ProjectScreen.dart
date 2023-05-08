import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../AuthenticationView/loginScreen.dart';
import '../Helper/ColorClass.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {

  final _formKey = GlobalKey<FormState>();
  bool allSelected = false;
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController joindatecontroller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController roleInProjectController = TextEditingController();
  TextEditingController skillUsedController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
        joindatecontroller = TextEditingController(text: _dateValue);
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
        enddatecontroller = TextEditingController(text: _dateValue);
      });
  }

  updateJobPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=c154403163319fa7bf2c52cac978e7fc7e01938a'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}project'));
    request.fields.addAll({
      'id':userid.toString(),
      'project': titleController.text,
      'project_start': joindatecontroller.text,
      'project_end': enddatecontroller.text,
      'role_in_project': roleInProjectController.text,
      'skill_used': skillUsedController.text,
      'project_description': descriptionController.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResposne = json.decode(finalResult);
      if(jsonResposne['status'] == true){
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResposne['message']}'),
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
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}project_list'));
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
        titleController.text = jobPreferrence[0]['project'] == "" || jobPreferrence[0]['project'] == "null" ? null : jobPreferrence[0]['project'] ;
        joindatecontroller.text = jobPreferrence[0]['project_start'] == ""  || jobPreferrence[0]['project_start'] ==  'null' ? null : jobPreferrence[0]['project_start'];
        enddatecontroller.text = jobPreferrence[0]['project_end']  == "" || jobPreferrence[0]['project_end'] == "null" ? null : jobPreferrence[0]['project_end'] ;
        roleInProjectController.text = jobPreferrence[0]['project_role'] == "" || jobPreferrence[0]['project_role'] == "null"  ? null : jobPreferrence[0]['project_role'];
        skillUsedController.text = jobPreferrence[0]['skill_used'] == "" || jobPreferrence[0]['skill_used'] == "null" ? null :   jobPreferrence[0]['skill_used'];
        descriptionController.text = jobPreferrence[0]['project_description'] == "" || jobPreferrence[0]['project_description'] == "null" ? null : jobPreferrence[0]['project_description'];
      //  courseType.text = jobPreferrence[0]['course_type'] == "" || jobPreferrence[0]['course_type'] == "null" ? null : jobPreferrence[0]['course_type'];
      });
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
      return getWorkExperienceData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "Projects",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body: SingleChildScrollView(
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
                          child: Text("Project title",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: titleController,
                              decoration: InputDecoration(
                                  hintText: 'Enter Your Project title',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                            ),
                          ),
                        ),


                        SizedBox(height: 5,),
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
                            controller: joindatecontroller,
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(onTap: (){
                                  _selectDate();
                                },
                                    child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose Started from',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),

                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Ended on",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            readOnly: true,
                            controller: enddatecontroller,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: (){
                                      _selectDate1();
                                    },
                                    child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose End on',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Role in Project",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: roleInProjectController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: 'Enter Your Role in Project',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                          ),
                        ),

                      SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
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
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Description",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: MediaQuery.of(context).size.height/4.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              controller: descriptionController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: 'Enter Description',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
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
