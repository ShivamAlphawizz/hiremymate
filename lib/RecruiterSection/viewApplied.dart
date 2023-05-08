import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/Model/appliedStudentLIstModel.dart';
import 'package:hiremymate/RecruiterSection/candidateDetail.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:hiremymate/buttons/CustomButton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';

class ViewAppliedStudent extends StatefulWidget {
  String? jobId;
  ViewAppliedStudent({this.jobId});
  @override
  State<ViewAppliedStudent> createState() => _ViewAppliedStudentState();
}

class _ViewAppliedStudentState extends State<ViewAppliedStudent> {

  AppliedStudentLIstModel? appliedStudentModel;
  getViewApplied()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=04915204f0e20adcfc0899544e74d576ca926e0e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}recruiter_job_detail'));
    request.fields.addAll({
      'id': '${widget.jobId}'
    });
    print("checking params now ${request.fields} and ${ApiPath.baseUrl}recruiter_job_detail");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonRespone = AppliedStudentLIstModel.fromJson(json.decode(finalResult));
      setState(() {
        appliedStudentModel =  jsonRespone;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  var updateResult;
  updateShortListStatus(String jobid,seekerId,status)async{
    var headers = {
      'Cookie': 'ci_session=3132ed336c1ebb9e89bf11d1a7a38bf20db00de0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}accept_reject'));
    request.fields.addAll({
      'job_id': jobid.toString(),
      'user_id': seekerId.toString(),
      'status': status.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
     if(jsonResponse['status'] == true){
       setState(() {
         updateResult = jsonResponse;
         getViewApplied();
       });

       var snackBar = SnackBar(
         content: Text(''
             'Updated successfully'),
       );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
     }
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
      return getViewApplied();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: "Applies",isTrue: true, context: context),
      backgroundColor: CustomColors.TransparentColor,
      body: appliedStudentModel == null ? Center(child: CircularProgressIndicator(),) : appliedStudentModel!.data!.applied!.length == 0 ? Center(
        child: Text("No data to show"),
      ) :  ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
        itemCount: appliedStudentModel!.data!.applied!.length,
        itemBuilder: (c,i){
          return InkWell(
            onTap: ()async{
            var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CandidateDetail(seekerData: appliedStudentModel!.data!.applied![i],)));
            if(result == true){
              setState(() {
                 getViewApplied();
              });
            }
            },
            child: Container(
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
                          child: Image.network("${ApiPath.imageUrl}${appliedStudentModel!.data!.applied![i].img}",fit: BoxFit.fill,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${appliedStudentModel!.data!.applied![i].name}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.w600,fontSize: 15),),
                          SizedBox(height: 5,),
                          Text("${appliedStudentModel!.data!.applied![i].designation} | Job id : ${appliedStudentModel!.data!.applied![i].jobId} |",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),),
                          SizedBox(height: 5,),
                          appliedStudentModel!.data!.applied![i].exp == null || appliedStudentModel!.data!.applied![i].exp == "" ? SizedBox.shrink() :
                          Text("Exp : ${appliedStudentModel!.data!.applied![i].exp} years",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),)
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
                              padding: EdgeInsets.all(2),
                              height:25,
                              width: 25,
                              alignment:Alignment.center,
                              decoration: BoxDecoration(
                                  boxShadow: const [
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
                              child: Image.asset("assets/images/locartion.png")
                            ),
                            SizedBox(width: 10,),
                            appliedStudentModel!.data!.applied![i].location == null ? SizedBox() :  Text("${appliedStudentModel!.data!.applied![i].location}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Container(
                              height:25,
                              width: 25,
                                padding: EdgeInsets.all(2),
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
                              child: Image.asset("assets/images/mail.png")
                            ),
                            SizedBox(width: 10,),
                            Text("${appliedStudentModel!.data!.applied![i].email}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
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
                                    padding: EdgeInsets.all(3),
                                  alignment:Alignment.center,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
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
                                  child: Image.asset("assets/images/call.png")
                                ),
                                SizedBox(width: 10,),
                                Text("${appliedStudentModel!.data!.applied![i].mno}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
                              ],
                            ),
                           // Text("Referred on 20 Feb",style: TextStyle(color: CustomColors.secondaryColor,fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Divider(),
                  SizedBox(height: 5,),
                 appliedStudentModel!.data!.applied![i].status == "1" ? CustomAppBtn(title: "SHORTLISTED",height: 45,width: MediaQuery.of(context).size.width,) :  appliedStudentModel!.data!.applied![i].status == "2" ?  Container(
                   alignment: Alignment.center,
                   height: 45,
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: CustomColors.danger
                   ),
                   child: Text("REJECTED",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                 ): Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        height:45,
                        minWidth: MediaQuery.of(context).size.width/2.5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color:CustomColors.danger,
                        onPressed: (){
                          updateShortListStatus(appliedStudentModel!.data!.applied![i].jobId.toString(),appliedStudentModel!.data!.applied![i].userId.toString(),'2');
                        },child: Text("REJECT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                      MaterialButton(
                        height:45,
                        minWidth: MediaQuery.of(context).size.width/2.5,
                        color:CustomColors.grade1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onPressed: (){
                          updateShortListStatus(appliedStudentModel!.data!.applied![i].jobId.toString(),appliedStudentModel!.data!.applied![i].userId.toString(),'1');
                         // Navigator.push(context, MaterialPageRoute(builder: (context) => CandidateDetail()));
                        },child: Text("SHORTLIST",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
