import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:hiremymate/RecruiterSection/hiringProcess.dart';
import 'package:hiremymate/ScreenView/chatDetail.dart';
import 'package:hiremymate/buttons/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../Helper/ColorClass.dart';
import '../Model/appliedStudentLIstModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';

class CandidateDetail extends StatefulWidget {
  var seekerData;
  CandidateDetail({this.seekerData});

  @override
  State<CandidateDetail> createState() => _CandidateDetailState();
}

class _CandidateDetailState extends State<CandidateDetail> {
  AppliedStudentLIstModel? appliedStudentModel;
  getViewApplied() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=04915204f0e20adcfc0899544e74d576ca926e0e'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}recruiter_job_detail'));
    request.fields.addAll({
      //'id': '${widget.jobId}'
    });
    print(
        "checking params now ${request.fields} and ${ApiPath.baseUrl}recruiter_job_detail");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonRespone =
          AppliedStudentLIstModel.fromJson(json.decode(finalResult));
      setState(() {
        appliedStudentModel = jsonRespone;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  var updateResult;
  updateShortListStatus(String jobid, seekerId, status) async {
    var headers = {
      'Cookie': 'ci_session=3132ed336c1ebb9e89bf11d1a7a38bf20db00de0'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}accept_reject'));
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
      if (jsonResponse['status'] == true) {
        setState(() {
          updateResult = jsonResponse;
        });

        var snackBar = const SnackBar(
          content: Text(''
              'Updated successfully'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          Navigator.pop(context, true);
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  downloadFile(String url, String filename) async {
    print("Path herrrrr ${url}");
    print("Apiiii Pathhhh ${ApiPath.resumeUrl} ${url}");
    FileDownloader.downloadFile(
        url: "${ApiPath.resumeUrl}${url}",
        name: "Report",
        onDownloadCompleted: (path) {
          final File file = File(path);
          print("path here ${file}");
          var snackBar = SnackBar(
            backgroundColor: CustomColors.primaryColor,
            content: Text('Resume saved in your downloads'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
        });
  }


  @override
  Widget build(BuildContext context) {
    print(
        "checking final here ${widget.seekerData} and  ${ApiPath.imageUrl}${widget.seekerData.img}");
    return Scaffold(
      appBar: customAppBar(
          text: "Candidate Detail", isTrue: true, context: context),
      backgroundColor: CustomColors.TransparentColor,
      body: widget.seekerData == null || widget.seekerData == ""
          ? const Center(
              child: Text("No data to show"),
            )
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.6,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 50,
                          right: 0,
                          left: 0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 5,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4.5,
                              decoration: BoxDecoration(
                                  color: CustomColors.AppbarColor1,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          )),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: CustomColors.lightgray)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "${ApiPath.imageUrl}${widget.seekerData.img}",
                                      fit: BoxFit.fill,
                                    )))
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 5.5,
                        right: 0,
                        left: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${widget.seekerData.name}",
                              style: const TextStyle(
                                  color: CustomColors.darkblack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            // Text("Aglowid IT Solutions PVT. LTD.",style: TextStyle(color: CustomColors.lightblackAllText,fontWeight: FontWeight.normal,fontSize: 18)),
                            // SizedBox(height: 5,),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 20,right: 20),
                            //   child: Divider(color: CustomColors.lightblackAllText.withOpacity(0.5),thickness: 1,),
                            // ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${widget.seekerData.designation}"),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  widget.seekerData.designation == "" ? SizedBox() :  Text("|"),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  widget.seekerData.exp == null || widget.seekerData.exp == "" ? Text("Exp:") :  Text(
                                    "Exp: ${widget.seekerData.exp} years",
                                    style: const TextStyle(
                                        color: CustomColors.darkblack,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    downloadFile(widget.seekerData.resume.toString(),"resume");
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(otherid: widget.seekerData.userId,otherName: widget.seekerData.name,)));
                  },
                  child: Container(
                    height: 55,
                    // margin: EdgeInsets.only(top: 10,bottom: 10),
                    width: MediaQuery.of(context).size.width/1.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: CustomColors.grade1,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text("Download Resume",style:TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                  ),
                ),
                Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "General  Info",
                          style: TextStyle(
                              color: CustomColors.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Job Id:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              "${widget.seekerData.jobId}",
                              style: TextStyle(
                                  color: CustomColors.lightgray, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Qualification:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              "${widget.seekerData.qua}",
                              style: TextStyle(
                                  color: CustomColors.lightgray, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Specialization:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              "${widget.seekerData.specialization}",
                              style: TextStyle(
                                  color: CustomColors.lightgray, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Language:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                         widget.seekerData.language == "null" || widget.seekerData.language == null ? Text("")  :   Text(
                              "${widget.seekerData.language}",
                              style: TextStyle(
                                  color: CustomColors.lightgray, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Location:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            widget.seekerData.location == null || widget.seekerData.location == "" ? SizedBox() :  Text(
                              "${widget.seekerData.location}",
                              style: TextStyle(
                                  color: CustomColors.lightgray, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Min Salary:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              "${widget.seekerData.current}",
                              style: TextStyle(
                                  color: CustomColors.lightgray, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Preffered job:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              "${widget.seekerData.designation}",
                              style: TextStyle(
                                  color: CustomColors.lightgray, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: widget.seekerData.status == "1"
                          ? CustomAppBtn(
                              title: "SHORTLISTED",
                              height: 45,
                              width: MediaQuery.of(context).size.width / 2,
                            )
                          :  widget.seekerData.status == "2" ? Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.danger,
                        ),
                        child: Text("REJECTED",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),),
                      ) : CustomAppBtn(
                              title: "SHORTLIST",
                              height: 45,
                              width: MediaQuery.of(context).size.width / 2,
                              onPress: () {
                                updateShortListStatus(
                                    widget.seekerData.jobId.toString(),
                                    widget.seekerData.userId.toString(),
                                    "1");
                              },
                            ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              print("mno is here now ${widget.seekerData.mno}");
                              var url = "tel:${widget.seekerData.mno}";
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: Color(0xffE5563B),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              const sms = 'sms:';
                              if (await canLaunch(sms)) {
                                await launch(sms);
                              } else {
                                throw 'Could not launch $sms';
                              }
                            },
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: CustomColors.secondaryColor,
                              child: Center(
                                child: Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(otherid: widget.seekerData.userId,otherName: widget.seekerData.name,)));
                      },
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        width: MediaQuery.of(context).size.width/2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CustomColors.grade1,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Text("Chat with Seeker",style:TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
               widget.seekerData.status == "1" ?  CustomAppBtn(
                  title: "Next",
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HiringProcess(
                                  canDetail: widget.seekerData,
                                )));
                  },
                ) : SizedBox.shrink()
              ],
            ),
    );
  }
}
