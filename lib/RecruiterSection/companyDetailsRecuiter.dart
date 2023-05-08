import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/ScreenView/jobDescription.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../Model/RecruiterDetailModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';
import '../buttons/CustomCard.dart';
import 'package:http/http.dart' as http;

class companyDetailsRecuiter extends StatefulWidget {
  final String? id;
  companyDetailsRecuiter({this.id});

  @override
  State<companyDetailsRecuiter> createState() => _companyDetailsRecuiterState();
}

class _companyDetailsRecuiterState extends State<companyDetailsRecuiter> {

  RecruiterDetailModel? recruiterDetailModel;

  getRecruiterDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=098ac49b7659ec1528e9017f60d95cd19ea6776d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}all_recruiters/${widget.id}'));

    request.fields.addAll({
      'logged_id': '$userid'
    });
    print("oooooooooo ${userid} ${ApiPath.baseUrl}all_recruiters/${widget.id}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse =  await response.stream.bytesToString();
      final jsonResponse = RecruiterDetailModel.fromJson(json.decode(finalResponse));
      print("sdsdfs ${jsonResponse.data}");
      setState(() {
        recruiterDetailModel = jsonResponse;
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
      return getRecruiterDetail();
    });
  }


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: customAppBar(text: "Company Details",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body:  recruiterDetailModel == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(
            itemCount: recruiterDetailModel!.data!.length,
            shrinkWrap: true,
            itemBuilder: (c,i){
          return  Padding(
            padding: EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                 height:MediaQuery.of(context).size.height/2.6,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 50,
                          right: 0,
                          left: 0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            elevation: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.height/3.5,
                              decoration: BoxDecoration(
                                  color: CustomColors.AppbarColor1,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          )
                      ),
                      Positioned (
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Container(
                               height:110,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: CustomColors.lightgray)
                                ),
                                child:
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network("${recruiterDetailModel!.data![0].img}",fit: BoxFit.fill,))
                            )
                          ],
                        ),
                      ),
                      Positioned (
                        top:MediaQuery.of(context).size.height/5.5,
                        right: 0,
                        left: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${recruiterDetailModel!.data![0].company}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.bold,fontSize: 20),),
                            // Text("Aglowid IT Solutions PVT. LTD.",style: TextStyle(color: CustomColors.lightblackAllText,fontWeight: FontWeight.normal,fontSize: 18)),
                           // SizedBox(height: 5,),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 20,right: 20),
                            //   child: Divider(color: CustomColors.lightblackAllText.withOpacity(0.5),thickness: 1,),
                            // ),
                            SizedBox(height: 8,),
                            Container(
                              width: 130,
                              // margin: EdgeInsets.all(15.0),
                              padding:  EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: CustomColors.lightback)
                              ),
                              child: Row(
                                children: [
                                  Icon((Icons.person_pin),color: Colors.red,size: 30,),
                                  SizedBox(height: 5,),
                                  Text("Active Post",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon((Icons.person_pin),color: CustomColors.darkblack,size: 30,),
                                  SizedBox(height: 5,),
                                  Text("${recruiterDetailModel!.data![0].website}",style: TextStyle(color: CustomColors.darkblack,fontSize: 14),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                  child: Container(
                    width: double.maxFinite,

                    decoration: BoxDecoration(
                        color: CustomColors.AppbarColor1,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Company Description",style: TextStyle(color: CustomColors.primaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width/1.2,
                                child: Text("${recruiterDetailModel!.data![0].des}"
                                  ,style: TextStyle(color: CustomColors.darkblack,fontSize: 14,fontWeight: FontWeight.normal,overflow: TextOverflow.ellipsis),maxLines: 4,),
                              ),
                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Email: ",style: TextStyle(color: CustomColors.darkblack,fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text("${recruiterDetailModel!.data![0].email}",style: TextStyle(color: CustomColors.lightback,fontSize: 14),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Numbe: ",style: TextStyle(color: CustomColors.darkblack,fontSize: 16),),
                                  SizedBox(height: 5,),
                                  Text("${recruiterDetailModel!.data![0].mno}",style: TextStyle(color: CustomColors.lightback,fontSize: 14),)
                                ],
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                recruiterDetailModel!.data![0].job!.length == 0  ? SizedBox.shrink() :  Container(
                  height: 50,
                  color: CustomColors.secondaryColor,
                  child: Center(child: Text("Current Openings",style: TextStyle(color: CustomColors.darkblack,fontSize: 16,fontWeight: FontWeight.bold),)),
                ),
                Container(
                  color: CustomColors.secondaryColor.withOpacity(0.2),
                  child: recruiterDetailModel!.data![0].job == null ? SizedBox.shrink() : ListView.builder(
                      physics:  NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: recruiterDetailModel!.data![0].job!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: (){
                             // Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailScreen(isApplied: false,index: index,jobData: ,)));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AppliedJobDetails()));
                            },
                            child:  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                // height: 150,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child:Card(
                                  elevation: 5,
                                  color: Colors.white ,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              height:60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: CustomColors.lightgray)
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(
                                                  "${ApiPath.imageUrl}${recruiterDetailModel!.data![0].job![index].img}",
                                                   fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(top: 20),
                                                  child: Text(
                                                   "${recruiterDetailModel!.data![0].job![index].companyName}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                Text(
                                                  "${recruiterDetailModel!.data![0].job![index].location}",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight
                                                          .normal),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(width: MediaQuery.of(context).size.width/6.0,),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       top: 10, left: 5),
                                            //   child: Container(
                                            //       height: 40,
                                            //       width: 40,
                                            //       decoration: BoxDecoration(
                                            //           color: CustomColors
                                            //               .AppbarColor1,
                                            //           borderRadius: BorderRadius
                                            //               .circular(50)
                                            //       ),
                                            //       child: Image.asset(
                                            //           "assets/homeScreen/jobpath.png")
                                            //   ),
                                            // ),

                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10,top: 5),
                                        child: IntrinsicHeight (
                                          child: Row( 
                                            children: [
                                              Text(
                                               "${recruiterDetailModel!.data![0].job![index].designation}",
                                                style: TextStyle(color: CustomColors.darkblack,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .normal),
                                              ),    SizedBox(width: 2,),

                                              VerticalDivider(
                                                color: Colors.black,  //color of divider
                                                width: 3, //width space of divider
                                                //Spacing at the bottom of divider.
                                              ),
                                              SizedBox(width: 2,),
                                              Text(
                                                "\u{20B9}${NumberFormat.compact().format(int.parse(recruiterDetailModel!.data![0].job![index].min.toString()))}-${NumberFormat.compact().format(int.parse(recruiterDetailModel!.data![0].job![index].max.toString()))} ${recruiterDetailModel!.data![0].job![index].salaryRange}",
                                                style: TextStyle(color: CustomColors.darkblack,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .normal,),
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
                                        padding:  EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color: CustomColors.lightback.withOpacity(0.4),
                                                  borderRadius: BorderRadius.circular(30)
                                              ),
                                              child: Center(child: Text("${recruiterDetailModel!.data![0].job![index].jobType}")),
                                            ),
                                            SizedBox(width: 5,),
                                            Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color: CustomColors.lightback.withOpacity(0.4),
                                                  borderRadius: BorderRadius.circular(30)
                                              ),
                                              child: Center(child: Text("${recruiterDetailModel!.data![0].job![index].location}")),
                                            ),
                                            SizedBox(width: 5,),
                                            Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color: CustomColors.lightback.withOpacity(0.4),
                                                  borderRadius: BorderRadius.circular(30)
                                              ),
                                              child: Center(child: Text("${recruiterDetailModel!.data![0].job![index].experience} year")),
                                            ),
                                            SizedBox(width: 5,),
                                           // Text("${recruiterDetailModel!.data![0].job![index].d} days ago",style: TextStyle(color: CustomColors.secondaryColor),)
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,)


                                    ],
                                  ),
                                ),
                              ),
                            ));
                      }),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(5.0),
                //   child: CustomAppBtn(
                //     height: 50,
                //     width: double.maxFinite,
                //     title: 'APPLY',
                //     onPress: () {
                //       // Navigator.push(context,
                //       //     MaterialPageRoute(builder: (context) => SuccessScreen()));
                //     },
                //   ),
                // ),
                SizedBox(height: 20,),

              ],
            ),
          );
        }),

      ),
    );
  }
}
