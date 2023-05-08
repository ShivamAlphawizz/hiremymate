import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hiremymate/AuthenticationView/loginScreen.dart';
import 'package:hiremymate/Helper/ColorClass.dart';
import 'package:hiremymate/Model/AllJobModel.dart';
import 'package:hiremymate/Model/userModel.dart';
import 'package:hiremymate/ProfilesScreen/ProfileScreen.dart';
import 'package:hiremymate/RecruiterSection/EditPost.dart';
import 'package:hiremymate/RecruiterSection/RecruiterAppliedScreen.dart';
import 'package:hiremymate/RecruiterSection/aboutScreen.dart';
import 'package:hiremymate/RecruiterSection/myJobPost.dart';
import 'package:hiremymate/RecruiterSection/postJob.dart';
import 'package:hiremymate/RecruiterSection/searchCandidate.dart';
import 'package:hiremymate/RecruiterSection/viewApplied.dart';
import 'package:hiremymate/ScreenView/NotificationScreen.dart';
import 'package:hiremymate/ScreenView/privacyPolicy.dart';
import 'package:hiremymate/ScreenView/term&Conditions.dart';
import 'package:hiremymate/ScreenView/welcomeScreen.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model/RecruiterProfileModel.dart';
import '../Model/refereModel.dart';
import '../ScreenView/contactUs.dart';
import '../ScreenView/supportAndHelp.dart';
import '../buttons/CustomButton.dart';
import '../buttons/CustomCard.dart';

class Recruiterome1 extends StatefulWidget {
  const Recruiterome1({Key? key}) : super(key: key);

  @override
  State<Recruiterome1> createState() => _Recruiterome1State();
}

class _Recruiterome1State extends State<Recruiterome1> {
  int currentIndex = 0;
  bool isLoading = false;
  var paymentStatus;


  int selectedIndex = 0;
  bool isSelected = false;

  List<JobsType> jobType = [
    JobsType(title: 'Full time', isSelected: true),
    JobsType(title: 'Part time', isSelected: false),
    JobsType(title: 'Internship', isSelected: false),
    JobsType(title: 'Contarctual', isSelected: false),
    JobsType(title: 'WFH', isSelected: false),
    JobsType(title: 'UG', isSelected: false),
    JobsType(title: 'PG', isSelected: false),
    JobsType(title: 'High School', isSelected: false),
  ];
  List<EducationType> educationType = [
    EducationType(title: 'WFH', isSelected: true),
    EducationType(title: 'UG', isSelected: false),
    EducationType(title: 'PG', isSelected: false),
  ];

  RangeValues _currentRangeValues = const RangeValues(40, 80);

  String? userid;
  getSharedData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('USERID');
    print("user id here now ${userid}");
  }


  RecruiterProfileModel? recruiterProfileModel;


  getProfiledData()async{
    print("ooooooooooooooo");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString("USERID");
    var headers = {
      'Cookie': 'ci_session=af7c02e772664abfa7caad1f5b272362e2f3c492'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}recruiter_profile'));
    request.fields.addAll({
      'id': '${userid}'
    });
    print("parameter for recruiter profile ${request.fields} and ${ApiPath.baseUrl}recruiter_profile");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = RecruiterProfileModel.fromJson(json.decode(finalResponse));
      print("final json response ${jsonResponse}");
      setState(() {
        recruiterProfileModel = jsonResponse;
        paymentStatus = recruiterProfileModel!.data!.pay.toString();
        print("payment status here ${paymentStatus}");
      });

    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState(){

    Future.delayed(Duration(milliseconds: 500),(){
      return getSharedData();
    });
    // Future.delayed(Duration(milliseconds: 600),(){
    //   return getSeekerInfo();
    // });
    Future.delayed(Duration(milliseconds: 600),(){
      return getMyJobs();
    });
    Future.delayed(Duration(milliseconds: 300),(){
      return getProfiledData();
    });
    Future.delayed(Duration(milliseconds: 400),(){
      return getReferredCandidate();
    });
    super.initState();

  }

  SeekerProfileModel? userModel;
  var userData;
  // getSeekerInfo()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? uid = prefs.getString('USERID');
  //   var headers = {
  //     'Cookie': 'ci_session=ccda7f4a97a293e93102a0faa100ac3db98f0723'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}seeker_info'));
  //   request.fields.addAll({
  //     'seeker_email': '${userid}'
  //   });
  //   print("request here now ${request.fields} and ${ApiPath.baseUrl}seeker_info");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalResponse = await response.stream.bytesToString();
  //     final jsonRespone = SeekerProfileModel.fromJson(json.decode(finalResponse));
  //     // final jsonResponse = json.decode(finalResponse);
  //     setState(() {
  //       userModel = jsonRespone;
  //     });
  //
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }



  List<Map<String, dynamic>> card = [
    {
      'image': "assets/homeScreen/Recruiterome1image1.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'Mumbai',
      "time": "Ui/Ux designer",
      "paytext":"₹60k-25k PA",
      "area":"Pune"

    },
    {
      'image': "assets/homeScreen/Recruiterome1image2.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'Mumbai',
      "time": "Ui/Ux designer",
      "paytext":"₹60k-25k PA",
      "area":"Pune"
    },

    {
      'image': "assets/homeScreen/Recruiterome1image3.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'Mumbai',
      "time": "Ui/Ux designer",
      "paytext":"₹60k-25k PA",
      "area":"Pune"
    },

    // {"image": "assets/images/2022.png", "name":"card night" ,"location":"assets/images/location.png","address": "Palsia, Indore"},
  ];
  List<Map<String, dynamic>> card2 = [
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "1",
    },
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "2",
    },
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "3",
    },
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "4",
    },
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "5",
    },
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "6",
    },
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "7",
    },
    {
      'image': "assets/images/Recruiterome1Containerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "8",
    },
  ];

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  AllJobModel? allJobModel;


  openDeleteDialog(String id){
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          title: Text("Are you sure want to delete job ?",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  deleteApp(id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child:  Text("Confirm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.red,
                  ),
                  child:  Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  deleteApp(String? id)async{
    var headers = {
      'Cookie': 'ci_session=d5ff45f8db1109c832e6b7e44b3ad13f93bc1b91'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}delete_job_post'));
    request.fields.addAll({
      'id': '${id}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse =  await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("jsonResponse here ${jsonResponse}");
      var snackBar = SnackBar(
        content: Text('${jsonResponse['message']}'),
      );
   //   ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pop(context,true);
      setState(() {
        getMyJobs();
      });
      //  Future.delayed(Duration(milliseconds: 200),(){
      //    return deleteApp();
      //  });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  getMyJobs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=056439a05a0899b4ea52dc1ac181a060af22ccd2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}job_lists'));
    request.fields.addAll({
      'user_id': '$userid'
    });
    print("my jobs parameters ${request.fields} and ${ApiPath.baseUrl}job_lists");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AllJobModel.fromJson(json.decode(finalResponse));
      setState(() {
        allJobModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final GlobalKey<PopupMenuButtonState<int>> _keyy = GlobalKey();

  RefereModel? refereModel;
  getReferredCandidate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=6815ffda4abb5658b9dc9149e864218d152a5db2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}refere'));
    request.fields.addAll({
      'id': userid.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = RefereModel.fromJson(json.decode(finalResult));
      setState(() {
        refereModel = jsonResponse;
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
            key: _key,
            backgroundColor: CustomColors.TransparentColor,
            drawer: getDrawer(),
            endDrawer: endDwawer(),
            appBar: AppBar(
                elevation: 0,
                backgroundColor: CustomColors.grade1,
                toolbarHeight: 100,
                leading:

                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 30, bottom: 30),
                  child: InkWell(
                    onTap: (){
                      _key.currentState!.openDrawer();
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.AppbarColor1.withOpacity(0.4)
                      ),
                      child: Icon(Icons.menu),
                    ),
                  ),
                ),
                title: Image.asset("assets/images/titleicons.png"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10, top: 30, bottom: 30),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.AppbarColor1.withOpacity(0.4)
                        ),
                        child: Icon(Icons.notifications_none_outlined),
                      ),
                    ),
                  )
                ]
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 5.5,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50)),
                            // gradient: LinearGradient(
                            //   colors: [CustomColors.grade1, CustomColors.grade],
                            // ),
                            color: CustomColors.grade1
                        ),
                        child: Stack(),
                      ),
                      const Padding(
                        padding:  EdgeInsets.only(left: 18, top: 20),
                        child: Text("Let's hire", style: TextStyle(
                            color: CustomColors.AppbarColor1
                        ),),
                      ),

                      const Positioned(
                        top: 40,
                        left: 18,
                        child: Text(
                          "Find Right Candidate Quickly", style: TextStyle(
                            color: CustomColors.AppbarColor1,
                            fontSize: 22,
                            fontWeight: FontWeight.normal
                        ),),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height/6.6,
                        left: 40,
                        right: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), color: CustomColors.AppbarColor1

                              ),
                              height: 50,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.4,
                              child: TextFormField(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchCandidate()));
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search candidate quickly",
                                    prefixIcon: Icon(
                                      Icons.search,
                                    )
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 5),
                            //   child: InkWell(
                            //     onTap: (){
                            //       _key.currentState!.openEndDrawer();
                            //     },
                            //     child: Container(
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: CustomColors.AppbarColor1
                            //         ),
                            //         height: 50,
                            //         width: 50,
                            //         child: Icon(
                            //             Icons.sort
                            //         )
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 15,),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stack(
                        //   children: [
                        //     Image.asset(
                        //         "assets/homeScreen/homejonimages.png"),
                        //     Positioned(
                        //         top: 30,
                        //         left: 30,
                        //         child: Text(
                        //           "Looking for\nA Candidate ?", style: TextStyle(
                        //             color: CustomColors.secondaryColor,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 22
                        //         ),)
                        //     ),
                        //     Positioned(
                        //         top: 100,
                        //         left: 30,
                        //         child: Text(
                        //           "Optimize your whole life with ",
                        //           style: TextStyle(
                        //               color: CustomColors.AppbarColor1,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 11
                        //           ),)
                        //     ),
                        //     Positioned(
                        //         top: 115,
                        //         left: 30,
                        //         child: Text(
                        //           "Premium feature", style: TextStyle(
                        //             color: CustomColors.AppbarColor1,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 11
                        //         ),)
                        //     ),
                        //     Positioned(
                        //         top: 140,
                        //         left: 30,
                        //         child: Container(
                        //           height: 30,
                        //           width: 100,
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(
                        //                   5),
                        //               color: CustomColors.secondaryColor
                        //           ),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Center(
                        //               child: Text(
                        //                 "Tty it Now", style: TextStyle(
                        //                   color: CustomColors.primaryColor,
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 11
                        //               ),),
                        //             ),
                        //           ),
                        //         )
                        //     ),
                        //   ],
                        // ),

                        /// active job section
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 10),
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                               children: [
                                 Text("Active Jobs", style: TextStyle(
                                     color: CustomColors.primaryColor,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18
                                 ),),
                                 SizedBox(width: 10,),
                                 allJobModel == null ? SizedBox.shrink() : Text("(${allJobModel!.data!.length})", style: TextStyle(
                                     color: CustomColors.primaryColor,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18
                                 ),),
                               ],
                             ),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyJobPost()));
                                  },
                                  child: Text("View all",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.w600,fontSize: 16),))
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: MediaQuery.of(context).size.height/1.5,
                          child: allJobModel == null ? Center(child: CircularProgressIndicator(),)
                              :  allJobModel!.data!.length <1
                              ? const Center(
                            child: Text("No Active job to show"),
                          )
                              : ListView.builder(
                              shrinkWrap: true,
                              itemCount: allJobModel!.data!.length > 3  ?  3 : allJobModel!.data!.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (c,i){
                            return Container(
                              padding: EdgeInsets.only(left: 10,right: 10,bottom: 8),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: ListTile(
                                      contentPadding: EdgeInsets.only(left:0,right: 0,top: 0,bottom: 0),
                                      leading:Container(
                                        height: 45,
                                        width: 45,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.asset("assets/homeScreen/homeScreenimage1.png",fit: BoxFit.fill,),
                                        ),
                                      ),
                                      title: Text("${allJobModel!.data![i].designation}",style: TextStyle(color: CustomColors.darkblack,fontSize: 16,fontWeight: FontWeight.w600),),
                                      subtitle: Text("${allJobModel!.data![i].location}",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w400,fontSize: 11),),
                                   trailing: PopupMenuButton(
                                     icon: Icon(Icons.more_vert),
                                     onSelected: (value){
                                       if(value == "1" || value == 1){
                                         setState(() {
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJobPostScreen(id: allJobModel!.data![i].id.toString(),)));
                                         });
                                       }
                                       if(value == "2" || value == 2){
                                         setState(() {
                                            openDeleteDialog(allJobModel!.data![i].id.toString());
                                         });
                                       }
                                       if(value == "3" || value == "3"){
                                         setState(() {
                                         });
                                       }
                                     },
                                     itemBuilder: (C) => [
                                       PopupMenuItem(
                                         onTap: (){
                                         },
                                         child:Row(
                                           children: [
                                             Container(
                                                height:25,
                                               width: 25,
                                               decoration:BoxDecoration(
                                                 borderRadius: BorderRadius.circular(6),
                                                 border: Border.all(color: CustomColors.lightgray),
                                               ),
                                               child: Icon(Icons.edit,color: CustomColors.grade1,size: 15,),
                                             ),
                                             SizedBox(width: 7,),
                                             Text("Edit")
                                           ],
                                         ),
                                         value: 1,
                                       ),
                                       PopupMenuItem(
                                         child:Row(
                                           children: [
                                             Container(
                                               height:25,
                                               width: 25,
                                               decoration:BoxDecoration(
                                                 borderRadius: BorderRadius.circular(6),
                                                 border: Border.all(color: CustomColors.lightgray),
                                               ),
                                               child: Icon(Icons.delete_forever_rounded,color: CustomColors.danger,size: 15,),
                                             ),
                                             SizedBox(width: 7,),
                                             Text("Delete")
                                           ],
                                         ),
                                         value: 2,
                                       ),
                                       PopupMenuItem(
                                         child:Row(
                                           children: [
                                             Container(
                                               height:25,
                                               width: 25,
                                               decoration:BoxDecoration(
                                                 borderRadius: BorderRadius.circular(6),
                                                 border: Border.all(color: CustomColors.lightgray),
                                               ),
                                               child: Icon(Icons.share,color: CustomColors.secondaryColor,size: 15,),
                                             ),
                                             SizedBox(width: 7,),
                                             Text("Share")
                                           ],
                                         ),
                                         value: 3,
                                       ),
                                     ],
                                   ),
                                    ),
                                  ),
                                  Text("\u{20B9}${allJobModel!.data![i].min}- ${allJobModel!.data![i].max} ${allJobModel!.data![i].salaryRange}",style: TextStyle(color:CustomColors.darkblack,fontSize: 14,fontWeight: FontWeight.w500),),
                                  SizedBox(height: 5,),
                                  Text("${allJobModel!.data![i].noOfVaccancies} Openings",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w400,fontSize: 12),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${allJobModel!.data![i].days} days ago",style: TextStyle(color: CustomColors.secondaryColor,fontWeight: FontWeight.w500),),
                                      InkWell(
                                        onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAppliedStudent(jobId: allJobModel!.data![i].id.toString(),)));
                                        },
                                        child: Container(
                                          height: 45,
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          alignment:Alignment.center,
                                          decoration:BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: CustomColors.darkblack)
                                          ),
                                          child: Text("View Applies",style: TextStyle(color: CustomColors.darkblack,fontSize: 14,fontWeight: FontWeight.w500),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),

                        /// referred  Candidate
                        // Padding(
                        //   padding:  EdgeInsets.only(
                        //       left: 5, right: 5, top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       Text("Referred Candidate", style: TextStyle(
                        //           color: CustomColors.primaryColor,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 18
                        //       ),),
                        //       // Text("(05)", style: TextStyle(
                        //       //     color: CustomColors.primaryColor,
                        //       //     fontWeight: FontWeight.bold,
                        //       //     fontSize: 18
                        //       // ),),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 10,),
                        //
                        // Container(
                        //   height: MediaQuery.of(context).size.height/1.6,
                        //   child:refereModel == null ?  Center(child: CircularProgressIndicator(),) : refereModel!.data!.length == 0  ? Center(child: Text("No candidate to show"), ) : ListView.builder(
                        //       itemCount:  refereModel!.data!.length,
                        //       shrinkWrap: true,
                        //       physics: NeverScrollableScrollPhysics(
                        //
                        //       ),
                        //       itemBuilder: (c,i){
                        //     return Container(
                        //       padding: EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: Colors.white,
                        //       ),
                        //       margin: EdgeInsets.only(bottom: 10),
                        //       child: Column(
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Container(
                        //                 height: 65,
                        //                 width: 65,
                        //                 decoration: BoxDecoration(
                        //                   border: Border.all(color: CustomColors.grade1,width: 2),
                        //                   borderRadius: BorderRadius.circular(12)
                        //                 ),
                        //                 child: ClipRRect(
                        //                   borderRadius: BorderRadius.circular(12),
                        //
                        //                   child: Image.network("${ApiPath.imageUrl}${refereModel!.data![i].img}",fit: BoxFit.fill,),
                        //                 ),
                        //               ),
                        //               SizedBox(width: 10,),
                        //               Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Text("${refereModel!.data![i].name}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.w600,fontSize: 15),),
                        //                   SizedBox(height: 5,),
                        //                   Text("${refereModel!.data![i].designation} | Job id : ${refereModel!.data![i].jobId} |",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),),
                        //                   SizedBox(height: 5,),
                        //                   Text("Exp :  ${refereModel!.data![i].exp} years",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),)
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //           SizedBox(height: 10,),
                        //           Container(
                        //             child: Column(
                        //               children: [
                        //                 Row(
                        //                   children: [
                        //                     Container(
                        //                       height:25,
                        //                       width: 25,
                        //                       alignment:Alignment.center,
                        //                       decoration: BoxDecoration(
                        //                       boxShadow: [
                        //                       BoxShadow(
                        //                       color: CustomColors.lightgray,
                        //                   offset:  Offset(
                        //                   1.0,
                        //                   1.0,
                        //                   ), //Offset
                        //                   blurRadius: 1.0,
                        //                   spreadRadius: 1.0,
                        //                   ), //BoxShadow
                        //                   //BoxShadow
                        //                   ],
                        //                         borderRadius: BorderRadius.circular(100),
                        //                         color: Colors.white
                        //                       ),
                        //                       child: Icon(Icons.location_on_outlined,color: CustomColors.grade,size: 20,),
                        //                     ),
                        //                     SizedBox(width: 10,),
                        //                     Text("${refereModel!.data![i].location}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 8,),
                        //                 Row(
                        //                   children: [
                        //                     Container(
                        //                       height:25,
                        //                       width: 25,
                        //                       alignment:Alignment.center,
                        //                       decoration: BoxDecoration(
                        //                           boxShadow: [
                        //                             BoxShadow(
                        //                               color: CustomColors.lightgray,
                        //                               offset:  Offset(
                        //                                 1.0,
                        //                                 1.0,
                        //                               ), //Offset
                        //                               blurRadius: 1.0,
                        //                               spreadRadius: 1.0,
                        //                             ), //BoxShadow
                        //                             //BoxShadow
                        //                           ],
                        //                           borderRadius: BorderRadius.circular(100),
                        //                           color: Colors.white
                        //                       ),
                        //                       child: Icon(Icons.email_outlined,color: CustomColors.grade,size: 20,),
                        //                     ),
                        //                     SizedBox(width: 10,),
                        //                     Text("${refereModel!.data![i].email}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
                        //                   ],
                        //                 ),
                        //                 SizedBox(height: 8,),
                        //                 Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: [
                        //                    Row(
                        //                      children: [
                        //                        Container(
                        //                          height:25,
                        //                          width: 25,
                        //                          alignment:Alignment.center,
                        //                          decoration: BoxDecoration(
                        //                              boxShadow: [
                        //                                BoxShadow(
                        //                                  color: CustomColors.lightgray,
                        //                                  offset:  Offset(
                        //                                    1.0,
                        //                                    1.0,
                        //                                  ), //Offset
                        //                                  blurRadius: 1.0,
                        //                                  spreadRadius: 1.0,
                        //                                ), //BoxShadow
                        //                                //BoxShadow
                        //                              ],
                        //                              borderRadius: BorderRadius.circular(100),
                        //                              color: Colors.white
                        //                          ),
                        //                          child: Icon(Icons.phone,color: CustomColors.grade,size: 20,),
                        //                        ),
                        //                        SizedBox(width: 10,),
                        //                        Text("${refereModel!.data![i].mno}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                        //                      ],
                        //                    ),
                        //                     Text("Referred on ${refereModel!.data![i].days}",style: TextStyle(color: CustomColors.secondaryColor,fontWeight: FontWeight.w500),)
                        //                   ],
                        //                 ),
                        //
                        //               ],
                        //             ),
                        //           ),
                        //          SizedBox(height: 5,),
                        //            Divider(),
                        //           SizedBox(height: 5,),
                        //           Row(
                        //             mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               MaterialButton(
                        //                 height:45,
                        //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        //                 color:CustomColors.danger,
                        //                 onPressed: (){},child: Text("REJECT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                        //               MaterialButton(
                        //                 height:45,
                        //                 color:CustomColors.grade1,
                        //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        //                 onPressed: (){},child: Text("SHORTLIST",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   }),
                        // ),
                        //
                        //////////////////////////


                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 5, right: 5, top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Popular Jobs", style: TextStyle(
                        //           color: CustomColors.primaryColor,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 18
                        //       ),),
                        //       Text("View all", style: TextStyle(
                        //           color: CustomColors.lightback,
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 18
                        //       ),)
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 10,),
                        // Container(
                        //   height: MediaQuery.of(context).size.height/4.5,
                        //   width: double.infinity,
                        //   child: ListView.builder(
                        //     //physics: const NeverScrollableScrollPhysics(),
                        //       shrinkWrap: false,
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: card.length,
                        //       itemBuilder: (context, index) {
                        //         return jobCard(context,index,cardUi);
                        //       }),
                        // ),
                        // SizedBox(height: 5,),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 5, right: 5, top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Recent Jobs", style: TextStyle(
                        //           color: CustomColors.primaryColor,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 18
                        //       ),),
                        //       Text("View all", style: TextStyle(
                        //           color: CustomColors.lightback,
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 18
                        //       ),)
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 10,),
                        // ListView.builder(
                        //   //physics: const NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     scrollDirection: Axis.vertical,
                        //     itemCount: card.length,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         width: MediaQuery
                        //             .of(context)
                        //             .size
                        //             .width / 1.3,
                        //         child: Card(
                        //           elevation: 5,
                        //           color:Colors.white,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(
                        //                   10)),
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             crossAxisAlignment: CrossAxisAlignment
                        //                 .start,
                        //             mainAxisAlignment: MainAxisAlignment
                        //                 .start,
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment
                        //                     .spaceBetween,
                        //                 crossAxisAlignment: CrossAxisAlignment
                        //                     .start,
                        //                 children: [
                        //                   Row(
                        //                     crossAxisAlignment:CrossAxisAlignment.start,
                        //                     children: [
                        //                       Padding(
                        //                         padding:  EdgeInsets.all(
                        //                             8.0),
                        //                         child: Image.asset(
                        //                           card[index]['image'],
                        //                           height: 60,
                        //                           width: 60,
                        //                           // fit: BoxFit.fill,
                        //                         ),
                        //                       ),
                        //                       Column(
                        //                         crossAxisAlignment: CrossAxisAlignment
                        //                             .start,
                        //                         children: [
                        //                           Padding(
                        //                             padding: const EdgeInsets
                        //                                 .only(top: 10),
                        //                             child: Text(
                        //                               card[index]['text'],
                        //                               style: TextStyle(
                        //                                   fontSize: 13,
                        //                                   fontWeight: FontWeight
                        //                                       .bold),
                        //                             ),
                        //                           ),
                        //                           SizedBox(height: 5,),
                        //                           Text(
                        //                             card[index]['address'],
                        //                             style: TextStyle(
                        //                                 fontSize: 13,
                        //                                 fontWeight: FontWeight
                        //                                     .normal),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   Padding(
                        //                     padding: const EdgeInsets.only(
                        //                         top: 10, left: 5),
                        //                     child: Container(
                        //                         height: 40,
                        //                         width: 40,
                        //                         decoration: BoxDecoration(
                        //                             color: CustomColors
                        //                                 .AppbarColor1,
                        //                             borderRadius: BorderRadius
                        //                                 .circular(50)
                        //                         ),
                        //                         child: Image.asset(
                        //                             "assets/homeScreen/jobpath.png")
                        //                     ),
                        //                   ),
                        //
                        //                 ],
                        //               ),
                        //               Padding(
                        //                 padding:  EdgeInsets.only(left: 10,bottom: 10),
                        //                 child: IntrinsicHeight(
                        //                   child: Row(
                        //                     children: [
                        //                       Text(
                        //                         card[index]['paytext'],
                        //                         style: TextStyle(color: CustomColors.darkblack,
                        //                           fontSize: 15,
                        //                           fontWeight: FontWeight
                        //                               .normal,),
                        //                       ),
                        //                       VerticalDivider(
                        //                         color: CustomColors.lightgray,  //color of divider
                        //                         //width space of divider
                        //                         thickness: 1, //thickness of divier line
                        //                         //Spacing at the bottom of divider.
                        //                       ),
                        //                       Text(
                        //                         card[index]['time'],
                        //                         style: TextStyle(color: CustomColors.darkblack,
                        //                             fontSize: 15,
                        //                             fontWeight: FontWeight
                        //                                 .normal),
                        //                       ),
                        //                       VerticalDivider(
                        //                         color:CustomColors.lightgray,  //color of divider
                        //                         //width space of divider
                        //                         thickness: 1, //thickness of divier line
                        //                         //Spacing at the bottom of divider.
                        //                       ),
                        //
                        //                       Text(
                        //                         card[index]['area'],
                        //                         style: TextStyle(color: CustomColors.darkblack,
                        //                           fontSize: 15,
                        //                           fontWeight: FontWeight
                        //                               .normal,),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     }),


                      ],
                    ),
                  ),
                )

              ],
            )
          // CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       snap: false,
          //       pinned: false,
          //       floating: true,
          //       flexibleSpace: FlexibleSpaceBar(
          //           centerTitle: true,
          //            //Images.network
          //       ), //FlexibleSpaceBar
          //       expandedHeight: 230,
          //       backgroundColor: CustomColors.primaryColor,
          //       leading:  Padding(
          //         padding: const EdgeInsets.only(left: 10,top: 5),
          //         child: Container(
          //           height: 45,
          //           width: 45,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color: CustomColors.AppbarColor1.withOpacity(0.4)
          //           ),
          //           child: Icon(Icons.menu),
          //         ),
          //       ),
          //       //IconButton
          //       actions: <Widget>[
          //        Image.asset("assets/images/titleicons.png"),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 10,top: 5),
          //           child: Container(
          //             height: 45,
          //             width: 45,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color: CustomColors.AppbarColor1.withOpacity(0.4)
          //             ),
          //             child: Icon(Icons.notifications_none_outlined),
          //           ),
          //         ), //IconButton
          //       ], //<Widget>[]
          //     ), //SliverAppBar
          //     // SliverList(
          //     //   delegate: SliverChildDelegate(), //SliverChildBuildDelegate
          //     // ) //SliverList
          //   ], //<Widget>[]
          // )
        )
    );
  }
  getDrawer(){
    return Drawer(

      width: MediaQuery.of(context).size.width/1.5,
      child: ListView(

        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 120,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              // main
              children: [
                CircleAvatar(
                  radius:40,
                  backgroundImage:

                 recruiterProfileModel == null ?  NetworkImage("https://www.w3schools.com/howto/img_avatar.png",) : recruiterProfileModel!.data!.img == "" ?
                 NetworkImage("https://www.w3schools.com/howto/img_avatar.png",) : NetworkImage("${recruiterProfileModel!.data!.img}"),
                ),
                SizedBox(width: 10,),
                recruiterProfileModel == null || recruiterProfileModel!.data == null ? SizedBox.shrink() : Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width:120,
                          padding: EdgeInsets.only(right: 4),
                          child: Text("${recruiterProfileModel!.data!.name}",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),maxLines: 2,)),
                      Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 4),
                          child: Text("${recruiterProfileModel!.data!.email}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 13),maxLines: 2,)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Image.asset("assets/drawerImages/user.png",height: 40,width: 40,),
            title:  Text(' My Profile ',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          // ListTile(
          //   leading: Image.asset("assets/drawerImages/savedJob.png",height: 40,width: 40,),
          //   title:  Text('My Saved Jobs ',style: TextStyle(color: CustomColors.primaryColor)),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => Recruiterome1()),
          //     //);
          //   },
          // ),
          ListTile(
            leading: Image.asset("assets/drawerImages/appliedJob.png",height: 40,width: 40,),
            title:  Text('Post Jobs',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostJobScreen()),
              );
            },
          ) ,ListTile(
            leading: Image.asset("assets/drawerImages/changePassword.png",height: 40,width: 40,),
            title:  Text('My Posted Job',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyJobPost()),
              );
            },
          ),ListTile(
            leading: Image.asset("assets/drawerImages/user.png",height: 40,width: 40,),
            title:  Text('Applied',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecruiterAppliedScreen()),
              );
            },
          ),
          // ListTile(
          //   leading: Image.asset("assets/drawerImages/user.png",height: 40,width: 40,),
          //   title:  Text('Referred Candidate',style: TextStyle(color: CustomColors.primaryColor)),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => Recruiterome1()),
          //     // );
          //   },
          // ),
          ListTile(
            leading: Image.asset("assets/drawerImages/user.png",height: 40,width: 40,),
            title:  Text('Search Candidate',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchCandidate()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/drawerImages/shareApp.png",height: 40,width: 40,),
            title:  Text('Share App',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: ()async{
              await FlutterShare.share(
                  title: 'Share',
                  text: 'Hire my mate',
                  linkUrl: 'https://flutter.dev/',
                  chooserTitle: 'Dummy link'
              );
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => Recruiterome1()),
              //   );
            },
          ),
          ListTile(
            leading: Image.asset("assets/drawerImages/contactus.png",height: 40,width: 40,),
            title:  Text('Contact Us',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CantactUs()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/drawerImages/privacyPolicy.png",height: 40,width: 40,),
            title:  Text('Privacy Policy',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/drawerImages/supportHelp.png",height: 40,width: 40,),
            title:  Text('About Us',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/drawerImages/supportHelp.png",height: 40,width: 40,),
            title:  Text('Support & Help',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupportHelp()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/drawerImages/termCondition.png",height: 40,width: 40,),
            title:  Text('Term & Conditions',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermConditions()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/drawerImages/signout.png",height: 40,width: 40,),
            title:  Text('Sign Out ',style: TextStyle(color: CustomColors.primaryColor)),
            onTap: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setString('USERID', "");
                prefs.setString('Role', "");
              });
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (route) => false);
            },
          ),
        ],
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Job Type",
                      style: TextStyle(
                          color: CustomColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      "Reset All",
                      style: TextStyle(
                          color: CustomColors.secondaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 18),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 7.1,
                        child: GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: (4 / 2),
                            ),
                            itemCount: jobType.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= jobType.length; i++) {
                                      jobType[i].isSelected = true;
                                      print("jdssfdgsfdgfdgb");
                                    }
                                    jobType[index].isSelected = false;
                                  });
                                },
                                child: Container(
                                  width: 62,
                                  height: 50,
                                  //margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: jobType[index].isSelected
                                          ? CustomColors.grade
                                          : CustomColors.lightback
                                    //border: Border.all(color:jobType[index].isSelected  ? CustomColors.lightback: CustomColors.grade)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                          jobType[index].title,
                                          style: TextStyle(
                                              color: jobType[index].isSelected
                                                  ? CustomColors.AppbarColor1
                                                  : CustomColors.lightback),
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),

                    ],
                  ),
                ),
                Text(
                  "Education",
                  style: TextStyle(
                      color: CustomColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 7.1,
                        child: GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: (4 / 2),
                            ),
                            itemCount: jobType.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    for (int i = 0; i <= jobType.length; i++) {
                                      jobType[i].isSelected = true;
                                      print("jdssfdgsfdgfdgb");
                                    }
                                    jobType[index].isSelected = false;
                                  });
                                },
                                child: Container(
                                  width: 62,
                                  height: 50,
                                  //margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: jobType[index].isSelected
                                          ? CustomColors.grade
                                          : CustomColors.lightback
                                    //border: Border.all(color:jobType[index].isSelected  ? CustomColors.lightback: CustomColors.grade)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                          jobType[index].title,
                                          style: TextStyle(
                                              color: jobType[index].isSelected
                                                  ? CustomColors.AppbarColor1
                                                  : CustomColors.lightback),
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),

                      // InkWell(
                      //   onTap: (){
                      //     setState(() {
                      //       isSelected = false;
                      //     });
                      //   },
                      //   child: Container(
                      //     width: 80,
                      //     //margin:  EdgeInsets.all(8.0),
                      //     padding:  EdgeInsets.all(3.0),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20),
                      //         color:isSelected  ? Colors.transparent: CustomColors.grade,
                      //         border: Border.all(color:isSelected  ? CustomColors.lightback: CustomColors.grade)
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Center(child: Text('CALL HR')),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 5,),
                      // InkWell(
                      //   onTap: (){
                      //     setState(() {
                      //       isSelected = false;
                      //     });
                      //   },
                      //   child: Container(
                      //     width: 80,
                      //     //margin:  EdgeInsets.all(8.0),
                      //     padding:  EdgeInsets.all(3.0),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20),
                      //         color:isSelected  ? Colors.transparent: CustomColors.grade,
                      //         border: Border.all(color:isSelected  ? CustomColors.lightback: CustomColors.grade)
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Center(child: Text('CALL HR')),
                      //     ),
                      //   ),
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: (){
                      //           setState(() {
                      //             isSelected = true;
                      //           });
                      //         },
                      //         child: Container(
                      //
                      //           margin: EdgeInsets.all(8.0),
                      //           padding:  EdgeInsets.all(3.0),
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               color: isSelected  ?  CustomColors.grade: Colors.transparent,
                      //               border: Border.all(color:isSelected  ? CustomColors.lightback: CustomColors.grade)
                      //           ),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Center(child: Text('DETAILS')),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: (){
                      //           setState(() {
                      //             isSelected = false;
                      //           });
                      //         },
                      //         child: Container(
                      //           margin:  EdgeInsets.all(8.0),
                      //           padding:  EdgeInsets.all(3.0),
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               color:isSelected  ? Colors.transparent: CustomColors.grade,
                      //               border: Border.all(color:isSelected  ? CustomColors.grade: CustomColors.lightback)
                      //           ),
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Center(child: Text('CALL HR')),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  child: RangeSlider(
                    values: _currentRangeValues,
                    max: 100,
                    divisions: 5,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                ),
                Text(
                  "Salary",
                  style: TextStyle(
                      color: CustomColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: selectedIndex == 1
                                            ? CustomColors.primaryColor
                                            : CustomColors.lightgray,
                                        width: 2)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedIndex == 1
                                        ? CustomColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rs 0-2 Lakhs",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: selectedIndex == 2
                                            ? CustomColors.primaryColor
                                            : CustomColors.lightgray,
                                        width: 2)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedIndex == 2
                                        ? CustomColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rs 0-3 Lakhs",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 3;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: selectedIndex == 3
                                            ? CustomColors.primaryColor
                                            : CustomColors.lightgray,
                                        width: 2)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedIndex == 3
                                        ? CustomColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rs 0-3 Lakhs",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 6;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: selectedIndex == 6
                                            ? CustomColors.primaryColor
                                            : CustomColors.lightgray,
                                        width: 2)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedIndex == 6
                                        ? CustomColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rs 0-4 Lakhs",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 4;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: selectedIndex == 4
                                            ? CustomColors.primaryColor
                                            : CustomColors.lightgray,
                                        width: 2)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedIndex == 4
                                        ? CustomColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rs 0-5 Lakhs",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 5;
                          });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: selectedIndex == 5
                                            ? CustomColors.primaryColor
                                            : CustomColors.lightgray,
                                        width: 2)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectedIndex == 5
                                        ? CustomColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rs 0-6 Lakhs",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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




class JobsType {
  String title;
  bool isSelected;

  JobsType({required this.title, required this.isSelected});
}
class EducationType {
  String title;
  bool isSelected;

  EducationType({required this.title, required this.isSelected});
}