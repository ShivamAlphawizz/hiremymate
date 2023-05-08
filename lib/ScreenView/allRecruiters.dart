import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/RecruiterSection/companyDetails.dart';
import 'package:hiremymate/RecruiterSection/companyDetailsRecuiter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/ColorClass.dart';
import '../Model/AllRecruiterModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomCard.dart';
import 'package:http/http.dart' as http;

class AllRecruiters extends StatefulWidget {
  const AllRecruiters({Key? key}) : super(key: key);

  @override
  State<AllRecruiters> createState() => _AllRecruitersState();
}

class _AllRecruitersState extends State<AllRecruiters> {
  bool isSelected = false;

  AllRecruiterModel? allRecruiterModel;

  getAllRecruiterList()async{
    var headers = {
      'Cookie': 'ci_session=b2c63ad9a1350c2ef462afeb0661e0ab3249d138'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}all_recruiters'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse =  await response.stream.bytesToString();
      final jsonResponse = AllRecruiterModel.fromJson(json.decode(finalResponse));
      setState(() {
        allRecruiterModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 400),(){
      return getAllRecruiterList();
    });
  }

  List<Map<String, dynamic>> requiterUi = [
    {
      'image': "assets/homeScreen/homeScreenimage1.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'ORG id : 50',
      "time": "HR : Sachin Kamble",
      "paytext":"Mumbai , Maharashtra",
      "email":"Rajpoot@gmail.com",
      "phone":"7024669820"
    },
    {
      'image': "assets/homeScreen/homeScreenimage2.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'ORG id : 50',
      "time": "HR : Sachin Kamble",
      "paytext":"Mumbai , Maharashtra",
      "email":"Rajpoot@gmail.com",
      "phone":"7024669820"
    },

    {
      'image': "assets/homeScreen/homeScreenimage3.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'ORG id : 50',
      "time": "HR : Sachin Kamble",
      "paytext":"Mumbai , Maharashtra",
      "email":"Rajpoot@gmail.com",
      "phone":"7024669820"
    },
    {
      'image': "assets/homeScreen/homeScreenimage3.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'ORG id : 50',
      "time": "HR : Sachin Kamble",
      "paytext":"Mumbai , Maharashtra",
      "email":"Rajpoot@gmail.com",
      "phone":"7024669820"
    },
    {
      'image': "assets/homeScreen/homeScreenimage3.png",
      'text': 'Aglowid IT Solutions PVT. LTD.',
      'address': 'ORG id : 50',
      "time": "HR : Sachin Kamble",
      "paytext":"Mumbai , Maharashtra",
      "email":"Rajpoot@gmail.com",
      "phone":"7024669820"
    },

    // {"image": "assets/images/2022.png", "name":"card night" ,"location":"assets/images/location.png","address": "Palsia, Indore"},
  ];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "All Recruiters",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body:   Container(
            // height:MediaQuery.of(context).size.height,
            child: allRecruiterModel ==null ? Center(child: CircularProgressIndicator(),) :  allRecruiterModel!.data == null ? Center(child: Text("No data to show"),) : ListView.builder(
                physics:  AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: allRecruiterModel!.data!.length,
                itemBuilder: (context, index) {
                  return recruiterCard(context,index,allRecruiterModel);
                }),
          ),
      ),
    );
  }

  Widget recruiterCard(BuildContext context, int index, recruiterDetail){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      // height: 150,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child:Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start,
            mainAxisAlignment: MainAxisAlignment
                .start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: CustomColors.lightgray)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "${allRecruiterModel!.data![index].img}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            "${allRecruiterModel!.data![index].company}",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight
                                    .bold),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                "ORG Id : 50",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .normal),
                              ),
                              Container(
                                height: 15,
                                child: VerticalDivider(

                                  thickness: 1,
                                  color: CustomColors.lightback,
                                ),
                              ),
                              Text(
                                "HR : ${allRecruiterModel!.data![index].name}",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .normal),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Container(
                                // margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: CustomColors.lightback)
                                ),
                                child: Icon(Icons.location_on_outlined,color: CustomColors.grade,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "${allRecruiterModel!.data![index].location}",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .normal),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                // margin: const EdgeInsets.all(15.0),
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: CustomColors.lightback)
                                ),
                                child: Icon(Icons.mail_outline_rounded,color: CustomColors.grade,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "${allRecruiterModel!.data![index].email}",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .normal),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                // margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: CustomColors.lightback)
                                ),
                                child: Icon(Icons.call,color: CustomColors.grade,size: 15,),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "${allRecruiterModel!.data![index].mno}",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight
                                        .normal),
                              ),
                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                  // Container(
                  //     height: 40,
                  //     width: 40,
                  //     decoration: BoxDecoration(
                  //         color: CustomColors
                  //             .AppbarColor1,
                  //         borderRadius: BorderRadius
                  //             .circular(50)
                  //     ),
                  //     child: Image.asset(
                  //         "assets/homeScreen/jobpath.png")
                  // ),

                ],
              ),
              Divider(
                thickness: 1,
                color: CustomColors.lightback,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => companyDetailsRecuiter(id: allRecruiterModel!.data![index].id,)));
                      },
                      child: Container(
                        height: 40,
                        padding:  EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected  ?  CustomColors.grade: Colors.transparent,
                            border: Border.all(color:isSelected  ? CustomColors.lightback: CustomColors.grade)
                        ),
                        child: Text('DETAILS',style: TextStyle(color: CustomColors.grade1,fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: InkWell(
                      onTap: ()async{
                        var url = "tel:${allRecruiterModel!.data![index].mno}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        padding:  EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:isSelected  ? Colors.transparent: CustomColors.grade,
                             border: Border.all(color:isSelected  ? CustomColors.grade: CustomColors.lightback)
                        ),
                        child: Text('CALL HR',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
