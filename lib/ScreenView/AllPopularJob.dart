import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/ColorClass.dart';
import '../Model/recentJobModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomCard.dart';

class AllPopularJobs extends StatefulWidget {
  const AllPopularJobs({Key? key}) : super(key: key);

  @override
  State<AllPopularJobs> createState() => _AllPopularJobsState();
}

class _AllPopularJobsState extends State<AllPopularJobs> {

  RecentJobModel? popularModel;
  getPopularJobs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=e50d052344b0c13605f8ef8be2d6c3a834438e7e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}populer_jobs'));
    request.fields.addAll({
      'user_id': '$userid'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = RecentJobModel.fromJson(json.decode(finalResult));
      setState(() {
        popularModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  saveToJob(id)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}save_job'));
    request.fields.addAll({
      'job_id': '${id}',
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

    Future.delayed(Duration(milliseconds: 300),(){
      return getPopularJobs();
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

          getPopularJobs();
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
            CustomAppBar(text: "Popular Jobs",istrue: true ,),
            Expanded(
              child: popularModel == null  ? Center(child: CircularProgressIndicator(),) :  ListView.builder(
                // physics:  NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: popularModel!.data!.length,
                  itemBuilder: (context, index) {
                    return jobCard(context,index,popularModel!,false,()async{
                      if(popularModel!.data![index].isFav == true){
                        removeFromSave(popularModel!.data![index].id);
                        setState(() {

                        });
                      }else {
                        SharedPreferences prefs = await SharedPreferences
                            .getInstance();
                        String? userid = prefs.getString('USERID');
                        var headers = {
                          'Cookie': 'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
                        };
                        var request = http.MultipartRequest('POST',
                            Uri.parse('${ApiPath.baseUrl}save_job'));
                        request.fields.addAll({
                          'job_id': '${popularModel!.data![index].id}',
                          'user_id': '${userid}'
                        });
                        request.headers.addAll(headers);
                        http.StreamedResponse response = await request.send();
                        if (response.statusCode == 200) {
                          var finalResult = await response.stream
                              .bytesToString();
                          final jsonResponse = json.decode(finalResult);
                          if (jsonResponse['status'] == true) {
                            setState(() {
                              var snackBar = SnackBar(
                                content: Text('${jsonResponse['message']}'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar);
                            });
                          }
                        }
                        else {
                          print(response.reasonPhrase);
                        }
                      }
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
