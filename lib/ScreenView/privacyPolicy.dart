import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Helper/ColorClass.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  var aboutData;

  getAboutUS()async{
    var headers = {
      'Cookie': 'ci_session=da891502fb188ffa1aa926b180e8599558058785'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}page_info'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print("checking result here  and ============ ${jsonResponse['data']['about_us'] }");
      setState(() {
        aboutData = jsonResponse['data']['privacy_policy'].toString();
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
    Future.delayed(Duration(milliseconds: 300),(){
      return getAboutUS();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "Privacy Policy",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child:aboutData == null ? Center(child: CircularProgressIndicator(),) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                //  Html(data: aboutData)
                  Text("${aboutData}")
                ],
              ),
            ),
          )

      ),
    );
  }
}
