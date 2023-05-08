import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/Model/recentJobModel.dart';
import 'package:hiremymate/ScreenView/chatDetail.dart';
import 'package:hiremymate/ScreenView/referJob.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:hiremymate/buttons/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';

class JobDetailScreen extends StatefulWidget {
    RecentJobModel? jobData;
    bool? isApplied;
    int? index;
    JobDetailScreen({this.jobData,this.index,this.isApplied});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  applyJob(id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString("USERID");
    var headers = {
      'Cookie': 'ci_session=d94df475d407fbbdbf0991effdc7a97eb3c53099'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}apply_job_post'));
    request.fields.addAll({
      'post_id': '${id}',
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult =  await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print("final json Response ${jsonResponse}");
      if(jsonResponse['status'] == 'true'){
        // var snackBar = SnackBar(
        //   backgroundColor: CustomColors.primaryColor,
        //   content: Text('${jsonResponse['message']}'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      Navigator.pop(context);
      // setState(() {
      // });
    }
    else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }
  }

  int _currentStep = 1;
  StepperType stepperType = StepperType.vertical;

  List<Step>stepList = [

     Step(title: Text('Applied Successfully'), content: SizedBox.shrink(),

    ),
    const Step(title: Text('Application sent'), content: SizedBox.shrink()),
    const Step(title: Text('Application Viewed'), content: SizedBox.shrink()),
    const Step(title: Text('Application Approved'), content: SizedBox.shrink()),
    const Step(title: Text('Face to face interview'), content: SizedBox.shrink()),
    const Step(title: Text('Cleared all the interview round'), content: SizedBox.shrink()),

  ];

  tapped(int step){
    print("printing step ${step}");
    setState(() => _currentStep = step);
  }

  var applicationStatus;


  getApplicationStatus()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=debb67ccf32ad90290bee7b1bf16fa0567f24e51'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}apply_status'));
    request.fields.addAll({
      'user_id': '${userid}',
      'job_id':"${widget.jobData!.data![widget.index!].id}"
    });
    print("here is result ${request.fields} and");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResult = json.decode(finalResult);
      if(jsonResult['status'] == true){
        print("checking nnnnnnnnn ${jsonResult}");
          setState(() {
            applicationStatus = jsonResult['data'][0];
          });
          print("checking here ${applicationStatus}");
          if(applicationStatus['application_view'] == "1"){
            setState(() {
              _currentStep = 2;
            });
          }
           if(applicationStatus['application_approved'] == "1"){
            setState(() {
              _currentStep = 3;
            });
          }
           if(applicationStatus['face_to_face'] == "1"){
            setState(() {
              _currentStep = 4;
            });
          }
           if(applicationStatus['cleared'] == "1"){
            setState(() {
              _currentStep = 5;
            });
          }
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
      return getApplicationStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("current step ${_currentStep}");
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(text: "Job Detail",isTrue: true, context: context),
      backgroundColor: CustomColors.TransparentColor,
      body: ListView(
        padding: EdgeInsets.only(top: 10,bottom: 20),
        children: [

          /// comapany detail and job about section
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
              elevation: 4,
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                  // height: 220,

                  padding: EdgeInsets.only(left: 10,right: 10,top: 45,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${widget.jobData!.data![widget.index!].designation}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.bold,fontSize: 18),),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${widget.jobData!.data![widget.index!].companyName}", style: TextStyle(fontWeight: FontWeight.w500,color: CustomColors.lightgray,fontSize: 14),),
                            SizedBox(width: 10,),
                          widget.jobData!.data![widget.index!].veri != "yes" ? SizedBox.shrink()  : Text("Verified",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 16),),
                        ],
                      ),
                      SizedBox(height: 3,),
                      Divider(),
                      SizedBox(height: 2,),
                      Text("${widget.jobData!.data![widget.index!].location}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: CustomColors.lightgray),),
                      SizedBox(height: 6,),
                      Text("\u{20B9}${widget.jobData!.data![widget.index!].min}-${widget.jobData!.data![widget.index!].max} ${widget.jobData!.data![widget.index!].salaryRange}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.bold,fontSize: 14),),
                      SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              //padding: EdgeInsets.symmetric(horizontal: 12),
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: CustomColors.lightgray.withOpacity(0.3)
                              ),
                              child: Center(child: Text("${widget.jobData!.data![widget.index!].jobType}",style: TextStyle(color: CustomColors.darkblack,fontSize: 12,fontWeight: FontWeight.w500),)),
                            ),
                            Container(
                              height: 35,
                             width: 100,
                             // padding: EdgeInsets.symmetric(horizontal: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: CustomColors.lightgray.withOpacity(0.3)
                              ),
                              child: Text("${widget.jobData!.data![widget.index!].location}",style: TextStyle(color: CustomColors.darkblack,fontSize: 12,fontWeight: FontWeight.w500,),overflow: TextOverflow.ellipsis, maxLines: 2,),
                            ),
                            // Container(
                            //   height: 35,
                            //   width: 80,
                            //   padding: EdgeInsets.symmetric(horizontal: 12),
                            //   alignment: Alignment.center,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(14),
                            //       color: CustomColors.lightgray.withOpacity(0.3)
                            //   ),
                            //   child: Text("${widget.jobData!.data![widget.index!].experience} years",style: TextStyle(color: CustomColors.darkblack,fontSize: 14,fontWeight: FontWeight.w500),),
                            // ),
                          ],
                        ),
                    ],
                  ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
            //  bottom:220,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: )
                  ),
                  child:  ClipRRect(borderRadius: BorderRadius.circular(12),child:  widget.jobData!.data![widget.index!].img!.contains('https:')  ? Image.network("${widget.jobData!.data![widget.index!].img}",fit: BoxFit.fill,) :  Image.network("${ApiPath.imageUrl}${widget.jobData!.data![widget.index!].img}",fit: BoxFit.fill,),) ,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 5,),

          _currentStep > 2  ?  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(otherid: widget.jobData!.data![widget.index!].userId, otherName: widget.jobData!.data![widget.index!].recName,)));
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width/2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColors.grade1
              ),
              child: Text("Chat with Recruiter",style: TextStyle(color:Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
            ),
          ),
        ],
      ): SizedBox.shrink(),
     SizedBox(height: 10,),
     widget.isApplied == true ? Container(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10)
         ),
         child:
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left:20,top: 20,bottom: 10),
                child: Text("Your Application Status",style: TextStyle(color: CustomColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 14),),
              ),
       Stepper(
         type: stepperType,
         physics: ScrollPhysics(),
         currentStep: _currentStep,
         controlsBuilder: (onStepContinue, onStepCancel) {
           return const SizedBox(height: 0,width: 0,);
         },
         onStepTapped: (step) => tapped(step),
          margin: EdgeInsets.all(0),
         steps: <Step>[
           Step(
             title: new Text('Applied Successfully'),
             subtitle: Text("21 March"),
             content:SizedBox.shrink(),
             isActive: _currentStep >= 0,
             state: _currentStep >= 0 ?
             StepState.complete : StepState.disabled,
           ),
           Step(
             title: new Text('Application Sent'),
             content:SizedBox.shrink(),
             isActive: _currentStep >= 0,
             state: _currentStep >= 1 ?
             StepState.complete : StepState.disabled,
           ),
           Step(
             title: new Text('Application Viewed'),
             content:SizedBox.shrink(),
             isActive:_currentStep >= 0,
             state: _currentStep >= 2 ?
             StepState.complete : StepState.disabled,
           ),
           Step(
             title: new Text('Application Approved'),
             content:SizedBox.shrink(),
             isActive:_currentStep >= 0,
             state: _currentStep >= 3 ?
             StepState.complete : StepState.disabled,
           ),
           Step(
             title: new Text('Face to face interview'),
             content:SizedBox.shrink(),
             isActive:_currentStep >= 0,
             state: _currentStep >= 4 ?
             StepState.complete : StepState.disabled,
           ),
           Step(
             title: new Text('Cleared all the interview round'),
             content:SizedBox.shrink(),
             isActive:_currentStep >= 0,
             state: _currentStep >= 2 ?
             StepState.complete : StepState.disabled,
           ),
         ],
       ),

            ],
          ),
        )
     ) :
     Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Company description

          widget.jobData!.data![widget.index!].compnyDescription == null ? SizedBox.shrink() :
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Card(
              elevation: 4,
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                  width:MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("About Company", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: CustomColors.primaryColor),textAlign: TextAlign.start,)),
                        SizedBox(height: 10,),

                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("${widget.jobData!.data![widget.index!].compnyDescription}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.start,))

                      ]
                  )
              ),

            ),
          ),
            SizedBox(height: 10,),
          /// job post section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Card(
              elevation: 4,
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                  width:MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Job Post", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: CustomColors.primaryColor),textAlign: TextAlign.start,)),
                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Job Id :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                            Text("${widget.jobData!.data![widget.index!].id}",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w500,fontSize: 14),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Qualification :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                            Text("${widget.jobData!.data![widget.index!].qualification}",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w500,fontSize: 14),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Language:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                            widget.jobData!.data![widget.index!].language == "" || widget.jobData!.data![widget.index!].language == null ? Text("") :  Text("${widget.jobData!.data![widget.index!].language}",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w500,fontSize: 14),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text("Specialization :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
                            Expanded(child: Text("${widget.jobData!.data![widget.index!].specialization}",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w500,fontSize: 14),textAlign: TextAlign.end,)),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text("Experience : ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
                            Text("${widget.jobData!.data![widget.index!].experience} years",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w500,fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Last Date of Application :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                            Text("${widget.jobData!.data![widget.index!].endDate}",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w500,fontSize: 14),),
                          ],
                        ),

                      ]
                  )
              ),

            ),
          ),
          SizedBox(height: 15,),

          /// job description section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Card(
              elevation: 4,
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                  width:MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Job Description", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: CustomColors.primaryColor),textAlign: TextAlign.start,)),
                        SizedBox(height: 10,),

                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("${widget.jobData!.data![widget.index!].description}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),))

                      ]
                  )
              ),

            ),
          ),
          SizedBox(
            height: 15,
          ),

          /// apply and refer section

          InkWell(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReferJob()));
            },
            child: Container(
              height: 45,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("REFER THIS JOB",style: TextStyle(color: CustomColors.darkblack,fontSize: 14,fontWeight: FontWeight.w600),),
            ),
          ),
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: widget.jobData!.data![widget.index!].isApplied == true ?  CustomAppBtn(title: "APPLIED",onPress: (){
              // applyJob(widget.jobData!.data![widget.index!].id.toString());
            },height: 45,)  : isLoading == true ? Center(child: CircularProgressIndicator()) : CustomAppBtn(title: "APPLY",onPress: (){
              setState(() {
                isLoading = true;
              });
              applyJob(widget.jobData!.data![widget.index!].id.toString());
            },height: 45,),
          ),
          SizedBox(height: 15,),
        ],
      ),
        ],
      ),
    );
  }
}
