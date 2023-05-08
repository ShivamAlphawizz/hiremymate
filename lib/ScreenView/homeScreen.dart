import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hiremymate/AuthenticationView/loginScreen.dart';
import 'package:hiremymate/Helper/ColorClass.dart';
import 'package:hiremymate/Model/recentJobModel.dart';
import 'package:hiremymate/Model/userModel.dart';
import 'package:hiremymate/ProfilesScreen/ProfileScreen.dart';
import 'package:hiremymate/RecruiterSection/aboutScreen.dart';
import 'package:hiremymate/RecruiterSection/searchCandidate.dart';
import 'package:hiremymate/ScreenView/AllPopularJob.dart';
import 'package:hiremymate/ScreenView/AllRecentJob.dart';
import 'package:hiremymate/ScreenView/NotificationScreen.dart';
import 'package:hiremymate/ScreenView/Searchjob.dart';
import 'package:hiremymate/ScreenView/allRecruiters.dart';
import 'package:hiremymate/ScreenView/applyJob.dart';
import 'package:hiremymate/ScreenView/changePassword.dart';
import 'package:hiremymate/ScreenView/contactUs.dart';
import 'package:hiremymate/ScreenView/jobDescription.dart';
import 'package:hiremymate/ScreenView/privacyPolicy.dart';
import 'package:hiremymate/ScreenView/savedJob.dart';
import 'package:hiremymate/ScreenView/supportAndHelp%20(1).dart';
import 'package:hiremymate/ScreenView/term&Conditions.dart';
import 'package:hiremymate/ScreenView/welcomeScreen.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../buttons/CustomButton.dart';
import '../buttons/CustomCard.dart';
import 'Dashbord.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool isLoading = false;

  String? userid;
  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('USERID');
    print("user id here now ${userid}");
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      return getSharedData();
    });
    Future.delayed(Duration(milliseconds: 600), () {
      return getSeekerInfo();
    });
    Future.delayed(Duration(milliseconds: 300), () {
      return getRecentJobs();
    });
    Future.delayed(Duration(milliseconds: 300), () {
      return getPopularJobs();
    });
    super.initState();
  }

  SeekerProfileModel? userModel;
  var userData;
  getSeekerInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=ccda7f4a97a293e93102a0faa100ac3db98f0723'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}seeker_info'));
    request.fields.addAll({'seeker_email': '${userid}'});
    print(
        "request here now ${request.fields} and ${ApiPath.baseUrl}seeker_info");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonRespone =
      SeekerProfileModel.fromJson(json.decode(finalResponse));
      // final jsonResponse = json.decode(finalResponse);
      setState(() {
        userModel = jsonRespone;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  RecentJobModel? recentJobModel;
  getRecentJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=e50d052344b0c13605f8ef8be2d6c3a834438e7e'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}latest_job'));
    request.fields.addAll({'user_id': '${userid}'});
    print("checking data here now ${ApiPath.baseUrl}latest_job   and ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = RecentJobModel.fromJson(json.decode(finalResult));
      setState(() {
        recentJobModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  RecentJobModel? popularModel;
  getPopularJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=e50d052344b0c13605f8ef8be2d6c3a834438e7e'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}populer_jobs'));
    print("checking popular job data here ${ApiPath.baseUrl}populer_jobs");
    request.fields.addAll({'user_id': '$userid'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = RecentJobModel.fromJson(json.decode(finalResult));
      setState(() {
        popularModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  List<Map<String, dynamic>> card = [
    {
      'image': "assets/homeScreen/homeScreenimage1.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'Mumbai',
      "time": "Ui/Ux designer",
      "paytext": "₹60k-25k PA",
      "area": "Pune"
    },
    {
      'image': "assets/homeScreen/homeScreenimage2.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'Mumbai',
      "time": "Ui/Ux designer",
      "paytext": "₹60k-25k PA",
      "area": "Pune"
    },

    {
      'image': "assets/homeScreen/homeScreenimage3.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'Mumbai',
      "time": "Ui/Ux designer",
      "paytext": "₹60k-25k PA",
      "area": "Pune"
    },

    // {"image": "assets/images/2022.png", "name":"card night" ,"location":"assets/images/location.png","address": "Palsia, Indore"},
  ];
  List<Map<String, dynamic>> card2 = [
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "1",
    },
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "2",
    },
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "3",
    },
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "4",
    },
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "5",
    },
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "6",
    },
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "7",
    },
    {
      'image': "assets/images/HomeScreenContainerimage.png",
      'title': 'Accommodation',
      'Subtitle': '2351 Hotels',
      "Color": "8",
    },
  ];

  saveToJob(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}save_job'));
    request.fields.addAll({'job_id': '${id}', 'user_id': '${userid}'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if (jsonResponse['status'] == true) {
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  removeFromSave(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=5a37ed79b483f5766738a21c88679dc79add7041'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}remove_fav_job'));
    request.fields.addAll({'job_id': '${id}', 'user_id': '${userid}'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if (jsonResponse['status'] == true) {
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          getRecentJobs();
          getPopularJobs();
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Cre

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

  // ate a key

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _key,
          backgroundColor: CustomColors.TransparentColor,
          drawer: getDrawer(),

          appBar:
          AppBar(
              elevation: 0,
              backgroundColor: CustomColors.grade1,
              toolbarHeight: 100,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15, top: 30, bottom: 30),
                child: InkWell(
                  onTap: () {
                    _key.currentState!.openDrawer();

                    //    GetDrawer();
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors.AppbarColor1.withOpacity(0.4)),
                    child: Icon(Icons.menu),
                  ),
                ),
              ),
              title: Image.asset("assets/images/titleicons.png"),
              actions: [
                Padding(
                  padding:
                  EdgeInsets.only(right: 10, top: 30, bottom: 30),
                  child: InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.AppbarColor1.withOpacity(0.4)),
                      child: Icon(Icons.notifications_none_outlined),
                    ),
                  ),
                )
              ]),

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
                    Padding(
                      padding:  EdgeInsets.only(left: 18, top: 20),
                      child:
                      userModel == null
                          ? const Text(
                        "Hello",
                        style: TextStyle(
                            color: CustomColors.AppbarColor1),
                      )
                          : Text(
                        "Hello ${userModel!.data!.name}",
                        style: const TextStyle(
                            color: CustomColors.AppbarColor1),
                      ),
                    ),
                    const Positioned(
                      top: 40,
                      left: 18,
                      child: Text(
                        "Find Your Perfect Job with Us", style: TextStyle(
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
                                .width / 1.6,
                            child: TextFormField(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchJob()));
                              },
                              readOnly: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search job",
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
                      // InkWell(
                      //   onTap: () {
                      //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      //   },
                      //   child: Stack(
                      //     children: [
                      //       Container(
                      //         height:200,
                      //         width: MediaQuery.of(context).size.width,
                      //         child: Image.asset(
                      //           "assets/homeScreen/homejonimages.png",fit: BoxFit.fill,),
                      //       ),
                      //       Align(
                      //           alignment: Alignment.centerLeft,
                      //           // top: 30,
                      //           // left: 30,
                      //           child: Container(
                      //             height: 180,
                      //             padding: EdgeInsets.only(left: 20,top: 30),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 const Text(
                      //                   "Looking for\nA Job?",
                      //                   style: TextStyle(
                      //                       color: CustomColors.secondaryColor,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 22),
                      //                 ),
                      //                 const Text(
                      //                   "Optimize your whole life with \n Premium feature",
                      //                   style: TextStyle(
                      //                       color: CustomColors.AppbarColor1,
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 11),
                      //                 ),
                      //                 Container(
                      //                   height: 30,
                      //                   width: 100,
                      //                   decoration: BoxDecoration(
                      //                       borderRadius:
                      //                       BorderRadius.circular(5),
                      //                       color: CustomColors.secondaryColor),
                      //                   child: const Padding(
                      //                     padding: EdgeInsets.all(8.0),
                      //                     child: Center(
                      //                       child: Text(
                      //                         "Tty it Now",
                      //                         style: TextStyle(
                      //                             color: CustomColors.primaryColor,
                      //                             fontWeight: FontWeight.bold,
                      //                             fontSize: 11),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           )),
                      //       // Positioned(
                      //       //     top: 100,
                      //       //     left: 30,
                      //       //     child: Text(
                      //       //       "Optimize your whole life with ",
                      //       //       style: TextStyle(
                      //       //           color: CustomColors.AppbarColor1,
                      //       //           fontWeight: FontWeight.bold,
                      //       //           fontSize: 11),
                      //       //     )),
                      //       // Positioned(
                      //       //     top: 115,
                      //       //     left: 30,
                      //       //     child: Text(
                      //       //       "Premium feature",
                      //       //       style: TextStyle(
                      //       //           color: CustomColors.AppbarColor1,
                      //       //           fontWeight: FontWeight.bold,
                      //       //           fontSize: 11),
                      //       //     )),
                      //       // Positioned(
                      //       //     top: 140,
                      //       //     left: 30,
                      //       //     child: Container(
                      //       //       height: 30,
                      //       //       width: 100,
                      //       //       decoration: BoxDecoration(
                      //       //           borderRadius:
                      //       //           BorderRadius.circular(5),
                      //       //           color: CustomColors.secondaryColor),
                      //       //       child: Padding(
                      //       //         padding: const EdgeInsets.all(8.0),
                      //       //         child: Center(
                      //       //           child: Text(
                      //       //             "Tty it Now",
                      //       //             style: TextStyle(
                      //       //                 color:
                      //       //                 CustomColors.primaryColor,
                      //       //                 fontWeight: FontWeight.bold,
                      //       //                 fontSize: 11),
                      //       //           ),
                      //       //         ),
                      //       //       ),
                      //       //     )),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Jobs",
                              style: TextStyle(
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllPopularJobs()));
                              },
                              child: Text(
                                "View all",
                                style: TextStyle(
                                    color: CustomColors.lightback,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 170,
                        width: double.infinity,
                        child: popularModel == null
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : popularModel!.data == null
                            ? Center(
                          child: Text("No Popular job to show"),
                        )
                            : ListView.builder(
                          //physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                            popularModel!.data!.length > 5
                                ? 5
                                : popularModel!.data!.length,
                            itemBuilder: (context, index) {
                              return jobCard(context, index,
                                  popularModel!,false, () async {
                                    if(popularModel!.data![index].isFav == true){
                                      removeFromSave(popularModel!.data![index].id);
                                      setState(() {

                                      });
                                    }
                                    else {
                                      SharedPreferences prefs =
                                      await SharedPreferences
                                          .getInstance();
                                      String? userid =
                                      prefs.getString('USERID');
                                      var headers = {
                                        'Cookie':
                                        'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
                                      };
                                      var request = http
                                          .MultipartRequest(
                                          'POST',
                                          Uri.parse(
                                              '${ApiPath
                                                  .baseUrl}save_job'));
                                      request.fields.addAll({
                                        'job_id':
                                        '${popularModel!.data![index]
                                            .id}',
                                        'user_id': '${userid}'
                                      });
                                      print(
                                          "working paramers here ${request
                                              .fields}");
                                      request.headers.addAll(headers);
                                      http.StreamedResponse response =
                                      await request.send();
                                      if (response.statusCode == 200) {
                                        var finalResult = await response
                                            .stream
                                            .bytesToString();
                                        final jsonResponse =
                                        json.decode(finalResult);
                                        if (jsonResponse['status'] ==
                                            true) {
                                          setState(() {
                                            var snackBar = SnackBar(
                                              content: Text(
                                                  '${jsonResponse['message']}'),
                                            );
                                            ScaffoldMessenger.of(
                                                context)
                                                .showSnackBar(snackBar);
                                            getPopularJobs();
                                          });
                                        }
                                      } else {
                                        print(response.reasonPhrase);
                                      }
                                    }
                                  });
                            }),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Jobs",
                              style: TextStyle(
                                  color: CustomColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllRecentJob()));
                              },
                              child: const Text(
                                "View all",
                                style: TextStyle(
                                    color: CustomColors.lightback,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      recentJobModel == null
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : recentJobModel!.data == null
                          ? Center(
                        child: Text("No jobs to show"),
                      )
                          : ListView.builder(
                        //physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount:
                          recentJobModel!.data!.length > 3
                              ? 3
                              : recentJobModel!.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobDetailScreen(
                                          jobData: recentJobModel,
                                          index: index,
                                        )));
                              },
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      recentJobModel!.data![index].img == "" ||
                                          recentJobModel!.data![index].img == null
                                          ? Image.asset(
                                        "",
                                        height: 60,
                                        width: 60,
                                        // fit: BoxFit.fill,
                                      ) : Padding(
                                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: CustomColors.lightgray)),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: Image.network(
                                              "${ApiPath.imageUrl}${recentJobModel!.data![index].img}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/1.4,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 14),
                                                  child: SizedBox(
                                                  //  width: 120,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              top: 10),
                                                          child: Text(recentJobModel!.data![index].designation.toString(),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.bold),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          recentJobModel!
                                                              .data![index].companyName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight.normal),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,

                                                    children: [
                                                      recentJobModel!
                                                          .data![index].veri !=
                                                          "yes"
                                                          ? SizedBox.shrink()
                                                          : Container(
                                                        padding:
                                                        EdgeInsets.all(4),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                            border: Border.all(
                                                                color:
                                                                Colors.green,
                                                                width: 1)),
                                                        child: const Text(
                                                          "Verified",
                                                          style: TextStyle(
                                                              color: Colors.green,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                      // const SizedBox(
                                                      //   width: 5,
                                                      // ),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (recentJobModel!.data![index].isFav == true) {
                                                            removeFromSave("${recentJobModel!.data![index].id}");
                                                          }
                                                          else {saveToJob(recentJobModel!.data![index].id);
                                                          }
                                                        },
                                                        child: Container(
                                                            height: 45,
                                                            width: 45,
                                                            margin: EdgeInsets.only(left: 5),
                                                            decoration: BoxDecoration(
                                                                color: CustomColors.AppbarColor1,
                                                                borderRadius: BorderRadius.circular(50)
                                                            ),
                                                            child: recentJobModel!.data![index].isFav == true
                                                                ? const Icon(Icons.bookmark_rounded, size: 28,
                                                                color: CustomColors.primaryColor)
                                                                : const Icon(Icons.bookmark_outline_outlined, size: 28)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width/1.4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 3,
                                                  bottom: 5,
                                                  top: 10),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(width: 4),
                                                    Container(
                                                      // color: Colors.red,
                                                      width: 80,
                                                      child: recentJobModel!.data![index].salaryRange == 'yearly' ?
                                                      Text(
                                                        "${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].min.toString()))} - "
                                                            "${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].max.toString()))} Yr.",
                                                        style: const TextStyle(
                                                          color: CustomColors.darkblack,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                      ):
                                                      Text(
                                                        "${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].min.toString()))} - "
                                                            "${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].max.toString()))} Mo.",
                                                        style: const TextStyle(
                                                          color: CustomColors.darkblack,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    const VerticalDivider(
                                                      color: CustomColors.lightgray,
                                                      //color of divider
                                                      //width space of divider
                                                      thickness: 1, //thickness of divier line
                                                      //Spacing at the bottom of divider.
                                                    ),
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        recentJobModel!.data![index].location.toString(),
                                                        style: const TextStyle(
                                                            color:
                                                            CustomColors.darkblack,
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    const VerticalDivider(
                                                      color: CustomColors.lightgray,
                                                      //color of divider
                                                      //width space of divider
                                                      thickness: 1, //thickness of divier line
                                                      //Spacing at the bottom of divider.
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      child: Text(
                                                        "${recentJobModel!.data![index].experience.toString()} years",
                                                        overflow: TextOverflow.clip,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          color: CustomColors.darkblack,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      // Column(
                                      //   mainAxisAlignment: MainAxisAlignment
                                      //       .spaceBetween,
                                      //   crossAxisAlignment: CrossAxisAlignment
                                      //       .start,
                                      //   children: [
                                      //
                                      //     Row(
                                      //       crossAxisAlignment:CrossAxisAlignment.start,
                                      //       children: [
                                      //         SizedBox(width: 8,),
                                      //
                                      //         SizedBox(width: 10,),
                                      //         Column(
                                      //           crossAxisAlignment: CrossAxisAlignment
                                      //               .start,
                                      //           children: [
                                      //             Padding(
                                      //               padding: const EdgeInsets
                                      //                   .only(top: 10),
                                      //               child: Text(
                                      //                 recentJobModel!.data![index].designation.toString(),
                                      //                 style: TextStyle(
                                      //                     fontSize: 15,
                                      //                     fontWeight: FontWeight
                                      //                         .bold),
                                      //               ),
                                      //             ),
                                      //             SizedBox(height: 3,),
                                      //             Text(
                                      //               recentJobModel!.data![index].companyName.toString(),
                                      //               style: TextStyle(
                                      //                   fontSize: 13,
                                      //                   fontWeight: FontWeight
                                      //                       .normal),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ],
                                      //     ),
                                      //
                                      //   ],
                                      // ),

                                      ///

                                      // Padding(
                                      //   padding: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 10),
                                      //   child: IntrinsicHeight(
                                      //     child: Row(
                                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //       children: [
                                      //         Expanded(
                                      //           child: Text(
                                      //             "${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].min.toString()))} - ${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].max.toString()))} ${recentJobModel!.data![index].salaryRange}",
                                      //             style: TextStyle(color: CustomColors.darkblack,
                                      //               fontSize: 15,
                                      //               fontWeight: FontWeight
                                      //                   .w500,),
                                      //             textAlign: TextAlign.center,
                                      //           ),
                                      //         ),
                                      //         VerticalDivider(
                                      //           color: CustomColors.lightgray,  //color of divider
                                      //           //width space of divider
                                      //           thickness: 1, //thickness of divier line
                                      //           //Spacing at the bottom of divider.
                                      //         ),
                                      //         Expanded(
                                      //           child: Text(
                                      //             recentJobModel!.data![index].designation.toString(),
                                      //             style: TextStyle(color: CustomColors.darkblack,
                                      //                 fontSize: 15,
                                      //                 fontWeight: FontWeight
                                      //                     .w500),
                                      //             textAlign: TextAlign.center,
                                      //           ),
                                      //         ),
                                      //         VerticalDivider(
                                      //           color:CustomColors.lightgray,  //color of divider
                                      //           //width space of divider
                                      //           thickness: 1, //thickness of divier line
                                      //           //Spacing at the bottom of divider.
                                      //         ),
                                      //
                                      //         Expanded(
                                      //           child: Text(
                                      //             "${ recentJobModel!.data![index].experience.toString()} years",
                                      //             style: TextStyle(color: CustomColors.darkblack,
                                      //               fontSize: 15,
                                      //               fontWeight: FontWeight
                                      //                   .w500,),
                                      //             textAlign: TextAlign.center,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      // IntrinsicHeight(
                                      //   child: Row(
                                      //     children: [
                                      //       Expanded(
                                      //         child: Text(
                                      //           "${recentJobModel!.data![index].min} - ${recentJobModel!.data![index].max} ${recentJobModel!.data![index].salaryRange}",
                                      //           style: TextStyle(color: CustomColors.darkblack,
                                      //             fontSize: 15,
                                      //             fontWeight: FontWeight
                                      //                 .normal,),
                                      //           textAlign: TextAlign.start,
                                      //         ),
                                      //       ),
                                      //       VerticalDivider(
                                      //         color: CustomColors.lightgray,  //color of divider
                                      //        //width space of divider
                                      //         thickness: 1, //thickness of divier line
                                      //       //Spacing at the bottom of divider.
                                      //       ),
                                      //       Expanded(
                                      //         child: Text(
                                      //           recentJobModel!.data![index].designation.toString(),
                                      //           style: TextStyle(color: CustomColors.darkblack,
                                      //               fontSize: 15,
                                      //               fontWeight: FontWeight
                                      //                   .normal),
                                      //           textAlign: TextAlign.center,
                                      //         ),
                                      //       ),
                                      //       VerticalDivider(
                                      //         color:CustomColors.lightgray,  //color of divider
                                      //         //width space of divider
                                      //         thickness: 1, //thickness of divier line
                                      //         //Spacing at the bottom of divider.
                                      //       ),
                                      //
                                      //       Expanded(
                                      //         child: Text(
                                      //           recentJobModel!.data![index].location.toString(),
                                      //           style: TextStyle(color: CustomColors.darkblack,
                                      //             fontSize: 15,
                                      //             fontWeight: FontWeight
                                      //                 .normal,),
                                      //           textAlign: TextAlign.center,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),



          // CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       snap: false,
          //       pinned: true,
          //       floating: false,
          //       flexibleSpace: FlexibleSpaceBar(
          //         centerTitle: true,
          //         // title:   Container(
          //         //   decoration: BoxDecoration(
          //         //       borderRadius: BorderRadius.circular(10),
          //         //       color: CustomColors.AppbarColor1),
          //         //   height: 35,
          //         //   width: MediaQuery.of(context).size.width / 1.6,
          //         //   child: TextFormField(
          //         //     onTap: () {
          //         //       Navigator.push(
          //         //           context,
          //         //           MaterialPageRoute(
          //         //               builder: (context) =>
          //         //                   SearchJob()));
          //         //     },
          //         //     readOnly: true,
          //         //     decoration: InputDecoration(
          //         //         border: InputBorder.none,
          //         //         hintText: "Search your job",
          //         //         hintStyle: TextStyle(fontSize: 12),
          //         //         contentPadding: EdgeInsets.all(0),
          //         //         prefixIcon: Icon(
          //         //           Icons.search,
          //         //           size: 15,
          //         //         )),
          //         //   ),
          //         // ),
          //         background: Container(
          //           padding: EdgeInsets.only(top: 100,left: 12),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               userModel == null
          //                   ? Text(
          //                       "Hello",
          //                       style: TextStyle(
          //                           color: CustomColors.AppbarColor1),
          //                     )
          //                   : Text(
          //                       "Hello ${userModel!.data!.name}",
          //                       style: TextStyle(
          //                           color: CustomColors.AppbarColor1),
          //                     ),
          //                     SizedBox(height: 8,),
          //               Text(
          //                 "Find Your Perfect job with us",
          //                 style: TextStyle(
          //                     color: CustomColors.AppbarColor1,
          //                     fontSize: 22,
          //                     fontWeight: FontWeight.normal),
          //               ),
          //               //             ),
          //             ],
          //           ),
          //         ),
          //
          //         // title: Container(
          //         //   margin: EdgeInsets.only(top: 20),
          //         //   child: Column(
          //         //     children: [
          //         //       Text("Hello",style: TextStyle(color: Colors.white),)
          //         //     ],
          //         //   ),
          //         // ),
          //         //Images.network
          //       ), //FlexibleSpaceBar
          //       expandedHeight: 180,
          //       backgroundColor: CustomColors.grade1,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
          //       ),
          //       leading: Padding(
          //         padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
          //         child: InkWell(
          //           onTap: (){
          //             _key.currentState!.openDrawer();
          //           },
          //           child: Container(
          //             height: 45,
          //             width: 45,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 color: CustomColors.AppbarColor1.withOpacity(0.4)),
          //             child: Icon(Icons.menu),
          //           ),
          //         ),
          //       ),
          //       //IconButton
          //       actions: <Widget>[
          //         Image.asset("assets/images/titleicons.png"),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 10, top: 5,bottom: 5),
          //           child: Container(
          //             height: 45,
          //             width: 45,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 color: CustomColors.AppbarColor1.withOpacity(0.4)),
          //             child: Icon(Icons.notifications_none_outlined),
          //           ),
          //         ), //IconButton
          //       ], //<Widget>[]
          //
          //     ),
          //     SliverList(
          //         delegate: SliverChildListDelegate([
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Container(
          //                 margin: EdgeInsets.only(top: 10),
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(10),
          //                     color: CustomColors.AppbarColor1),
          //                 height: 50,
          //                 width: MediaQuery.of(context).size.width / 1.6,
          //                 child: TextFormField(
          //                   onTap: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) =>
          //                                 SearchJob()));
          //                   },
          //                   readOnly: true,
          //                   decoration: InputDecoration(
          //                       border: InputBorder.none,
          //                       hintText: "Search your job",
          //                       prefixIcon: Icon(
          //                         Icons.search,
          //                       )),
          //                 ),
          //               ),
          //               // Padding(
          //               //   padding: const EdgeInsets.only(left: 5),
          //               //   child: InkWell(
          //               //     onTap: () {
          //               //       setState(() {
          //               //         _key.currentState!.openEndDrawer();
          //               //       });
          //               //     },
          //               //     child: Container(
          //               //         decoration: BoxDecoration(
          //               //             borderRadius: BorderRadius.circular(10),
          //               //             color: CustomColors.AppbarColor1),
          //               //         height: 50,
          //               //         width: 50,
          //               //         child: Icon(Icons.sort)),
          //               //   ),
          //               // ),
          //               SizedBox(
          //                 height: 15,
          //               ),
          //             ],
          //           ),
          //           SingleChildScrollView(
          //             physics: ScrollPhysics(),
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   InkWell(
          //                     onTap: () {
          //                       //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          //                     },
          //                     child: Stack(
          //                       children: [
          //                         Container(
          //                           height:200,
          //                           width: MediaQuery.of(context).size.width,
          //                           child: Image.asset(
          //                               "assets/homeScreen/homejonimages.png",fit: BoxFit.fill,),
          //                         ),
          //                         Align(
          //                           alignment: Alignment.centerLeft,
          //                             // top: 30,
          //                             // left: 30,
          //                             child: Container(
          //                                 height: 180,
          //                               padding: EdgeInsets.only(left: 20,top: 30),
          //                               child: Column(
          //                                 crossAxisAlignment: CrossAxisAlignment.start,
          //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                 children: [
          //                                   Text(
          //                                     "Looking for\nA Job?",
          //                                     style: TextStyle(
          //                                         color: CustomColors.secondaryColor,
          //                                         fontWeight: FontWeight.bold,
          //                                         fontSize: 22),
          //                                   ),
          //                                   Text(
          //                                     "Optimize your whole life with \n Premium feature",
          //                                     style: TextStyle(
          //                                         color: CustomColors.AppbarColor1,
          //                                         fontWeight: FontWeight.bold,
          //                                         fontSize: 11),
          //                                   ),
          //                               Container(
          //                                 height: 30,
          //                                 width: 100,
          //                                 decoration: BoxDecoration(
          //                                     borderRadius:
          //                                     BorderRadius.circular(5),
          //                                     color: CustomColors.secondaryColor),
          //                                 child: Padding(
          //                                   padding: const EdgeInsets.all(8.0),
          //                                   child: Center(
          //                                     child: Text(
          //                                       "Tty it Now",
          //                                       style: TextStyle(
          //                                           color:
          //                                           CustomColors.primaryColor,
          //                                           fontWeight: FontWeight.bold,
          //                                           fontSize: 11),
          //                                     ),
          //                                   ),
          //                                 ),
          //                               )
          //                                 ],
          //                               ),
          //                             )),
          //                         // Positioned(
          //                         //     top: 100,
          //                         //     left: 30,
          //                         //     child: Text(
          //                         //       "Optimize your whole life with ",
          //                         //       style: TextStyle(
          //                         //           color: CustomColors.AppbarColor1,
          //                         //           fontWeight: FontWeight.bold,
          //                         //           fontSize: 11),
          //                         //     )),
          //                         // Positioned(
          //                         //     top: 115,
          //                         //     left: 30,
          //                         //     child: Text(
          //                         //       "Premium feature",
          //                         //       style: TextStyle(
          //                         //           color: CustomColors.AppbarColor1,
          //                         //           fontWeight: FontWeight.bold,
          //                         //           fontSize: 11),
          //                         //     )),
          //                         // Positioned(
          //                         //     top: 140,
          //                         //     left: 30,
          //                         //     child: Container(
          //                         //       height: 30,
          //                         //       width: 100,
          //                         //       decoration: BoxDecoration(
          //                         //           borderRadius:
          //                         //           BorderRadius.circular(5),
          //                         //           color: CustomColors.secondaryColor),
          //                         //       child: Padding(
          //                         //         padding: const EdgeInsets.all(8.0),
          //                         //         child: Center(
          //                         //           child: Text(
          //                         //             "Tty it Now",
          //                         //             style: TextStyle(
          //                         //                 color:
          //                         //                 CustomColors.primaryColor,
          //                         //                 fontWeight: FontWeight.bold,
          //                         //                 fontSize: 11),
          //                         //           ),
          //                         //         ),
          //                         //       ),
          //                         //     )),
          //                       ],
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(
          //                         left: 5, right: 5, top: 10),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           "Popular Jobs",
          //                           style: TextStyle(
          //                               color: CustomColors.primaryColor,
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 18),
          //                         ),
          //                         InkWell(
          //                           onTap: () {
          //                             Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                     builder: (context) =>
          //                                         AllPopularJobs()));
          //                           },
          //                           child: Text(
          //                             "View all",
          //                             style: TextStyle(
          //                                 color: CustomColors.lightback,
          //                                 fontWeight: FontWeight.normal,
          //                                 fontSize: 18),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 10,
          //                   ),
          //                   Container(
          //                     height: 170,
          //                     width: double.infinity,
          //                     child: popularModel == null
          //                         ? Center(
          //                       child: CircularProgressIndicator(),
          //                     )
          //                         : popularModel!.data == null
          //                         ? Center(
          //                       child: Text("No Popular job to show"),
          //                     )
          //                         : ListView.builder(
          //                       //physics: const NeverScrollableScrollPhysics(),
          //                         shrinkWrap: false,
          //                         scrollDirection: Axis.horizontal,
          //                         itemCount:
          //                         popularModel!.data!.length > 5
          //                             ? 5
          //                             : popularModel!.data!.length,
          //                         itemBuilder: (context, index) {
          //                           return jobCard(context, index,
          //                               popularModel!,false, () async {
          //
          //                                 if(popularModel!.data![index].isFav == true){
          //                                   removeFromSave(popularModel!.data![index].id);
          //                                   setState(() {
          //
          //                                   });
          //                                 }
          //                                 else {
          //                                   SharedPreferences prefs =
          //                                   await SharedPreferences
          //                                       .getInstance();
          //                                   String? userid =
          //                                   prefs.getString('USERID');
          //                                   var headers = {
          //                                     'Cookie':
          //                                     'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
          //                                   };
          //                                   var request = http
          //                                       .MultipartRequest(
          //                                       'POST',
          //                                       Uri.parse(
          //                                           '${ApiPath
          //                                               .baseUrl}save_job'));
          //                                   request.fields.addAll({
          //                                     'job_id':
          //                                     '${popularModel!.data![index]
          //                                         .id}',
          //                                     'user_id': '${userid}'
          //                                   });
          //                                   print(
          //                                       "working paramers here ${request
          //                                           .fields}");
          //                                   request.headers.addAll(headers);
          //                                   http.StreamedResponse response =
          //                                   await request.send();
          //                                   if (response.statusCode == 200) {
          //                                     var finalResult = await response
          //                                         .stream
          //                                         .bytesToString();
          //                                     final jsonResponse =
          //                                     json.decode(finalResult);
          //                                     if (jsonResponse['status'] ==
          //                                         true) {
          //                                       setState(() {
          //                                         var snackBar = SnackBar(
          //                                           content: Text(
          //                                               '${jsonResponse['message']}'),
          //                                         );
          //                                         ScaffoldMessenger.of(
          //                                             context)
          //                                             .showSnackBar(snackBar);
          //                                         getPopularJobs();
          //                                       });
          //                                     }
          //                                   } else {
          //                                     print(response.reasonPhrase);
          //                                   }
          //                                 }
          //                               });
          //                         }),
          //                   ),
          //                   SizedBox(
          //                     height: 5,
          //                   ),
          //                   Padding(
          //                     padding:
          //                     EdgeInsets.only(left: 5, right: 5, top: 10),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Text(
          //                           "Recent Jobs",
          //                           style: TextStyle(
          //                               color: CustomColors.primaryColor,
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 18),
          //                         ),
          //                         InkWell(
          //                           onTap: () {
          //                             Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                     builder: (context) =>
          //                                         AllRecentJob()));
          //                           },
          //                           child: Text(
          //                             "View all",
          //                             style: TextStyle(
          //                                 color: CustomColors.lightback,
          //                                 fontWeight: FontWeight.normal,
          //                                 fontSize: 18),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 10,
          //                   ),
          //                   recentJobModel == null
          //                       ? Center(
          //                     child: CircularProgressIndicator(),
          //                   )
          //                       : recentJobModel!.data == null
          //                       ? Center(
          //                     child: Text("No jobs to show"),
          //                   )
          //                       : ListView.builder(
          //                     //physics: const NeverScrollableScrollPhysics(),
          //                       shrinkWrap: true,
          //                       physics: NeverScrollableScrollPhysics(),
          //                       scrollDirection: Axis.vertical,
          //                       itemCount:
          //                       recentJobModel!.data!.length > 3
          //                           ? 3
          //                           : recentJobModel!.data!.length,
          //                       itemBuilder: (context, index) {
          //                         return InkWell(
          //                           onTap: () {
          //                             Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                     builder: (context) =>
          //                                         JobDetailScreen(
          //                                           jobData:
          //                                           recentJobModel,
          //                                           index: index,
          //                                         )));
          //                           },
          //                           child: Container(
          //                             // width: MediaQuery
          //                             //     .of(context)
          //                             //     .size
          //                             //     .width / 1.3,
          //                             child: Card(
          //                               elevation: 5,
          //                               color: Colors.white,
          //                               shape: RoundedRectangleBorder(
          //                                   borderRadius:
          //                                   BorderRadius.circular(
          //                                       10)),
          //                               child: Column(
          //                                 mainAxisSize: MainAxisSize.min,
          //                                 crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                                 mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                                 children: [
          //                                   SizedBox(
          //                                     height: 8,
          //                                   ),
          //                                   Row(
          //                                     mainAxisAlignment:
          //                                     MainAxisAlignment
          //                                         .spaceBetween,
          //                                     crossAxisAlignment:
          //                                     CrossAxisAlignment
          //                                         .start,
          //                                     children: [
          //                                       Row(
          //                                         crossAxisAlignment:
          //                                         CrossAxisAlignment
          //                                             .start,
          //                                         children: [
          //                                           SizedBox(
          //                                             width: 8,
          //                                           ),
          //                                           recentJobModel!
          //                                               .data![
          //                                           index]
          //                                               .img ==
          //                                               "" ||
          //                                               recentJobModel!
          //                                                   .data![
          //                                               index]
          //                                                   .img ==
          //                                                   null
          //                                               ? Image.asset(
          //                                             card[index]
          //                                             ['image'],
          //                                             height: 60,
          //                                             width: 60,
          //                                             // fit: BoxFit.fill,
          //                                           )
          //                                               : Container(
          //                                             height: 60,
          //                                             width: 60,
          //                                             decoration: BoxDecoration(
          //                                                 borderRadius:
          //                                                 BorderRadius.circular(
          //                                                     10),
          //                                                 border: Border.all(
          //                                                     color:
          //                                                     CustomColors.lightgray)),
          //                                             child:
          //                                             ClipRRect(
          //                                               borderRadius:
          //                                               BorderRadius.circular(
          //                                                   10),
          //                                               child: Image
          //                                                   .network(
          //                                                 "${ApiPath.imageUrl}${recentJobModel!.data![index].img}",
          //                                                 fit: BoxFit
          //                                                     .fill,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                           SizedBox(
          //                                             width: 10,
          //                                           ),
          //                                           Column(
          //                                             crossAxisAlignment:
          //                                             CrossAxisAlignment
          //                                                 .start,
          //                                             children: [
          //                                               Padding(
          //                                                 padding:
          //                                                 const EdgeInsets
          //                                                     .only(
          //                                                     top:
          //                                                     10),
          //                                                 child: Text(
          //                                                   recentJobModel!
          //                                                       .data![
          //                                                   index]
          //                                                       .designation
          //                                                       .toString(),
          //                                                   style: TextStyle(
          //                                                       fontSize:
          //                                                       15,
          //                                                       fontWeight:
          //                                                       FontWeight
          //                                                           .bold),
          //                                                 ),
          //                                               ),
          //                                               SizedBox(
          //                                                 height: 3,
          //                                               ),
          //                                               Text(
          //                                                 recentJobModel!
          //                                                     .data![
          //                                                 index]
          //                                                     .companyName
          //                                                     .toString(),
          //                                                 style: TextStyle(
          //                                                     fontSize:
          //                                                     13,
          //                                                     fontWeight:
          //                                                     FontWeight
          //                                                         .normal),
          //                                               ),
          //                                             ],
          //                                           ),
          //                                         ],
          //                                       ),
          //                                       Padding(
          //                                         padding:
          //                                         EdgeInsets.only(
          //                                             top: 5,
          //                                             left: 5),
          //                                         child:
          //                                       Row(
          //                                         children: [
          //                                         recentJobModel!.data![index].veri != "yes" ? SizedBox() :  Container(
          //                                             padding: EdgeInsets.all(4),
          //                                             decoration: BoxDecoration(
          //                                                 borderRadius: BorderRadius.circular(12),
          //                                                 border: Border.all(color: Colors.green,width: 1)
          //                                             ),
          //                                             child:Text("Verified",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
          //                                           ),
          //                                           SizedBox(width: 5,),
          //                                           InkWell(
          //                                             onTap: () async {
          //                                               if (recentJobModel!
          //                                                   .data![
          //                                               index]
          //                                                   .isFav ==
          //                                                   true) {
          //                                                 removeFromSave(
          //                                                     recentJobModel!
          //                                                         .data![
          //                                                     index]
          //                                                         .id);
          //                                                 setState(() {});
          //                                               } else {
          //                                                 SharedPreferences
          //                                                 prefs =
          //                                                 await SharedPreferences
          //                                                     .getInstance();
          //                                                 String? userid =
          //                                                 prefs.getString(
          //                                                     'USERID');
          //                                                 var headers = {
          //                                                   'Cookie':
          //                                                   'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
          //                                                 };
          //                                                 var request = http
          //                                                     .MultipartRequest(
          //                                                     'POST',
          //                                                     Uri.parse(
          //                                                         '${ApiPath.baseUrl}save_job'));
          //                                                 request.fields
          //                                                     .addAll({
          //                                                   'job_id':
          //                                                   '${recentJobModel!.data![index].id}',
          //                                                   'user_id':
          //                                                   '${userid}'
          //                                                 });
          //                                                 request.headers
          //                                                     .addAll(
          //                                                     headers);
          //                                                 http.StreamedResponse
          //                                                 response =
          //                                                 await request
          //                                                     .send();
          //                                                 if (response
          //                                                     .statusCode ==
          //                                                     200) {
          //                                                   var finalResult =
          //                                                   await response
          //                                                       .stream
          //                                                       .bytesToString();
          //                                                   final jsonResponse =
          //                                                   json.decode(
          //                                                       finalResult);
          //                                                   if (jsonResponse[
          //                                                   'status'] ==
          //                                                       true) {
          //                                                     // setState(() {
          //                                                     var snackBar =
          //                                                     SnackBar(
          //                                                       content: Text(
          //                                                           '${jsonResponse['message']}'),
          //                                                     );
          //                                                     ScaffoldMessenger.of(
          //                                                         context)
          //                                                         .showSnackBar(
          //                                                         snackBar);
          //                                                     // });
          //                                                     getRecentJobs();
          //                                                   }
          //                                                 } else {
          //                                                   print(response
          //                                                       .reasonPhrase);
          //                                                 }
          //                                               }
          //                                             },
          //                                             child: Container(
          //                                                 height: 40,
          //                                                 width: 40,
          //                                                 decoration: BoxDecoration(
          //                                                     color: CustomColors
          //                                                         .AppbarColor1,
          //                                                     borderRadius:
          //                                                     BorderRadius
          //                                                         .circular(
          //                                                         50)),
          //                                                 child: recentJobModel!
          //                                                     .data![
          //                                                 index]
          //                                                     .isFav ==
          //                                                     true
          //                                                     ? Icon(
          //                                                   Icons
          //                                                       .bookmark_rounded,
          //                                                   size: 28,
          //                                                   color: CustomColors
          //                                                       .primaryColor,
          //                                                 )
          //                                                     : Icon(
          //                                                   Icons
          //                                                       .bookmark_outline_outlined,
          //                                                   size: 28,
          //                                                 )),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                   Padding(
          //                                     padding: EdgeInsets.only(
          //                                         left: 10,
          //                                         right: 10,
          //                                         bottom: 5,
          //                                         top: 10),
          //                                     child: IntrinsicHeight(
          //                                       child: Row(
          //                                         mainAxisAlignment:
          //                                         MainAxisAlignment
          //                                             .spaceBetween,
          //                                         children: [
          //                                           Expanded(
          //                                             child: Text(
          //                                               "${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].min.toString()))} - ${NumberFormat.compact().format(int.parse(recentJobModel!.data![index].max.toString()))} ${recentJobModel!.data![index].salaryRange}",
          //                                               style: TextStyle(
          //                                                 color: CustomColors
          //                                                     .darkblack,
          //                                                 fontSize: 15,
          //                                                 fontWeight:
          //                                                 FontWeight
          //                                                     .w500,
          //                                               ),
          //                                               textAlign:
          //                                               TextAlign
          //                                                   .center,
          //                                             ),
          //                                           ),
          //                                           VerticalDivider(
          //                                             color: CustomColors
          //                                                 .lightgray, //color of divider
          //                                             //width space of divider
          //                                             thickness:
          //                                             1, //thickness of divier line
          //                                             //Spacing at the bottom of divider.
          //                                           ),
          //                                           Expanded(
          //                                             child: Text(
          //                                               recentJobModel!
          //                                                   .data![index]
          //                                                   .designation
          //                                                   .toString(),
          //                                               style: TextStyle(
          //                                                   color: CustomColors
          //                                                       .darkblack,
          //                                                   fontSize: 15,
          //                                                   fontWeight:
          //                                                   FontWeight
          //                                                       .w500),
          //                                               textAlign:
          //                                               TextAlign
          //                                                   .center,
          //                                             ),
          //                                           ),
          //                                           VerticalDivider(
          //                                             color: CustomColors
          //                                                 .lightgray, //color of divider
          //                                             //width space of divider
          //                                             thickness:
          //                                             1, //thickness of divier line
          //                                             //Spacing at the bottom of divider.
          //                                           ),
          //                                           Expanded(
          //                                             child: Text(
          //                                               recentJobModel!
          //                                                   .data![index]
          //                                                   .location
          //                                                   .toString(),
          //                                               style: TextStyle(
          //                                                 color: CustomColors
          //                                                     .darkblack,
          //                                                 fontSize: 15,
          //                                                 fontWeight:
          //                                                 FontWeight
          //                                                     .w500,
          //                                               ),
          //                                               textAlign:
          //                                               TextAlign
          //                                                   .center,
          //                                             ),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   // IntrinsicHeight(
          //                                   //   child: Row(
          //                                   //     children: [
          //                                   //       Expanded(
          //                                   //         child: Text(
          //                                   //           "${recentJobModel!.data![index].min} - ${recentJobModel!.data![index].max} ${recentJobModel!.data![index].salaryRange}",
          //                                   //           style: TextStyle(color: CustomColors.darkblack,
          //                                   //             fontSize: 15,
          //                                   //             fontWeight: FontWeight
          //                                   //                 .normal,),
          //                                   //           textAlign: TextAlign.start,
          //                                   //         ),
          //                                   //       ),
          //                                   //       VerticalDivider(
          //                                   //         color: CustomColors.lightgray,  //color of divider
          //                                   //        //width space of divider
          //                                   //         thickness: 1, //thickness of divier line
          //                                   //       //Spacing at the bottom of divider.
          //                                   //       ),
          //                                   //       Expanded(
          //                                   //         child: Text(
          //                                   //           recentJobModel!.data![index].designation.toString(),
          //                                   //           style: TextStyle(color: CustomColors.darkblack,
          //                                   //               fontSize: 15,
          //                                   //               fontWeight: FontWeight
          //                                   //                   .normal),
          //                                   //           textAlign: TextAlign.center,
          //                                   //         ),
          //                                   //       ),
          //                                   //       VerticalDivider(
          //                                   //         color:CustomColors.lightgray,  //color of divider
          //                                   //         //width space of divider
          //                                   //         thickness: 1, //thickness of divier line
          //                                   //         //Spacing at the bottom of divider.
          //                                   //       ),
          //                                   //
          //                                   //       Expanded(
          //                                   //         child: Text(
          //                                   //           recentJobModel!.data![index].location.toString(),
          //                                   //           style: TextStyle(color: CustomColors.darkblack,
          //                                   //             fontSize: 15,
          //                                   //             fontWeight: FontWeight
          //                                   //                 .normal,),
          //                                   //           textAlign: TextAlign.center,
          //                                   //         ),
          //                                   //       ),
          //                                   //     ],
          //                                   //   ),
          //                                   // ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         );
          //                       }),
          //                 ],
          //               ),
          //             ),
          //           )
          //     ]) //SliverChildBuildDelegate
          //         ) //SliverList
          //   ], //<Widget>[]
          // )
        ));
  }

  getDrawer() {
    return Drawer(
      //  color: Colors.white,
      width: MediaQuery.of(context).size.width /1.5,
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
                  radius: 40,
                  backgroundImage:
                  userModel == null  ? NetworkImage(
                    "https://www.w3schools.com/howto/img_avatar.png",
                  ) : userModel!.data!.img == ""  ? NetworkImage(
                    "https://www.w3schools.com/howto/img_avatar.png",
                  ) : NetworkImage("${userModel!.data!.img}"),
                ),
                SizedBox(
                  width: 10,
                ),
                userModel == null || userModel!.data == null
                    ? SizedBox.shrink()
                    : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:120,
                        padding: EdgeInsets.only(right: 4),
                        child: Text(
                          "${userModel!.data!.name}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: 120,
                        padding: EdgeInsets.only(right: 4),
                        child: Text(
                          "${userModel!.data!.email}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                          maxLines: 2,
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
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/user.png",
              height: 40,
              width: 40,
            ),
            title: Text(' My Profile ',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (Context) => ProfileScreen()));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen()),
              // );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/savedJob.png",
              height: 40,
              width: 40,
            ),
            title: Text('My Saved Jobs ',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SavedJob(
                      isValue: true,
                    )),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/appliedJob.png",
              height: 40,
              width: 40,
            ),
            title: Text('Apply Jobs',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ApplyJob(
                      isValue: true,
                    )),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/changePassword.png",
              height: 40,
              width: 40,
            ),
            title: Text('Change Password',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/user.png",
              height: 40,
              width: 40,
            ),
            title: Text('All Recruiters',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllRecruiters()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/shareApp.png",
              height: 40,
              width: 40,
            ),
            title: Text('Share App',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () async {
              await FlutterShare.share(
                  title: 'Share',
                  text: 'Hire my mate',
                  linkUrl: 'https://flutter.dev/',
                  chooserTitle: 'Dummy link');
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()),
              //   );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/contactus.png",
              height: 40,
              width: 40,
            ),
            title: Text('Contact Us',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CantactUs()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/privacyPolicy.png",
              height: 40,
              width: 40,
            ),
            title: Text('Privacy Policy',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/supportHelp.png",
              height: 40,
              width: 40,
            ),
            title: Text('About Us',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/supportHelp.png",
              height: 40,
              width: 40,
            ),
            title: Text('Support & Help',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupportHelp()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/termCondition.png",
              height: 40,
              width: 40,
            ),
            title: Text('Term & Conditions',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermConditions()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/drawerImages/signout.png",
              height: 40,
              width: 40,
            ),
            title: Text('Sign Out ',
                style: TextStyle(color: CustomColors.primaryColor)),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setString('USERID', "");
                prefs.setString('Role', "");
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false);
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
