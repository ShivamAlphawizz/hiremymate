import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Model/recentJobModel.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomCard.dart';

class ApplyJob extends StatefulWidget {
 bool? isValue;
 ApplyJob({this.isValue});

  @override
  State<ApplyJob> createState() => _ApplyJobState();
}

class _ApplyJobState extends State<ApplyJob> {
  
  RecentJobModel? appliedModel;
  getApplyJob()async{
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    
    var headers = {
      'Cookie': 'ci_session=88797bce07763a45ea686895b69d7cd23c266ea2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}applied_job_list'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    print("get favorite ${ApiPath.baseUrl}applied_job_list  --- ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = RecentJobModel.fromJson(json.decode(finalResult));
      setState(() {
        appliedModel = jsonResponse;
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
      return getApplyJob();
    });
  }

  removeFromSave(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=5a37ed79b483f5766738a21c88679dc79add7041'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}remove_fav_job'));
    request.fields.addAll({'job_id': '${id}', 'user_id': '${userid}'});
    print("request is here ${ApiPath.baseUrl}remove_fav_job  ---- ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if (jsonResponse['status'] == true) {
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          getApplyJob();
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.TransparentColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(text: "Applied Jobs",istrue: widget.isValue! ? true : false,),
            // Padding(
            //   padding: EdgeInsets.all(10.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.only(top: 10),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: CustomColors.AppbarColor1
            //         ),
            //         height: 50,
            //         width: MediaQuery
            //             .of(context)
            //             .size
            //             .width/1.3,
            //         child: TextFormField(
            //           decoration: InputDecoration(
            //             hintText: 'Search your job',
            //               border: InputBorder.none,
            //               prefixIcon: Icon(
            //                   Icons.search
            //               )
            //
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 5),
            //         child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: CustomColors.AppbarColor1
            //             ),
            //             height: 50,
            //             width: 50,
            //             child: Icon(
            //                 Icons.menu
            //             )
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
               appliedModel == null ? Center(child: CircularProgressIndicator(),) :  appliedModel!.data!.length == 0 ? Container(
                 height: MediaQuery.of(context).size.height/2,
                 child: Center(child: Text("Currently You have not applied for any job")),) : Expanded(
                 child: ListView.builder(
                   padding: EdgeInsets.symmetric(vertical: 10),
                 physics:  ScrollPhysics(),
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: appliedModel!.data!.length,
                  itemBuilder: (context, index) {
                    return jobCard(context,index,appliedModel!,true,()async{
                      if(appliedModel!.data![index].isFav == true){
                        removeFromSave(appliedModel!.data![index].id);
                        setState(() {

                        });
                      }
                      else {
                        SharedPreferences prefs =
                        await SharedPreferences
                            .getInstance();
                        String? userid =
                        prefs.getString('USERID');
                        var headers = {
                          'Cookie':
                          'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
                        };
                        var request = http
                            .MultipartRequest(
                            'POST',
                            Uri.parse(
                                '${ApiPath
                                    .baseUrl}save_job'));
                        request.fields.addAll({
                          'job_id':
                          '${appliedModel!.data![index]
                              .id}',
                          'user_id': '${userid}'
                        });
                        print(
                            "working paramers here ${request
                                .fields}");
                        request.headers.addAll(headers);
                        http.StreamedResponse response =
                        await request.send();
                        if (response.statusCode == 200) {
                          var finalResult = await response
                              .stream
                              .bytesToString();
                          final jsonResponse =
                          json.decode(finalResult);
                          if (jsonResponse['status'] ==
                              true) {
                            setState(() {
                              var snackBar = SnackBar(
                                content: Text(
                                    '${jsonResponse['message']}'),
                              );
                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(snackBar);
                              getApplyJob();
                            });
                          }
                        } else {
                          print(response.reasonPhrase);
                        }
                      }
                    });
                  }),
               )
          ],
        )
      ),
    );
  }
}
