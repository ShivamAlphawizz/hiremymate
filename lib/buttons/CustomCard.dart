import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/Model/recentJobModel.dart';
import 'package:hiremymate/ScreenView/jobDescription.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import 'package:http/http.dart' as http;

List<Map<String, dynamic>> cardUi = [
  {
    'image': "assets/homeScreen/homeScreenimage1.png",
    'text': 'Aglowid IT Solutions PVT. LTD.',
    'address': 'Mumbai',
    "time": "Ui/Ux designer",
    "paytext":"₹60k-25k PA",
    "area":"Pune"

  },
  {
    'image': "assets/homeScreen/homeScreenimage2.png",
    'text': 'Aglowid IT Solutions PVT. LTD.',
    'address': 'Mumbai',
    "time": "Ui/Ux designer",
    "paytext":"₹60k-25k PA",
    "area":"Pune"
  },

  {
    'image': "assets/homeScreen/homeScreenimage3.png",
    'text': 'Aglowid IT Solutions PVT. LTD.',
    'address': 'Mumbai',
    "time": "Ui/Ux designer",
    "paytext":"₹60k-25k PA",
    "area":"Pune"
  },
  {
    'image': "assets/homeScreen/homeScreenimage3.png",
    'text': 'Aglowid IT Solutions PVT. LTD.',
    'address': 'Mumbai',
    "time": "Ui/Ux designer",
    "paytext":"₹60k-25k PA",
    "area":"Pune"
  },
  {
    'image': "assets/homeScreen/homeScreenimage3.png",
    'text': 'Aglowid IT Solutions PVT. LTD.',
    'address': 'Mumbai',
    "time": "Ui/Ux designer",
    "paytext":"₹60k-25k PA",
    "area":"Pune"
  },

  // {"image": "assets/images/2022.png", "name":"card night" ,"location":"assets/images/location.png","address": "Palsia, Indore"},
];
List<Map<String, dynamic>> chatCard = [
  {
    'image': "assets/homeScreen/homeScreenimage1.png",
    'text': 'Ankit garwal',
    'address': 'What is the status of job interview ?',
    "month": "Jun11",


  },
  {
    'image': "assets/homeScreen/homeScreenimage2.png",
    'text': 'Johan',
    'address': 'What is the status of job interview ?',
    "month": "Feb",

  },

  {
    'image': "assets/homeScreen/homeScreenimage3.png",
    'text': 'Jack',
    'address': 'What is the status of job interview ?',
    "month": "Mar",

  },
  {
    'image': "assets/homeScreen/homeScreenimage3.png",
    'text': 'Suresh',
    'address': 'What is the status of job interview ?',
    "month": "Apr",

  },
  {
    'image': "assets/homeScreen/homeScreenimage3.png",
    'text': 'Ravindra Sahu',
    'address': 'What is the status of job interview ?',
    "month": "May",

  },

  // {"image": "assets/images/2022.png", "name":"card night" ,"location":"assets/images/location.png","address": "Palsia, Indore"},
];

Widget jobCard(BuildContext context, int index, RecentJobModel popularJob,bool isAppliedValue, VoidCallback onPress ){
  print("checking fav status here ${popularJob.data![index].days}");
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailScreen(jobData: popularJob,index: index, isApplied: isAppliedValue == true ? true : false,)));
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
                       child: popularJob.data![index].img == null || popularJob!.data![index].img == ""  ? Image.asset(
                         cardUi[index]['image'],
                         height: 60,
                         width: 60,
                         // fit: BoxFit.fill,
                       ) : Container(height: 60,width: 60,decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: CustomColors.lightgray),),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child: popularJob.data![index].img!.contains('https:') ? Image.network("${popularJob.data![index].img}",fit: BoxFit.fill,) : Image.network("${ApiPath.imageUrl}${popularJob.data![index].img}",fit: BoxFit.fill,),
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
                             "${popularJob.data![index].companyName}",
                             style: TextStyle(
                                 fontSize: 13,
                                 fontWeight: FontWeight
                                     .bold),
                           ),
                         ),
                         SizedBox(height: 5,),
                         Text(
                           "${popularJob.data![index].location}",
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
                    onTap: onPress,

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

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
               popularJob.data![index].veri == "__" ? SizedBox.shrink(): Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green,width: 1)
                        ),
                        child:Text("Verified",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                      ),
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: CustomColors
                                    .AppbarColor1,
                                borderRadius: BorderRadius
                                    .circular(50)
                            ),
                            child: popularJob.data![index].isFav == true ? Icon(Icons.bookmark,size: 28,color: CustomColors.primaryColor,) : Icon(Icons.bookmark_outline_outlined,size: 28,)
                        ),
                      ],
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
                      "${popularJob.data![index].designation}",
                      style: TextStyle(color: CustomColors.darkblack,
                          fontSize: 13,
                          fontWeight: FontWeight
                              .normal),
                    ),
                    VerticalDivider(
                      color: Colors.black,  //color of divider
                      //Spacing at the bottom of divider.
                    ),
                    Expanded(
                      child: Text(
                        "\u{20B9}${NumberFormat.compact().format(int.parse(popularJob.data![index].min.toString()))}-${NumberFormat.compact().format(int.parse(popularJob.data![index].max.toString()))} ${popularJob.data![index].salaryRange}",
                        style: TextStyle(color: CustomColors.darkblack,
                          fontSize: 12,
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
              padding:  EdgeInsets.only(left : 8.0, top: 2,right: 8,bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(0.5),
                        height: 25,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: CustomColors.lightback.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Container(
                          width: 100,
                            child: Text("${popularJob.data![index].jobType}",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 1,))),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        padding: EdgeInsets.all(0.5),
                        height: 25,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: CustomColors.lightback.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Container(
                          width: 100,
                            child: Text("${popularJob.data![index].location}",style: TextStyle(fontSize: 12),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,))),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        padding: EdgeInsets.all(0.5),
                        height: 25,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: CustomColors.lightback.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Container(
                          width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Center(child: Text("${popularJob.data![index].experience} year",style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,)),
                            ))),
                      ),

                    ],
                  ), popularJob.data![index].days == "null" || popularJob.data![index].days == null || popularJob.data![index].days == "" ? SizedBox.shrink() : Text("${popularJob.data![index].days} days ago",style: TextStyle(color: CustomColors.secondaryColor,fontSize: 12),),
                ],
              ),
            )


          ],
        ),
      ),
    ),
  );
}
Widget applyJob(BuildContext context , int index,cardUi){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      // height: 150,
      width: MediaQuery
          .of(context)
          .size
          .width / 1.2,
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
                  Padding(
                    padding: const EdgeInsets.all(
                        8.0),
                    child: Image.asset(
                      cardUi[index]['image'],
                      height: 60,
                      width: 60,
                      // fit: BoxFit.fill,
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
                          cardUi[index]['text'],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight
                                  .bold),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        cardUi[index]['address'],
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
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    cardUi[index]['time'],
                    style: TextStyle(color: CustomColors.darkblack,
                        fontSize: 15,
                        fontWeight: FontWeight
                            .normal),
                  ),
                  VerticalDivider(
                    color: Colors.black,  //color of divider
                    width: 10, //width space of divider
                    thickness: 3, //thickness of divier line
                    indent: 10, //Spacing at the top of divider.
                    endIndent: 10, //Spacing at the bottom of divider.
                  ),
                  Text(
                    cardUi[index]['paytext'],
                    style: TextStyle(color: CustomColors.darkblack,
                      fontSize: 15,
                      fontWeight: FontWeight
                          .normal,),
                  ),
                ],
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
                    child: Center(child: Text("Full Time")),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        color: CustomColors.lightback.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(child: Text("Onsite")),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                        color: CustomColors.lightback.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(child: Text("0-2 year")),
                  ),
                  SizedBox(width: 5,),
                  Text("15 days ago",style: TextStyle(color: CustomColors.secondaryColor),)
                ],
              ),
            ),
            SizedBox(height: 10,)


          ],
        ),
      ),
    ),
  );
}
Widget chatUi(BuildContext context ,int index,chatCard){
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      width: MediaQuery
          .of(context)
          .size
          .width ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child:Card(
        elevation: 2,
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
            Padding(
              padding: const EdgeInsets.only(left: 5,right: 10,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .start,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                        8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        chatCard[index]['image'],
                        height: 60,
                        width: 60,
                         fit: BoxFit.fill,
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
                          chatCard[index]['text'],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight
                                  .bold),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        chatCard[index]['address'],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight
                                .normal),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,left: 5),
                    child: Column(
                      children: [
                        Text(
                          "Jan11",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight
                                  .normal),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: CustomColors.lightgray.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(child: Text("3")),
                          ),
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}