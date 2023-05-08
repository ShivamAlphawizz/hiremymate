import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/RecruiterSection/viewApplied.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../Model/AllJobModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import 'EditPost.dart';


class MyJobPost extends StatefulWidget {
  const MyJobPost({Key? key}) : super(key: key);

  @override
  State<MyJobPost> createState() => _MyJobPostState();
}

class _MyJobPostState extends State<MyJobPost> {

  AllJobModel? allJobModel;
  getMyJobs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=056439a05a0899b4ea52dc1ac181a060af22ccd2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}job_lists'));
    request.fields.addAll({
      'user_id': '$userid'
    });
    print("my jobs parameters ${request.fields} and ${ApiPath.baseUrl}job_lists");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AllJobModel.fromJson(json.decode(finalResponse));
      setState(() {
        allJobModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  deleteApp(String? id)async{
    var headers = {
      'Cookie': 'ci_session=d5ff45f8db1109c832e6b7e44b3ad13f93bc1b91'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}delete_job_post'));
    request.fields.addAll({
      'id': '${id}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse =  await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("jsonResponse here ${jsonResponse}");
      var snackBar = SnackBar(
        content: Text('${jsonResponse['message']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
      });
      Navigator.pop(context,true);
      setState(() {
        getMyJobs();
      });
      //  Future.delayed(Duration(milliseconds: 200),(){
      //    return deleteApp();
      //  });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  openDeleteDialog(String id){
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          title: Text("Are you sure want to delete job ?",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  deleteApp(id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child:  Text("Confirm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.red,
                  ),
                  child:  Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getMyJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: "My Jobs",isTrue: true, context: context),
      backgroundColor: CustomColors.TransparentColor,
      body: allJobModel == null ? Center(child: CircularProgressIndicator(),) : allJobModel!.data!.length == 0 ? Center(child: Text("No Job Found"),) : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
          shrinkWrap: true,
          itemCount: allJobModel!.data!.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (c,i){
            return Container(
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 8),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left:0,right: 0,top: 0,bottom: 0),
                      leading:Container(
                        height: 45,
                        width: 45,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset("assets/homeScreen/homeScreenimage1.png",fit: BoxFit.fill,),
                        ),
                      ),
                      title: Text("${allJobModel!.data![i].designation}",style: TextStyle(color: CustomColors.darkblack,fontSize: 16,fontWeight: FontWeight.w600),),
                      subtitle: Text("${allJobModel!.data![i].location}",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w400,fontSize: 11),),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        onSelected: (value){

                          if(value == "1" || value == 1){
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJobPostScreen(id: allJobModel!.data![i].id.toString(),)));
                            });
                          }
                          if(value == "2" || value == 2){
                            setState(() {
                              openDeleteDialog(allJobModel!.data![i].id.toString());
                            });
                          }
                        },
                        itemBuilder: (C) => [
                          PopupMenuItem(
                            onTap: (){

                            },
                            child:Row(
                              children: [
                                Container(
                                  height:25,
                                  width: 25,
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: CustomColors.lightgray),
                                  ),
                                  child: Icon(Icons.edit,color: CustomColors.grade1,size: 15,),
                                ),
                                SizedBox(width: 7,),
                                Text("Edit")
                              ],
                            ),
                            value: 1,
                          ),
                          PopupMenuItem(

                            child:Row(
                              children: [
                                Container(
                                  height:25,
                                  width: 25,
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: CustomColors.lightgray),
                                  ),
                                  child: Icon(Icons.delete_forever_rounded,color: CustomColors.danger,size: 15,),
                                ),
                                SizedBox(width: 7,),
                                Text("Delete")
                              ],
                            ),
                            value: 2,
                          ),
                          PopupMenuItem(
                            child:Row(
                              children: [
                                Container(
                                  height:25,
                                  width: 25,
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: CustomColors.lightgray),
                                  ),
                                  child: Icon(Icons.share,color: CustomColors.secondaryColor,size: 15,),
                                ),
                                SizedBox(width: 7,),
                                Text("Share")
                              ],
                            ),
                            value: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text("\u{20B9}${allJobModel!.data![i].min}- ${allJobModel!.data![i].max} ${allJobModel!.data![i].salaryRange}",style: TextStyle(color:CustomColors.darkblack,fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  Text("${allJobModel!.data![i].noOfVaccancies} Openings",style: TextStyle(color: CustomColors.lightgray,fontWeight: FontWeight.w400,fontSize: 12),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${allJobModel!.data![i].days} days ago",style: TextStyle(color: CustomColors.secondaryColor,fontWeight: FontWeight.w500),),
                      InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAppliedStudent(jobId: allJobModel!.data![i].id.toString(),)));
                        },
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment:Alignment.center,
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CustomColors.darkblack)
                          ),
                          child: Text("View Applies",style: TextStyle(color: CustomColors.darkblack,fontSize: 14,fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
