import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/loginScreen.dart';
import '../Helper/ColorClass.dart';
import '../Model/AddJobDataModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';
import 'package:http/http.dart' as http;

class WorkExperience extends StatefulWidget {
  const WorkExperience({Key? key}) : super(key: key);

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  bool? isSelected;
  final _formKey = GlobalKey<FormState>();

  String dropdownworkPlace = 'Indore';
  var itemsworkPlace =  [ 'Indore','Bhopal','Ujjain','Lalitpur'];

  String dropdownShift = 'Day';
  var itemsShift =  [ 'Day','Night',];

  String dropdownhome = 'Aira';
  var itemshome =  [ 'Aira','RajNagar',];

  String dropdownCity = 'Bpl';
  var itemsCity =  [ 'Bpl','jabalpur','Devas','Ratlam'];
  String? industry;
  String? jobRole;
  String? preferedJobType;
  String? preferedWOrkPlace;
  String? workShift;
  String? homeTown;
  String? preferedCity;

  TextEditingController minSalaryController = TextEditingController();

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

  updateJobPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=b1dbb5f6123dd5280a3c6529078fdddb380841b8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}work_experience'));
    request.fields.addAll({
      'id':userid.toString(),
      'industry': industry.toString(),
      'job_type': isSelected == true ? 'Full Time' : "Part Time",
      'preferred_place': preferedWOrkPlace.toString(),
      'work_shift': workShift.toString(),
      'home_town': homeTown.toString(),
      'preferred_city': preferedCity.toString(),
      'job_role': jobRole.toString(),
      'current_ctc': minSalaryController.text
    });
    print("working here now ${request.fields}");
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
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}work_experience_list'));
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
        industry = jobPreferrence[0]['industry'] == "" || jobPreferrence[0]['industry'] == "null" ? null : jobPreferrence[0]['industry'] ;
        jobRole = jobPreferrence[0]['job_role'] == ""  || jobPreferrence[0]['job_role'] ==  'null' ? null : jobPreferrence[0]['job_role'];
        preferedJobType = jobPreferrence[0]['job_type']  == "" || jobPreferrence[0]['job_type'] == "null" ? null : jobPreferrence[0]['job_type'] ;
        preferedWOrkPlace = jobPreferrence[0]['preferred_place'] == "" || jobPreferrence[0]['preferred_place'] == "null"  ? null : jobPreferrence[0]['preferred_place'];
        workShift = jobPreferrence[0]['work_shift'] == "" || jobPreferrence[0]['work_shift'] == "null" ? null :   jobPreferrence[0]['work_shift'] == "0"  ? "Day" : "Night";
        minSalaryController.text = jobPreferrence[0]['current'] == "" || jobPreferrence[0]['current'] == "null" ? null : jobPreferrence[0]['current'];
        homeTown = jobPreferrence[0]['home_town'] == "" || jobPreferrence[0]['home_town'] == "null" ? null : jobPreferrence[0]['home_town'];
        preferedCity = jobPreferrence[0]['city'] == "" || jobPreferrence[0]['city'] == "null" ? null : jobPreferrence[0]['city'];
        print("home town here ${homeTown}");
        if(preferedJobType == 'Part Time'){
          isSelected = true;
        }
        else{
          isSelected =  false;
        }
       });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "Work Experience",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body: addJobDataModel == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 12,right: 12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),

                        Text("Industry",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                       addJobDataModel == null ? Center(child: CircularProgressIndicator(),) : Card(
                         elevation: 5,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(2.0),
                           child: DropdownButtonHideUnderline(
                             child: DropdownButton(
                               hint: Text("Choose Industry"),
                               isExpanded: true,
                               elevation: 0,
                               value: industry,
                               icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                               items:addJobDataModel!.data!.jobRoles!.map((items) {
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
                                   industry = newValue!;
                                 });
                               },

                             ),
                           ),
                         ),
                       ),
                        SizedBox(height: 10,),
                        Text("Job role",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                     addJobDataModel == null ? Center(child: CircularProgressIndicator(),)  :  Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(2.0),
                         child: DropdownButtonHideUnderline(
                           child: DropdownButton(
                             hint: Text("Choose Industry"),
                             isExpanded: true,
                             elevation: 0,
                             value: jobRole,
                             icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                             items:addJobDataModel!.data!.designations!.map((items) {
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
                                 jobRole = newValue!;
                               });
                             },

                           ),
                         ),
                       ),
                     ),
                        SizedBox(height: 10,),
                        Text("Preferred Job type",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    isSelected = true;
                                  });
                                  print("full time here");
                                },
                                child: Container(
                                   margin: EdgeInsets.all(8.0),
                                  padding:  EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),

                                      border: Border.all(color:isSelected == true  ?  CustomColors.grade:CustomColors.lightback)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Full time')),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    isSelected = false;
                                  });
                                  print("part time here");
                                },
                                child: Container(
                                   margin:  EdgeInsets.all(8.0),
                                  padding:  EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color:isSelected== true  ? CustomColors.lightback: CustomColors.grade)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Part time')),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Preferred WorkPlace",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                hint: Text("Choose WorkPlace"),
                                isExpanded: true,
                                elevation: 0,
                                value: preferedWOrkPlace,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                items:addJobDataModel!.data!.locations!.map((items) {
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
                                    preferedWOrkPlace = newValue!;
                                  });
                                },

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Working Shift",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                hint: Text("Choose Working Shift"),
                                isExpanded: true,
                                elevation: 0,
                                value: workShift,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                items:itemsShift.map((items) {
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
                                    workShift = newValue!;
                                  });
                                },

                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Min Salary/Month",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                           controller: minSalaryController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: 'Min Salary/Month',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Home town",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                hint: Text("Choose Home town"),
                                isExpanded: true,
                                elevation: 0,
                                value: homeTown,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                items:addJobDataModel!.data!.locations!.map(( items) {
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
                                    homeTown = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("Preferred City",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                hint: Text("Choose City"),
                                isExpanded: true,
                                elevation: 0,
                                value: preferedCity,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,),
                                items:addJobDataModel!.data!.locations!.map((items) {
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
                                    preferedCity = newValue!;
                                  });
                                },

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),

                        CustomAppBtn(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
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
