import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:http/http.dart' as http;
import '../Helper/ColorClass.dart';
//import '../ScreenView/searchCandidate.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';

class CantactUs extends StatefulWidget {
  const CantactUs({Key? key}) : super(key: key);

  @override
  State<CantactUs> createState() => _CantactUsState();
}

class _CantactUsState extends State<CantactUs> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  sendMessgae() async {
    var headers = {
      'Cookie': 'ci_session=d1d4639e0a610bae2ef9588874a246d1c33129be'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}contact_us'));
    request.fields.addAll({
      "name":  nameController.text,
      "email": emailController.text,
      "mno": mobileController.text,
      "msg": msgController.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
      setState(() {
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}')
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            customAppBar(text: "Contact Us", isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Get in Touch",
                        style:
                            TextStyle(color: CustomColors.grade, fontSize: 18),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Leave us a Message We will Get in Touch With You ",
                        style: TextStyle(color: CustomColors.darkblack),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "as Soon as Possible",
                        style: TextStyle(color: CustomColors.darkblack),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchCandidate()));
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/facebook.png",
                                            height: 70,
                                            width: 70,
                                          ),
                                          Text("Facebook"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/line.png",
                                          height: 60,
                                          width: 70,
                                        ),
                                        Text("Line"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/google-plus.png",
                                          height: 70,
                                          width: 70,
                                        ),
                                        Text("Google+"),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/twitter.png",
                                          height: 70,
                                          width: 70,
                                        ),
                                        Text("Twitter"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 45,
                              ),
                              SizedBox(
                                width: 120,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/whatsapp.png",
                                          height: 70,
                                          width: 70,
                                        ),
                                        Text("whatsapp"),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Get in Touch",
                                style: TextStyle(
                                    color: CustomColors.grade, fontSize: 18),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 5,
                            child: Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 1.6,
                              decoration: BoxDecoration(
                                  color: CustomColors.AppbarColor1,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Full Name",
                                          style: TextStyle(
                                              color: CustomColors.grayColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 5,
                                          child: TextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: nameController,
                                            decoration: InputDecoration(
                                                hintText: 'Enter Your Name',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.only(left: 10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Email",
                                          style: TextStyle(
                                              color: CustomColors.grayColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 5,
                                          child: TextFormField(
                                            controller: emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                hintText: ' Enter Your Email',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.only(left: 10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Mobile Number",
                                          style: TextStyle(
                                              color: CustomColors.grayColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 5,
                                          child: TextFormField(
                                            maxLength: 10,
                                            maxLines: 1,
                                            controller: mobileController,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                                counterText: "",
                                                hintText:
                                                    'Enter Your Mobile Number',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.only(left: 10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Write Your Message"),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: CustomColors.lightback
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            child: TextFormField(
                                              controller: msgController,
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                  counterText: "",
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 10)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CustomAppBtn(
                    height: 50,
                    width: MediaQuery.of(context).size.height / 3.2,
                    title: 'SEND',
                    onPress: () {
                      sendMessgae();
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              )),
        ));
  }
}
