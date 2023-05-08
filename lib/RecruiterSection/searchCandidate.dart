import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Model/candidateModel.dart';
import 'package:hiremymate/Model/searchCandidateModel.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../Model/AddJobDataModel.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';
import 'package:http/http.dart' as http;

class SearchCandidate extends StatefulWidget {
  const SearchCandidate({Key? key}) : super(key: key);

  @override
  State<SearchCandidate> createState() => _SearchCandidateState();
}

class _SearchCandidateState extends State<SearchCandidate> {
  final _formKey = GlobalKey<FormState>();

  List<String> jobTypeList = [];
  List<String> jobRoleList = [];
  List qualificationList = [];
  List<String> locationList = [];
  List experienceList = [];
  List<String> designationList = [];

  // String? selectedJobType;

  List<dynamic> selectedJobType = [];
  List<dynamic> selectedJobRole = [];
  List<dynamic> selectedLocation = [];
  List<dynamic> selectedDesignation = [];

  TextEditingController  designationController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  CandidateModel? candidateModel;

  SearchCandidateModel? searchCandidateModel;

  searchCandidate()async{
    String finalJobType = selectedJobType.join(",");
    String finaljobRole = selectedJobRole.join(",");
    String finalLocation = selectedLocation.join(",");
    String finalDesignation = selectedDesignation.join(",");

    SharedPreferences prefs  = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=e13ea541f84a1c92ed1fd32bb8bba040da4408aa'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}search_candidate'));
    request.fields.addAll({
      'job_type':finalJobType,
      'location': finalLocation,
      'designation': finalDesignation,
      'qualification': '',
      'experience': '',
      'specialization': '',
      'skill': '',
      'job_role': finaljobRole,
      'expected_ctc': '',
      'notice_period': ''
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalRseult = await response.stream.bytesToString();
      final jsonResult = SearchCandidateModel.fromJson(json.decode(finalRseult));
      setState(() {
        searchCandidateModel = jsonResult;
      });
        setState(() {
          selectedLocation.clear();
          selectedJobRole.clear();
          selectedJobType.clear();
          selectedDesignation.clear();
        });
      }

    else {
      print(response.reasonPhrase);
    }



    //
    // var headers = {
    //   'Cookie': 'ci_session=45e0b829049651645bab533bdc7715401ad472ea'
    // };
    // var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}candidate_lists/${userid}'));
    // request.fields.addAll({
    //   'job_type':finalJobType,
    //   'location': finalLocation,
    //   'designation': finalDesignation,
    //   'qualification': '',
    //   'experience': '',
    //   'specialization': '',
    //   'skill': '',
    //   'job_role': finaljobRole,
    //   'expected_ctc': '',
    //   'notice_period': ''
    // });
    // print("candidate list parameter ${request.fields} and ${ApiPath.baseUrl}candidate_lists/${userid}");
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    // print("response code here ${response.statusCode}");
    // if (response.statusCode == 200) {
    //   var finalResult = await response.stream.bytesToString();
    //   print("final result here now ${finalResult}");
    //   final jsonResponse = CandidateModel.fromJson(json.decode(finalResult));
    //   setState(() {
    //     candidateModel = jsonResponse;
    //   });
    //  // Navigator.pop(context);
    //   setState(() {
    //     selectedLocation.clear();
    //     selectedJobRole.clear();
    //     selectedJobType.clear();
    //     selectedDesignation.clear();
    //   });
    // }
    // else {
    //   print(response.reasonPhrase);
    // }
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
      jobTypeList.clear();
      jobRoleList.clear();
      locationList.clear();
      designationList.clear();
      for(var i=0;i<addJobDataModel!.data!.jobTypes!.length;i++){
        jobTypeList.add(addJobDataModel!.data!.jobTypes![i].name.toString());
      }
      for(var i=0;i<addJobDataModel!.data!.jobRoles!.length;i++){
        jobRoleList.add(addJobDataModel!.data!.jobRoles![i].name.toString());
      }
      for(var i=0;i<addJobDataModel!.data!.locations!.length;i++){
        locationList.add(addJobDataModel!.data!.locations![i].name.toString());
      }
      for(var i=0;i<addJobDataModel!.data!.designations!.length;i++){
        designationList.add(addJobDataModel!.data!.designations![i].name.toString());
      }
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
    Future.delayed(Duration(milliseconds: 300),(){
      return addJobDataFunction();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        endDrawer: endDwawer(),
        appBar: customAppBar(text: "Search Candidate",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body: SingleChildScrollView(
          child:Padding(
              padding: const EdgeInsets.only(left: 10,top: 20,right: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10,),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   elevation: 5,
                    //   child: TextFormField(
                    //     controller: designationController,
                    //     keyboardType: TextInputType.name,
                    //     onTap: (){
                    //       setState(() {
                    //         _key.currentState!.openEndDrawer();
                    //       });
                    //     },
                    //
                    //     readOnly: true,
                    //     decoration: InputDecoration(
                    //       prefixIcon: Icon(Icons.work),
                    //         hintText: 'Search candidate',
                    //         border: InputBorder.none,
                    //         contentPadding: EdgeInsets.only(left: 10,top: 15)
                    //     ),
                    //     // validator: (v) {
                    //     //   if (v!.isEmpty) {
                    //     //     return "UI/UX designer is required";
                    //     //   }
                    //     // },
                    //   ),
                    // ),
                    SizedBox(height: 15,),
                    searchCandidateModel == null ?  ListView(
                    shrinkWrap: true,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10,top: 10),
                          child: Text(
                            "Job Type",
                            style: TextStyle(
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: CustomSearchableDropDown(
                            items: jobTypeList,
                            label: 'Select JobType',
                            multiSelectTag: 'Names',
                            decoration: const BoxDecoration(
                                // border: Border.all(
                                //   color: CustomColors.lightgray.withOpacity(0.5),
                                // )
                              color: Colors.white
                            ),
                            hideSearch: true,
                            multiSelect: true,
                            prefixIcon:  Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                // margin: EdgeInsets.only(left: 7),
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/drawerImages/jobtype.png",
                                 scale: 1.5,
                                ),
                              ),
                            ),
                            dropDownMenuItems: jobTypeList.map((item) {
                              return item;
                            }).toList() ?? [],
                            onChanged: (value){
                              if(value!=null)
                              {
                                setState(() {
                                  selectedJobType = jsonDecode(value);
                                });
                              }
                              else{
                                selectedJobType.clear();
                              }
                            },
                          ),
                        ),
                        selectedJobType.length == 0 ? SizedBox() : Wrap(
                          children: selectedJobType.map((e){
                            return  Container(
                              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: CustomColors.lightgray.withOpacity(0.2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${e}"),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedJobType.remove(e);
                                        });
                                      },
                                      child: Icon(Icons.clear,size: 20))
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,top: 10),
                          child: Text(
                            "Job Role",
                            style: TextStyle(
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: CustomSearchableDropDown(
                            items: jobRoleList,
                            label: 'Select JobRole',
                            multiSelectTag: 'Names',
                            decoration: BoxDecoration(
                                // border: Border.all(
                                //   color: CustomColors.lightgray.withOpacity(0.5),
                                // )
                                color: Colors.white
                            ),
                            multiSelect: true,
                            prefixIcon:  Padding(
                              padding: const EdgeInsets.all(1.0),
                              child:Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/drawerImages/jobrole.png",
                                  scale: 1.5,
                                  // color: Colors.black26,
                                ),
                              ),
                            ),
                            dropDownMenuItems: jobRoleList.map((item) {
                              return item;
                            }).toList() ??
                                [],
                            onChanged: (value){
                              if(value!=null)
                              {
                                setState(() {
                                  selectedJobRole = jsonDecode(value);
                                });
                              }
                              else{
                                selectedJobRole.clear();
                              }
                            },
                          ),
                        ),
                        selectedJobRole.length == 0 ? SizedBox() :  Wrap(
                          children: selectedJobRole.map((e){
                            return  Container(
                              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: CustomColors.lightgray.withOpacity(0.2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${e}"),
                                  SizedBox(width: 10),
                                  InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedJobRole.remove(e);
                                        });
                                      },
                                      child: Icon(Icons.clear,size: 20))
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Location",
                                    style: TextStyle(
                                        color: CustomColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2),
                                child: CustomSearchableDropDown(
                                  items: locationList,
                                  label: 'Select location',
                                  multiSelectTag: 'Names',
                                  decoration: const BoxDecoration(
                                      // border: Border.all(
                                      //   color: CustomColors.lightgray.withOpacity(0.5),
                                      // )
                                      color: Colors.white
                                  ),
                                  multiSelect: true,
                                  prefixIcon:  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset("assets/drawerImages/location.png", scale: 1.5,))
                                  ),
                                  dropDownMenuItems: locationList.map((item) {
                                    return item;
                                  }).toList() ??
                                      [],
                                  onChanged: (value){
                                    if(value!=null)
                                    {
                                     // setState(() {
                                        selectedLocation = jsonDecode(value);
                                     // });
                                    }
                                    else{
                                      //setState(() {
                                        selectedLocation.clear();
                                      //});
                                    }
                                  },
                                ),
                              ),
                              selectedLocation.length == 0 ? SizedBox.shrink() :    Wrap(
                                children: selectedLocation.map((e){
                                  return  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    height: 35,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: CustomColors.lightgray.withOpacity(0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("${e}"),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              setState(() {
                                                selectedLocation.remove(e);
                                              });
                                            },
                                            child: Icon(Icons.clear,size: 20,))
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              Divider(),
                              const Text(
                                "Designation",
                                style: TextStyle(
                                    color: CustomColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(height: 10,),
                              CustomSearchableDropDown(
                                items: designationList,
                                label: 'Select designation',
                                multiSelectTag: 'Names',
                                decoration: BoxDecoration(
                                    // border: Border.all(
                                    //   color: CustomColors.lightgray.withOpacity(0.5),
                                    // )
                                    color: Colors.white
                                ),
                                multiSelect: true,
                                prefixIcon:  Padding(
                                  padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset("assets/drawerImages/designation.png", scale: 1.5,))
                                ),
                                dropDownMenuItems: designationList.map((item) {
                                  return item;
                                }).toList() ??
                                    [],
                                onChanged: (value){
                                  if(value!=null)
                                  {
                                    // setState(() {
                                      selectedDesignation = jsonDecode(value);
                                    // });
                                  }
                                  else{
                                    // setState(() {
                                      selectedDesignation.clear();
                                    // });
                                  }
                                },
                              ),
                              selectedDesignation.length == 0 ? SizedBox.shrink() :  Wrap(
                                children: selectedDesignation.map((e){
                                  return  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                                    height: 35,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: CustomColors.lightgray.withOpacity(0.2),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("${e}"),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              setState(() {
                                                selectedDesignation.remove(e);
                                              });
                                            },
                                            child: Icon(Icons.clear,size: 20,))
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomAppBtn(
                            title: "Submit",
                            onPress: (){
                              searchCandidate();
                            },
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ) : SizedBox.shrink(),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   elevation: 5,
                    //   child: TextFormField(
                    //     maxLines: 1,
                    //     controller: locationController,
                    //     keyboardType: TextInputType.name,
                    //     onChanged: (v){
                    //       setState(() {
                    //         //searchCandidate();
                    //       });
                    //     },
                    //     decoration: InputDecoration(
                    //       prefixIcon: Icon(Icons.location_on_outlined),
                    //         counterText: "",
                    //         hintText: 'Mumbai, Maharashtra',
                    //         border: InputBorder.none,
                    //         contentPadding: EdgeInsets.only(left: 10,top: 15)
                    //     ),
                    //     // validator: (v) {
                    //     //   if (v!.isEmpty) {
                    //     //     return "Mobile is required";
                    //     //   }
                    //     // },
                    //   ),
                    // ),
                    // SizedBox(height: 40,),
                    //  Row(
                    //    mainAxisAlignment: MainAxisAlignment.center,
                    //    children: [
                    //      CustomAppBtn(
                    //        height: 50,
                    //        width: MediaQuery.of(context).size.height/4.6,
                    //        title: 'SEARCH',
                    //        onPress: () {
                    //          searchCandidate();
                    //          // if (_formKey.currentState!.validate()) {
                    //          // } else {
                    //          //   // Navigator.push(context,
                    //          //   //     MaterialPageRoute(builder: (context) =>LoginScreen()));
                    //          //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    //          // }
                    //          // var snackBar = SnackBar(
                    //          //   content: Text('All Fields are required!'),
                    //          // );
                    //          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //
                    //        },
                    //      ),
                    //      // InkWell(
                    //      //   onTap: (){
                    //      //    // Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportHelp()));
                    //      //   },
                    //      //   child: Padding(
                    //      //     padding: const EdgeInsets.only(left: 5),
                    //      //     child: Container(
                    //      //         decoration: BoxDecoration(
                    //      //             borderRadius: BorderRadius.circular(10),
                    //      //             color: CustomColors.AppbarColor1
                    //      //         ),
                    //      //         height: 50,
                    //      //         width: 50,
                    //      //         child: Icon(
                    //      //             Icons.menu
                    //      //         )
                    //      //     ),
                    //      //   ),
                    //      // ),
                    //
                    //    ],
                    //  ),
                    searchCandidateModel == null ? SizedBox.shrink() : searchCandidateModel!.data!.length == 0 ?  Center(child: Text("No data to show"),) : ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchCandidateModel!.data!.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (c,i){
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: CustomColors.grade1,width: 2),
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),

                                      child: Image.network("${searchCandidateModel!.data![i].img}",fit: BoxFit.fill,),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${searchCandidateModel!.data![i].name}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.w600,fontSize: 15),),
                                      SizedBox(height: 5),
                                      Text("${searchCandidateModel!.data![i].designation} ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),),
                                      SizedBox(height: 5,),
                                      searchCandidateModel!.data![i].exp == null || searchCandidateModel!.data![i].exp == "" ?    Text("Exp :",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),) :   Text("Exp :  ${searchCandidateModel!.data![i].exp} years",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),)
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height:25,
                                          width: 25,
                                          alignment:Alignment.center,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CustomColors.lightgray,
                                                  offset:  Offset(
                                                    1.0,
                                                    1.0,
                                                  ), //Offset
                                                  blurRadius: 1.0,
                                                  spreadRadius: 1.0,
                                                ), //BoxShadow
                                                //BoxShadow
                                              ],
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.white
                                          ),
                                          child: Icon(Icons.location_on_outlined,color: CustomColors.grade,size: 20,),
                                        ),
                                        SizedBox(width: 10,),
                                        searchCandidateModel!.data![i].location == null || searchCandidateModel!.data![i].location == "" ? SizedBox() : Text("${searchCandidateModel!.data![i].location}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Container(
                                          height:25,
                                          width: 25,
                                          alignment:Alignment.center,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CustomColors.lightgray,
                                                  offset:  Offset(
                                                    1.0,
                                                    1.0,
                                                  ), //Offset
                                                  blurRadius: 1.0,
                                                  spreadRadius: 1.0,
                                                ), //BoxShadow
                                                //BoxShadow
                                              ],
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.white
                                          ),
                                          child: Icon(Icons.email_outlined,color: CustomColors.grade,size: 20,),
                                        ),
                                        SizedBox(width: 10,),
                                        Text("${searchCandidateModel!.data![i].email}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height:25,
                                              width: 25,
                                              alignment:Alignment.center,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: CustomColors.lightgray,
                                                      offset:  Offset(
                                                        1.0,
                                                        1.0,
                                                      ), //Offset
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                    ), //BoxShadow
                                                    //BoxShadow
                                                  ],
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Colors.white
                                              ),
                                              child: Icon(Icons.phone,color: CustomColors.grade,size: 20,),
                                            ),
                                            SizedBox(width: 10,),
                                            Text("${searchCandidateModel!.data![i].mno}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                                          ],
                                        ),
                                        //       Text("Referred on ${allRecruiterAppliedModel!.data![i].days}",style: TextStyle(color: CustomColors.secondaryColor,fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Divider(),
                              SizedBox(height: 5,),
                              searchCandidateModel!.data![i].status == "1" ?  CustomAppBtn(title: "SHORTLISTED",height: 45,width: MediaQuery.of(context).size.width,onPress: (){},) :
                              searchCandidateModel!.data![i].status == "2" ? Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: CustomColors.danger
                                ),
                                child: Text("REJECTED",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                              )
                                  : SizedBox.shrink()
                              // Row(
                              //   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              //   children:
                              //
                              //   [MaterialButton(
                              //     height:45,
                              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              //     color:CustomColors.danger,
                              //     onPressed: (){
                              //       updateShortListStatus(allRecruiterAppliedModel!.data![i].jobId.toString(), allRecruiterAppliedModel!.data![i].userId.toString(), "2");
                              //     },child: Text("REJECT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                              //     MaterialButton(
                              //       height:45,
                              //       color:CustomColors.grade1,
                              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              //       onPressed: (){
                              //         updateShortListStatus(searchCandidateModel!.data![i].jobId.toString(), searchCandidateModel!.data![i].userId.toString(), "1");
                              //       },child: Text("SHORTLIST",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                              //   ],
                              // ),
                            ],
                          ),
                        );
                      })

                  ],
                ),
              )
          ),
        )
    );
  }


  endDwawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.2,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: MediaQuery.of(context).size.height / 8.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff2998E2),
                  Color(0xff2B5FE0),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // main
              children: [
                Text(
                  "Apply Filter",
                  style: TextStyle(
                      color: CustomColors.AppbarColor1,
                      fontWeight: FontWeight.normal,
                      fontSize: 25),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        setState(() {
                          selectedLocation.clear();
                          selectedJobRole.clear();
                          selectedJobType.clear();
                          selectedDesignation.clear();
                        });
                      });
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: CustomColors.AppbarColor1,
                    ))
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Text(
              "Job Type",
              style: TextStyle(
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),
          ),
          SizedBox(height: 5,),



          Container(
            padding: EdgeInsets.all(10),
            child: CustomSearchableDropDown(
              items: jobTypeList,
              label: 'Select JobType',
              multiSelectTag: 'Names',
              decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.lightgray.withOpacity(0.5),
                  )
              ),
              multiSelect: true,
              prefixIcon:  Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(Icons.search),
              ),
              dropDownMenuItems: jobTypeList.map((item) {
                return item;
              }).toList() ??
                  [],
              onChanged: (value){
                if(value!=null)
                {
                  setState(() {
                    selectedJobType = jsonDecode(value);
                  });
                }
                else{
                  selectedJobType.clear();
                }
              },
            ),
          ),
          selectedJobType.length == 0 ? SizedBox() :  Wrap(
            children: selectedJobType.map((e){
              return  Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                height: 35,
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: CustomColors.lightgray.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${e}"),
                    SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedJobType.remove(e);
                          });
                        },
                        child: Icon(Icons.clear,size: 20,))
                  ],
                ),
              );
            }).toList(),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Text(
              "Job Role",
              style: TextStyle(
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.all(10),
            child: CustomSearchableDropDown(
              items: jobRoleList,
              label: 'Select JobRole',
              multiSelectTag: 'Names',
              decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.lightgray.withOpacity(0.5),
                  )
              ),
              multiSelect: true,
              prefixIcon:  Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(Icons.search),
              ),
              dropDownMenuItems: jobRoleList.map((item) {
                return item;
              }).toList() ??
                  [],
              onChanged: (value){
                if(value!=null)
                {
                  setState(() {
                    selectedJobRole = jsonDecode(value);
                  });
                }
                else{
                  selectedJobRole.clear();
                }
              },
            ),
          ),
          selectedJobRole.length == 0 ? SizedBox() :  Wrap(
            children: selectedJobRole.map((e){
              return  Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                height: 35,
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: CustomColors.lightgray.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${e}"),
                    SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedJobRole.remove(e);
                          });
                        },
                        child: Icon(Icons.clear,size: 20,))
                  ],
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          color: CustomColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(2),
                  child: CustomSearchableDropDown(
                    items: locationList,
                    label: 'Select location',
                    multiSelectTag: 'Names',
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.lightgray.withOpacity(0.5),
                        )
                    ),
                    multiSelect: true,
                    prefixIcon:  Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(Icons.search),
                    ),
                    dropDownMenuItems: locationList.map((item) {
                      return item;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          selectedLocation = jsonDecode(value);
                        });
                      }
                      else{
                        setState(() {
                          selectedLocation.clear();
                        });
                      }
                    },
                  ),
                ),
                selectedLocation.length == 0 ? SizedBox.shrink() :    Wrap(
                  children: selectedLocation.map((e){
                    return  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors.lightgray.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${e}"),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  selectedLocation.remove(e);
                                });
                              },
                              child: Icon(Icons.clear,size: 20,))
                        ],
                      ),
                    );
                  }).toList(),
                ),

                Divider(),

                Text(
                  "Designation",
                  style: TextStyle(
                      color: CustomColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: 10,),
                CustomSearchableDropDown(
                  items: designationList,
                  label: 'Select designation',
                  multiSelectTag: 'Names',
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColors.lightgray.withOpacity(0.5),
                      )
                  ),
                  multiSelect: true,
                  prefixIcon:  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: designationList.map((item) {
                    return item;
                  }).toList() ??
                      [],
                  onChanged: (value){
                    if(value!=null)
                    {
                      setState(() {
                        selectedDesignation = jsonDecode(value);
                      });
                    }
                    else{
                      setState(() {
                        selectedDesignation.clear();
                      });
                    }
                  },
                ),
                selectedDesignation.length == 0 ? SizedBox.shrink() :  Wrap(
                  children: selectedDesignation.map((e){
                    return  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors.lightgray.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${e}"),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  selectedDesignation.remove(e);
                                });
                              },
                              child: Icon(Icons.clear,size: 20,))
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomAppBtn(
              title: "Submit",
              onPress: (){
                searchCandidate();
              },
              height: 45,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

}
