import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/Helper/ColorClass.dart';
import 'package:hiremymate/RecruiterSection/recruiterDashboard.dart';
import 'package:hiremymate/buttons/CustomButton.dart';
import 'package:http/http.dart' as http;
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';

class HiringProcess extends StatefulWidget {
  var canDetail;
  HiringProcess({this.canDetail});

  @override
  State<HiringProcess> createState() => _HiringProcessState();
}

class _HiringProcessState extends State<HiringProcess> {
  int applicationReceived = 1;
  int shortlisted = 1;
  int viewed = 0;
  int approved = 0;
  int interview = 0;
  int clearedAll = 0;

    updateStatus()async{
      var headers = {
        'Cookie': 'ci_session=964b6de3e2b1d76a74acd9a7d39cc9a9f7908391'
      };
      var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}update_apply_status'));
      request.fields.addAll({
        'job_id': "${widget.canDetail.jobId}",
        'user_id': "${widget.canDetail.userId}",
        'applied': applicationReceived.toString(),
        'application_sent': shortlisted.toString(),
        'application_view':  viewed.toString(),
        'application_approved': approved.toString(),
        'face_to_face': interview.toString(),
        'cleared"': clearedAll.toString()
      });
      print("update param ${request.fields} and ${ApiPath.baseUrl}update_apply_status");
       request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print("status code ${response.statusCode} and ${response}");
      if (response.statusCode == 200) {
        var finalResponse = await response.stream.bytesToString();
        final jsonResponse = json.decode(finalResponse);
        if(jsonResponse['status'] == true){
          setState(() {
            var snackBar = SnackBar(
              content: Text('Updated Successfully'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (Context) => RecruiterDashboard()), (route) => false);
          });
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
    applicationReceived = int.parse(widget.canDetail.applied.toString());
    shortlisted =  int.parse(widget.canDetail.applicationSent.toString());
    viewed = int.parse(widget.canDetail.applicationView.toString());
    approved =  int.parse(widget.canDetail.applicationApproved.toString());
    interview =  int.parse(widget.canDetail.faceToFace.toString());
    clearedAll =  int.parse(widget.canDetail.cleared.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: "Candidate Detail",isTrue: true, context: context),
      backgroundColor: CustomColors.TransparentColor,
      body: widget.canDetail ==  null || widget.canDetail == "" ? Center(child: Text("No data to show"),) : ListView(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
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
                        height: MediaQuery.of(context).size.height/4.5,
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
                              child: Image.network("${ApiPath.imageUrl}${widget.canDetail.img}",fit: BoxFit.fill,))
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
                      Text("${widget.canDetail.name}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.bold,fontSize: 20),),
                      // Text("Aglowid IT Solutions PVT. LTD.",style: TextStyle(color: CustomColors.lightblackAllText,fontWeight: FontWeight.normal,fontSize: 18)),
                      // SizedBox(height: 5,),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 20,right: 20),
                      //   child: Divider(color: CustomColors.lightblackAllText.withOpacity(0.5),thickness: 1,),
                      // ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${widget.canDetail.designation}"),
                            SizedBox(width: 2,),
                            widget.canDetail.designation == null || widget.canDetail.designation == "" ? SizedBox() : Text("|"),
                            SizedBox(width: 2,),
                            widget.canDetail.exp == null || widget.canDetail.exp == "" ?  Text("Exp:")  :  Text("Exp: ${widget.canDetail.exp} years",style: TextStyle(color: CustomColors.darkblack,fontSize: 14),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
            SizedBox(height: 10,),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Update Hiring Process",style: TextStyle(color: CustomColors.darkblack,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        applicationReceived = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: CustomColors.primaryColor),
                          ),
                          child:applicationReceived == 0 ? SizedBox.shrink() : Icon(Icons.check,color: CustomColors.primaryColor,),
                        ),
                        SizedBox(width: 20,),
                        Text("Application Received",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        shortlisted = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: CustomColors.primaryColor),
                          ),
                          child:shortlisted == 0 ?Icon(Icons.check,color: Colors.transparent,) : Icon(Icons.check,color: CustomColors.primaryColor,),
                        ),
                        SizedBox(width: 20,),
                        Text("Application Shortlisted",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                     if(viewed == 0){
                       setState(() {
                         viewed = 1;
                       });
                     }
                     else{
                       setState(() {
                         viewed = 0;
                       });
                     }
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: CustomColors.primaryColor),
                          ),
                          child:viewed == 0 ?Icon(Icons.check,color: Colors.transparent,) : Icon(Icons.check,color: CustomColors.primaryColor,),
                        ),
                        SizedBox(width: 20,),
                        Text("Application Viewed",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      if(approved == 0){
                        setState(() {
                          approved = 1;
                        });
                      }
                      else{
                        setState(() {
                          approved = 0;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: CustomColors.primaryColor),
                          ),
                          child:approved == 0 ? Icon(Icons.check,color: Colors.transparent,) : Icon(Icons.check,color: CustomColors.primaryColor,),
                        ),
                        SizedBox(width: 20,),
                        Text("Application Approved",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      if(interview == 0){
                        setState(() {
                          interview = 1;
                        });
                      }
                      else{
                        setState(() {
                          setState(() {
                            interview = 0;
                          });
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: CustomColors.primaryColor),
                          ),
                          child:interview == 0 ? Icon(Icons.check,color: Colors.transparent,) :  Icon(Icons.check,color: CustomColors.primaryColor,),
                        ),
                        SizedBox(width: 20,),
                        Text("Face to face interview",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      if(clearedAll == 0){
                        setState(() {
                          clearedAll = 1;
                        });
                      }
                      else{
                        setState(() {
                          clearedAll = 0;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: CustomColors.primaryColor),
                          ),
                          child:clearedAll == 0 ? Icon(Icons.check,color: Colors.transparent,) :  Icon(Icons.check,color: CustomColors.primaryColor,),
                        ),
                        SizedBox(width: 20,),
                        Text("Cleared all interview round",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 15,),

          CustomAppBtn(title: "UPDATE",height: 45,width: MediaQuery.of(context).size.width,onPress: (){
            updateStatus();
          },)
        ],
      ),
    );
  }
}
