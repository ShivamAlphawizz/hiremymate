import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Model/SavedModel.dart';
import 'package:hiremymate/Model/recentJobModel.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomCard.dart';
import 'package:http/http.dart' as http;

import 'jobDescription.dart';

class SavedJob extends StatefulWidget {
  bool? isValue;
  SavedJob({this.isValue});

  @override
  State<SavedJob> createState() => _SavedJobState();
}

class _SavedJobState extends State<SavedJob> {
  // List<Map<String, dynamic>> cardUi = [
  //   {
  //     'image': "assets/homeScreen/homeScreenimage1.png",
  //     'text': 'Aglowid IT Solutions PVT. LTD.',
  //     'address': 'Mumbai',
  //     "time": "Ui/Ux designer",
  //     "paytext":"₹60k-25k PA",
  //     "area":"Pune"
  //
  //   },
  //   {
  //     'image': "assets/homeScreen/homeScreenimage2.png",
  //     'text': 'Aglowid IT Solutions PVT. LTD.',
  //     'address': 'Mumbai',
  //     "time": "Ui/Ux designer",
  //     "paytext":"₹60k-25k PA",
  //     "area":"Pune"
  //   },
  //
  //   {
  //     'image': "assets/homeScreen/homeScreenimage3.png",
  //     'text': 'Aglowid IT Solutions PVT. LTD.',
  //     'address': 'Mumbai',
  //     "time": "Ui/Ux designer",
  //     "paytext":"₹60k-25k PA",
  //     "area":"Pune"
  //   },
  //   {
  //     'image': "assets/homeScreen/homeScreenimage3.png",
  //     'text': 'Aglowid IT Solutions PVT. LTD.',
  //     'address': 'Mumbai',
  //     "time": "Ui/Ux designer",
  //     "paytext":"₹60k-25k PA",
  //     "area":"Pune"
  //   },
  //   {
  //     'image': "assets/homeScreen/homeScreenimage3.png",
  //     'text': 'Aglowid IT Solutions PVT. LTD.',
  //     'address': 'Mumbai',
  //     "time": "Ui/Ux designer",
  //     "paytext":"₹60k-25k PA",
  //     "area":"Pune"
  //   },
  //
  //   // {"image": "assets/images/2022.png", "name":"Party night" ,"location":"assets/images/location.png","address": "Palsia, Indore"},
  // ];


  RecentJobModel? savedModel;

  getSavedJob()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=c03fd531f6e64d6e778aecae55d7be23fdc8db6d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}favorite_list'));
    request.fields.addAll({
      'user_id': '$userid'
    });
    print('${ApiPath.baseUrl}favorite_list   ---- and ${request.fields}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = RecentJobModel.fromJson(json.decode(finalResult));
      setState(() {
        savedModel =  jsonResponse;
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
      return getSavedJob();
    });
  }

  removeFromSave(id)async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    String? userid  = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=5a37ed79b483f5766738a21c88679dc79add7041'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}remove_fav_job'));
    request.fields.addAll({
      'job_id': '${id}',
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true) {
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          getSavedJob();
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }

  RecentJobModel? job;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.TransparentColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(text: "My Saved Jobs",istrue: widget.isValue! ? true : false,),
            Expanded(
              child: savedModel == null  ? Center(child: CircularProgressIndicator(),) : savedModel!.data!.length == 0 ? Center(child: Text("No jobs to show"),) :   ListView.builder(
                 // physics:  NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                   // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: savedModel!.data!.length,
                  itemBuilder: (context, index) {
                    return  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailScreen(jobData: savedModel,index: index,)));
                      },
                      child: Container(
                        // height: 150,
                        padding: EdgeInsets.symmetric(horizontal: 8 ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.05,
                        child:Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            mainAxisAlignment: MainAxisAlignment
                                .start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.all(
                                              8.0),
                                          child:  savedModel!.data![index].img == " " || savedModel!.data![index].img == null ? Center(child: SizedBox(),):
                                          Container(height: 60,width: 60,decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: CustomColors.lightgray),
                                          ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network("${savedModel!.data![index].img}",fit: BoxFit.fill,),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets
                                                  .only(top: 20),
                                              child: Text(
                                                "${savedModel!.data![index].companyName}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              "${savedModel!.data![index].location}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight
                                                      .normal),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 5),
                                    child: InkWell(
                                      onTap: (){
                                        removeFromSave(savedModel!.data![index].id);
                                      },

                                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                                      // String? userid = prefs.getString('USERID');
                                      // var headers = {
                                      //   'Cookie': 'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
                                      // };
                                      // var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}save_job'));
                                      // request.fields.addAll({
                                      //   'job_id': '${ popularJob.data![index].id}',
                                      //   'user_id': '${userid}'
                                      // });
                                      // request.headers.addAll(headers);
                                      // http.StreamedResponse response = await request.send();
                                      // if (response.statusCode == 200) {
                                      //   var finalResult = await response.stream.bytesToString();
                                      //   final jsonResponse = json.decode(finalResult);
                                      //   if(jsonResponse['status'] == true){
                                      //     // setState(() {
                                      //       var snackBar = SnackBar(
                                      //         content: Text('${jsonResponse['message']}'),
                                      //       );
                                      //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      //     // });
                                      //   }
                                      //
                                      // }
                                      // else {
                                      //   print(response.reasonPhrase);
                                      // }

                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: CustomColors
                                                  .AppbarColor1,
                                              borderRadius: BorderRadius
                                                  .circular(50)
                                          ),
                                          child: savedModel!.data![index].isFav == true ? Icon(Icons.bookmark,size: 28,color: CustomColors.primaryColor,) : Icon(Icons.bookmark_outline_outlined,size: 28,)
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: IntrinsicHeight (
                                  child: Row(
                                    children: [
                                      Text(
                                        "${savedModel!.data![index].designation}",
                                        style: TextStyle(color: CustomColors.darkblack,
                                            fontSize: 15,
                                            fontWeight: FontWeight
                                                .normal),
                                      ),
                                      VerticalDivider(
                                        color: Colors.black,  //color of divider
                                        //Spacing at the bottom of divider.
                                      ),
                                      savedModel!.data![index].min == " " || savedModel!.data![index].min == null ? Center(child: SizedBox(),):
                                      Expanded(
                                        child: Text(
                                          "\u{20B9}${NumberFormat.compact().format(int.parse(savedModel!.data![index].min.toString()))}-"
                                              "${NumberFormat.compact().format(int.parse(savedModel!.data![index].max.toString()))} ${savedModel!.data![index].salaryRange}",
                                          style: TextStyle(color: CustomColors.darkblack,
                                            fontSize: 15,
                                            fontWeight: FontWeight
                                                .normal,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: CustomColors.lightback,
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left : 8.0, top: 8,right: 8,bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(0.5),
                                          height: 40,
                                          width: 80,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: CustomColors.lightback.withOpacity(0.4),
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Center(child: Text("${savedModel!.data![index].jobType}",textAlign: TextAlign.center,)),
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          padding: EdgeInsets.all(0.5),
                                          height: 40,
                                          width: 80,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: CustomColors.lightback.withOpacity(0.4),
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Center(child: Text("${savedModel!.data![index].location}",textAlign: TextAlign.center,)),
                                        ),
                                        SizedBox(width: 9),
                                        Container(
                                          padding: EdgeInsets.all(0.9),
                                          height: 40,
                                          width: 80,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: CustomColors.lightback.withOpacity(0.4),
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Center(child: Text("${savedModel!.data![index].experience} year", textAlign: TextAlign.center)),
                                        ),
                                      ],
                                    ),
                                    //Text("${savedModel!.data![index].days} days ago",style: TextStyle(color: CustomColors.secondaryColor),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  }),
            )
          ],
        ),
      ),
    );
  }
}
 