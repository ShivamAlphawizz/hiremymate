import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/AuthenticationView/loginScreen.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomButton.dart';
import 'OtpScreen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  String? userType;
  SignUpScreen({this.userType});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController SemailController = TextEditingController();
  TextEditingController SmobileController = TextEditingController();
  TextEditingController SpasswordController = TextEditingController();
  TextEditingController ScpasswordController = TextEditingController();
  TextEditingController SfirstNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();




  bool isVisible = true;
  bool allSelected = false;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

    seekerSignup()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userType = prefs.getString('Role');
      print("Checking role here ${userType}");
      var headers = {
        'Cookie': 'ci_session=735bd58831bcf864e958114f05129e913dff713d'
      };
      var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}signUp'));
      request.fields.addAll({
        'type': '${userType}',
        'email': SemailController.text,
        'name': SfirstNameController.text,
        'surname': '',
        'ps': SpasswordController.text,
        'mno': SmobileController.text
      });
      print("checking seeker signup request ${request.fields}");
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var finalResult = await response.stream.bytesToString();
        final jsonResponse = json.decode(finalResult);
        if(jsonResponse['staus'] == "false"){
          setState(() {
          });
          Navigator.pop(context);
        }
        else{
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isLoading = false;
        });
      }
      else {
        print(response.reasonPhrase);
      }
    }
  recruiterSignUp()async{
    var headers = {
      'Cookie': 'ci_session=ec94f0bdb488239dc4b0f8c114420748ca7c936d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}signUp'));
    request.fields.addAll({
      'type': 'recruiter',
      'email': SemailController.text,
      'name': SfirstNameController.text,
      'company': companyController.text,
      'mno': SmobileController.text,
      'ps':  SpasswordController.text
    });
    print("paramters here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("final response here ${jsonResponse}");
      if (jsonResponse['staus'] == "true" || jsonResponse['staus'] ==  true){
        var snackBar = SnackBar(
          content: Text('Registered successfully'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {});
        Navigator.pop(context);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
      else {
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(response.reasonPhrase);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

      var userType;
      getSharedData()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userType = prefs.getString('Role');
      print("user type here ${userType}");
      }

      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100),(){
      return getSharedData();
    });
  }



  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:  SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color:CustomColors.grade,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Icon(Icons.arrow_back,color: CustomColors.AppbarColor1,),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text("Create Account",style: TextStyle(
                      color: CustomColors.TextColors,fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                  SizedBox(height: 10,),
                  Text("Fill up the following details to create your account", style: TextStyle(
                      color: CustomColors.lightblackAllText
                  ),),
                  SizedBox(height: 8,),
                  Text(" and enjoy our services.", style: TextStyle(
                      color: CustomColors.lightblackAllText
                  ),),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Full Name",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: SfirstNameController,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10)
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Name is required";
                        }
                        if (!v.contains("   ")) {
                          return "Enter Valid Name";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Email",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      controller: SemailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: ' Enter Your Email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10)
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Email is required";
                        }
                        if (!v.contains("@")) {
                          return "Enter Valid Email Id";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  widget.userType  == 'recruiter' ?    Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Comapany Name",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ) : SizedBox.shrink(),
                  widget.userType   == 'recruiter' ?   SizedBox(height: 5,) : SizedBox.shrink(),
                  widget.userType   == 'recruiter' ?   Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      controller: companyController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: ' Enter Comapany Name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10)
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Company name is required";
                        }
                      },
                    ),
                  ) : SizedBox.shrink(),
                  widget.userType   == 'recruiter' ?   SizedBox(height: 5,) : SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Mobile Number",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      maxLength: 10,
                      maxLines: 1,
                      controller: SmobileController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                          hintText: 'Enter Your Mobile Number',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10)
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Mobile is required";
                        }
                        if (!v.contains("   ")) {
                          return "Enter Valid Mobile";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding:  EdgeInsets.only(left: 5),
                    child: Text("Password",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      controller: SpasswordController,
                      obscureText: isVisible,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(icon: Icon(
                            isVisible ?
                            Icons.visibility
                                : Icons.visibility_off,
                            color: CustomColors.lightback,size: 20,),
                            onPressed: (){
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },),
                          hintText: 'Enter Your Password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10,top: 12)
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Password is required";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding:  EdgeInsets.only(left: 5),
                    child: Text("Confirm Password",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      controller: ScpasswordController,
                      obscureText: isVisible,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(icon: Icon(
                            isVisible ?
                            Icons.visibility
                                : Icons.visibility_off,
                            color: CustomColors.lightback,size: 20,),
                            onPressed: (){
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },),
                          hintText: 'Confirm Password',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10,top: 12)
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Password is required";
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 5,top: 10),
                    child: Row (
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              allSelected = ! allSelected;
                            });
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                border: Border.all(color: CustomColors.lightblackAllText)
                            ),
                            child: allSelected ?
                            Icon( Icons.check ,size: 18,)
                                :  SizedBox(),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text("I agree to all terms & condition and privacy policy",style: TextStyle(color: CustomColors.lightblackAllText,fontSize: 13,),),
                      ],
                    ),
                  ),

                  SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.center,
                    child: CustomAppBtn(
                      height: 50,
                      width: 320,
                      title: isLoading == true ? "Please waiit..." : 'SIGN UP',
                      onPress: () {
                      //  if(_formKey.currentState!.validate()) {
                          if (SfirstNameController.text.isNotEmpty &&
                               SemailController.text.contains("@gmail.com") &&
                              SmobileController.text.length == 10 &&
                              SpasswordController.text.isNotEmpty &&
                              ScpasswordController.text.isNotEmpty) {
                            if (SpasswordController.text ==
                                ScpasswordController.text) {
                              if (allSelected == true) {
                                if (widget.userType == "recruiter") {
                                  recruiterSignUp();
                                }
                                else {
                                  seekerSignup();
                                }
                                setState(() {
                                  isLoading = true;
                                });
                              }
                              else {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Please select terms and condition'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar);
                              }
                            }
                            else {
                              const snackBar = SnackBar(
                                content: Text('Both password does not match'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar);
                            }
                          } else {
                            const snackBar = SnackBar(
                              content: Text('All Fields are required!'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) =>LoginScreen()));
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                       /// }

                      },
                    ),
                  ),
                  SizedBox(height: 10,),

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Already have An Account?",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,),),
                        Text(" Login",style: TextStyle(color: CustomColors.secondaryColor,fontSize: 16,),)
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
