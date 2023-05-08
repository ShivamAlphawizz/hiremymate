import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hiremymate/AuthenticationView/forgotPassword.dart';
import 'package:hiremymate/Helper/ColorClass.dart';
import 'package:hiremymate/ScreenView/Dashbord.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../RecruiterSection/recruiterDashboard.dart';
import '../buttons/CustomButton.dart';
import 'OtpScreen.dart';
import 'SignUpScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}
final _formKey = GlobalKey<FormState>();


class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  bool allSelected = false;

  bool showLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController =  TextEditingController();

  bool isLoading = false;

  String? token;
  getToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = fcmToken.toString();
    });
    print("FCM ID=== $token");
  }

  var userRole;
  getSharedData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('Role');
    print("user type here ${userRole}");
  }

  @override
  void initState(){
    super.initState();
    getToken();
    Future.delayed(Duration(milliseconds: 200),(){
      return getSharedData();
    });
  }

  socialSeekerRegister()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('Role');
    print("Checking role here ${userType}");
    var headers = {
      'Cookie': 'ci_session=735bd58831bcf864e958114f05129e913dff713d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}signUp'));
    request.fields.addAll({
      'type': '${userType}',
      'email': firebaseEmail.toString(),
      'name': firebaseName.toString(),
      'surname': '',
      'ps': '12345678',
      'mno': ''
    });
    print("checking seeker signup request ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print("checking response here ${jsonResponse}");
      if(jsonResponse['staus'] == "false"){
        setState(() {
          String userid = jsonResponse['data']['id'];
          String username = jsonResponse['data']['name'];
          String userEmail = jsonResponse['data']['email'];
          //String userMobile = jsonResponse['data']['mno'];
          print("user id here ${userid} and ${username}");
          prefs.setString('USERID', userid.toString());
          prefs.setString('userEmail', userEmail.toString());
        //  prefs.setString('userMobile', userMobile.toString());
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
      else{
        setState(() {
          showLoading = false;
        });
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // setState(() {
      //   isLoading = false;
      // });
    }
    else {
      print(response.reasonPhrase);
    }

  }

  socialRegister()async{
    SharedPreferences prefs   = await SharedPreferences.getInstance();
    String? userType = prefs.getString('Role');
    var headers = {
      'Cookie': 'ci_session=d3d664bcb0d169b87b880eb8acf7e75ba8f7f695'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}signUp'));
    request.fields.addAll({
      'type': '${userType}',
      'email': firebaseEmail.toString(),
      'name': firebaseName.toString(),
      'company': '',
      'mno': '',
      'ps': '12345678'
    });
    print("request here ${request.fields} and ${ApiPath.baseUrl}signUp");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("checking final response here ${response.statusCode} and ${response}");
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print("checking responese here ${jsonResponse}");
      if(jsonResponse['staus'] == 'true'){
        setState(() {
          String userid = jsonResponse['data']['id'];
          String username = jsonResponse['data']['name'];
          String userEmail = jsonResponse['data']['email'];
          String userMobile = jsonResponse['data']['mno'];
          print("user id here ${userid} and ${username}");
          prefs.setString('USERID', userid.toString());
          prefs.setString('userEmail', userEmail.toString());
          prefs.setString('userMobile', userMobile.toString());
        });
        if(userType == 'recruiter') {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => RecruiterDashboard()), (
                  route) => false);
        }
        else{
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Dashboard()), (
                  route) => false);
        }
      }
      else{
        setState(() {
          isLoading = false;
        });
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

  String? firebaseEmail,firebaseName;

  socialLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('Role');
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    final result =  await FirebaseAuth.instance.signInWithCredential(credential);
    print("google result ${result}");
    setState(() {
      firebaseEmail = result.user!.email;
      firebaseName = result.user!.displayName;
    });
    //  confirmDialog();
    print("firebase data here ${result.user!.uid} ${result.user!.email} and ${result.user!.displayName}");

    if(userType == "seeker"){
     socialSeekerRegister();
    }
    else{
      socialRegister();
    }


    // if(result != null){
    //   showDialog(context: context, builder: (context){
    //     return CustomDialog(textData: "Signing in... please wait",);
    //   });
    //   firebaseGmailLogin(result.user!.email.toString(), result.user!.displayName.toString());
    // }
  }

  seekerLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString('Role');

    var headers = {
      'Cookie': 'ci_session=735bd58831bcf864e958114f05129e913dff713d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}login'));
    request.fields.addAll({
      'type': '${userType}',
      'email': emailController.text,
      'ps': passwordController.text,
      'token':token.toString(),
    });
    print("checking login parameters ${request.fields} and ${ApiPath.baseUrl}login");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['staus'] == 'true'){
        setState(() {
          String userid = jsonResponse['data']['id'];
          String username = jsonResponse['data']['name'];
          String userEmail = jsonResponse['data']['email'];
          String userMobile = jsonResponse['data']['mno'];
          print("user id here ${userid} and ${username} and ${userMobile}");
          prefs.setString('USERID', userid.toString());
          prefs.setString('userEmail', userEmail.toString());
          prefs.setString('userMobile', userMobile.toString());
        });
        if(userType == 'recruiter') {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => RecruiterDashboard()), (
                  route) => false);
        }
        else{
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Dashboard()), (
                  route) => false);
        }
      }
      else{
        setState(() {
          isLoading = false;
        });
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
      'email': firebaseEmail.toString(),
      'name': '${firebaseName}',
      'surname': '',
      'ps': '12345678',
      'mno': ''
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
      // Navigator.po
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
  // recruiterSignUp()async{
  //   var headers = {
  //     'Cookie': 'ci_session=ec94f0bdb488239dc4b0f8c114420748ca7c936d'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}signUp'));
  //   request.fields.addAll({
  //     'type': 'recruiter',
  //     'email': SemailController.text,
  //     'name': SfirstNameController.text,
  //     'company': companyController.text,
  //     'mno': SmobileController.text,
  //     'ps':  SpasswordController.text
  //   });
  //   print("paramters here ${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalResponse = await response.stream.bytesToString();
  //     final jsonResponse = json.decode(finalResponse);
  //     print("final response here ${jsonResponse}");
  //     if (jsonResponse['staus'] == "true" || jsonResponse['staus'] ==  true){
  //       var snackBar = SnackBar(
  //         content: Text('Registered successfully'),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       setState(() {});
  //       Navigator.pop(context);
  //       //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //     }
  //     else {
  //       var snackBar = SnackBar(
  //         content: Text('${jsonResponse['message']}'),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       print(response.reasonPhrase);
  //     }
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.AppbarColor1,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Form(
              key:  _formKey,
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
                  Text("Welcome back!",style: TextStyle(
                      color: CustomColors.TextColors,fontWeight: FontWeight.bold,fontSize: 20
                  ),),
                  SizedBox(height: 10,),
                  Text("Login with your Email/Mobile number Or continue", style: TextStyle(
                      color: CustomColors.lightblackAllText
                  ),),
                  SizedBox(height: 8,),
                  Text("With social media account.", style: TextStyle(
                      color: CustomColors.lightblackAllText
                  ),),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Email/Phone",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email/Phone',
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
                  SizedBox(height: 20,),
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
                      obscureText: isVisible,
                      controller: passwordController,
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
                    padding: const EdgeInsets.only(left: 5,top: 10),
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Container(
                         child: Row(
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
                             Text("Remember me",style: TextStyle(color: CustomColors.lightblackAllText,fontSize: 13,),),
                           ],
                         ),
                       ),
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                            },
                            child: Text("Forgot Password?",style: TextStyle(color: CustomColors.secondaryColor,fontSize: 14),)),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.center,
                    child: CustomAppBtn(
                      height: 50,
                      width: 320,
                      title: isLoading == true ? 'Please wait...' : 'LOGIN',
                      onPress: () {
                        if(emailController.text.isEmpty && passwordController.text.isEmpty){
                          var snackBar = SnackBar(
                            content: Text('All fields are required'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else{
                          seekerLogin();
                          setState(() {
                            isLoading = true;
                          });
                        }
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) =>VerifyOTP()));
                      },
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 30.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text("Or Login with"),
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 30.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ]),



                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/appleicon.png',height: 70,width: 70,),
                      // SizedBox(width: 10),
                      InkWell(
                          onTap: (){
                            setState(() {
                              showLoading = true;
                            });
                            socialLogin();
                          },
                          child: Image.asset('assets/images/googleicon.png',height: 70,width: 70,)),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Don’t have an account?",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,),),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen(userType: userRole,)));
                        },
                          child: Text(" Register Now",style: TextStyle(color: CustomColors.secondaryColor,fontSize: 16,),))
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
