import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';
import 'package:http/http.dart' as http;

class CompanyDetails extends StatefulWidget {
  const CompanyDetails({Key? key}) : super(key: key);

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String addressList = 'MR-10';
  var items =  [ 'MR-10','Vijay Nagar','Palasiya','Gori Nagar'];
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();


  updateCompanyDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=5f3902fb6f3bf35eee79bf1f4acdebb05e626cd7'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}update_recruiter/${userid}'));
    request.fields.addAll({
      'type': 'company_details',
      'company_name':  nameController.text,
      'website': websiteController.text,
      'company_email': emailController.text,
      'company_phone': mobileController.text,
      'office_address': addressController.text,
      'about_company': aboutCompanyController.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
       // setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
       // });
        Navigator.pop(context,true);
      }
      else{
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
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
      return getRecruiterDetail();
    });
  }

  var recruiterData;
  getRecruiterDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=f1ec907c5cc3c27da75b5336623f196926b2a903'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}recruiter_profile'));
    request.fields.addAll({
      'id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        recruiterData = jsonResponse['data'];
        nameController.text = recruiterData['company'] == "" || recruiterData['company'] == "null" ? null : recruiterData['company'];
        emailController.text = recruiterData['company_email'] == "" || recruiterData['company_email'] == "null" ? null :recruiterData['company_email'];
        mobileController.text = recruiterData['company_phone'] == "" || recruiterData['company_phone'] == "null"  ? null : recruiterData['company_phone'];
        websiteController.text = recruiterData['website'] == "" || recruiterData['website'] == "null" ? null : recruiterData['website'];
        aboutCompanyController.text =  recruiterData['about_company'] == "" || recruiterData['about_company'] == "null" ? null : recruiterData['about_company'] ;
        addressController.text = recruiterData['office_address'] == "" || recruiterData['office_address'] == "null"  ? null : recruiterData['office_address'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
        appBar: customAppBar(text: "Company Details",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 12,right: 12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8,),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Company name",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: 'Enter Your Company name',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Company name is required";
                              }

                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Company Website",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: websiteController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Enter Company Website',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Company Website is required";
                              }
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Company Email",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            maxLines: 1,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: 'Enter Your Company Email',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Company Email is required";
                              }
                              if (!v.contains("@")) {
                                return "Company Email Valid Mobile";
                              }
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Company Phone",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            maxLength: 10,
                            maxLines: 1,
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: 'Enter Your Company Phone',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Company Phone is required";
                              }
                              if (v.length != 10) {
                                return "Enter valid phone number";
                              }
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Office Address",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: addressController,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: 'Enter address',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Enter company address";
                              }
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("About Company",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height/4.2,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              maxLines: 5,
                              controller: aboutCompanyController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: 'Enter About Company',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return " About Company is required";
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomAppBtn(
                          height: 50,
                          title: 'SAVE',
                          onPress: () {
                            if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                              updateCompanyDetail();
                            } else { const snackBar = SnackBar(
                              content: Text('All Fields are required!'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) =>LoginScreen()));
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            }


                          },
                        ),
                      ),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        )

      ),
    );
  }
}
