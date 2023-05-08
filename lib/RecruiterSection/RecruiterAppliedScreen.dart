import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/Model/AllRecruiterAppliedModel.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:hiremymate/buttons/CustomButton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import 'candidateDetail.dart';

class RecruiterAppliedScreen extends StatefulWidget {
  const RecruiterAppliedScreen({Key? key}) : super(key: key);

  @override
  State<RecruiterAppliedScreen> createState() => _RecruiterAppliedScreenState();
}

class _RecruiterAppliedScreenState extends State<RecruiterAppliedScreen> {


  AllRecruiterAppliedModel? allRecruiterAppliedModel;
  getAllApplied()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=d1d4639e0a610bae2ef9588874a246d1c33129be'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}applied_by_user_job'));
    request.fields.addAll({
      'recruiter_id': '${userid}'
    });
    print("sfsfsfsfsfsfsfsfsf ${request.fields} and ${ApiPath.baseUrl}applied_by_user_job");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = AllRecruiterAppliedModel.fromJson(json.decode(finalResult));
      setState(() {
       allRecruiterAppliedModel = jsonResponse;
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
          getAllApplied();
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
      return getAllApplied();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: "Applied",isTrue: true, context: context),
      backgroundColor: CustomColors.TransparentColor,
      body:allRecruiterAppliedModel == null ? Center(child: CircularProgressIndicator(),) : allRecruiterAppliedModel!.data!.length == 0 ? Center(child:Text("No Applied job to show"),) : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
        shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: allRecruiterAppliedModel!.data!.length,
          itemBuilder: (c,i){
        return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CandidateDetail(seekerData: allRecruiterAppliedModel!.data![i],)));
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

                        child: Image.network("${ApiPath.imageUrl}${allRecruiterAppliedModel!.data![i].img}",fit: BoxFit.fill,),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${allRecruiterAppliedModel!.data![i].name}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.w600,fontSize: 15),),
                        SizedBox(height: 5,),
                        Text("${allRecruiterAppliedModel!.data![i].designation} | Job id : ${allRecruiterAppliedModel!.data![i].jobId}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),),
                        SizedBox(height: 5,),
                        allRecruiterAppliedModel!.data![i].exp == null || allRecruiterAppliedModel!.data![i].exp == "" ?    Text("Exp :",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),) :   Text("Exp :  ${allRecruiterAppliedModel!.data![i].exp} years",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),)
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
                            child: Image.asset("assets/images/locartion.png")
                          ),
                          SizedBox(width: 10,),
                          allRecruiterAppliedModel!.data![i].location == null || allRecruiterAppliedModel!.data![i].location == "" ? SizedBox() : Text("${allRecruiterAppliedModel!.data![i].location}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
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
                            child:Image.asset("assets/images/mail.png")
                          ),
                          SizedBox(width: 10,),
                          Text("${allRecruiterAppliedModel!.data![i].email}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),)
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
                                child: Image.asset("assets/images/call.png")
                              ),
                              SizedBox(width: 10,),
                              Text("${allRecruiterAppliedModel!.data![i].mno}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
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
               allRecruiterAppliedModel!.data![i].status == "1" ?  CustomAppBtn(title: "SHORTLISTED",height: 45,width: MediaQuery.of(context).size.width,onPress: (){},) :
               allRecruiterAppliedModel!.data![i].status == "2" ? Container(
                 alignment: Alignment.center,
                 height: 45,
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: CustomColors.danger
                 ),
                 child: Text("REJECTED",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
               )
                   :  Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children:

                  [MaterialButton(
                      height:45,
                      minWidth:MediaQuery.of(context).size.width/2.5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color:CustomColors.danger,
                      onPressed: (){
                        updateShortListStatus(allRecruiterAppliedModel!.data![i].jobId.toString(), allRecruiterAppliedModel!.data![i].userId.toString(), "2");
                      },child: Text("REJECT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                    MaterialButton(
                      height:45,
                      minWidth:MediaQuery.of(context).size.width/2.5,
                      color:CustomColors.grade1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onPressed: (){
                        updateShortListStatus(allRecruiterAppliedModel!.data![i].jobId.toString(), allRecruiterAppliedModel!.data![i].userId.toString(), "1");
                      },child: Text("SHORTLIST",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
                  ],
                ),
              ],
            ),
          ),
        );
      })
    );
  }
}
