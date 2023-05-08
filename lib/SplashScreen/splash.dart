import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiremymate/AuthenticationView/loginScreen.dart';
import 'package:hiremymate/RecruiterSection/recruiterDashboard.dart';
import 'package:hiremymate/ScreenView/Dashbord.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../IntroScreen/introscreen.dart';
import '../ScreenView/welcomeScreen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? uid;
  String? type;
  bool? isSeen;

  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('USERID');
      type = prefs.getString('Role');
    });
  }

  checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      print("this is working here");
      if(uid == "" || uid == null ){
        // return SeekerDrawerScreen();
        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
      else{
        print("hello user here  ${uid} and ${type}");
        if(type == "seeker") {
          print("working this here");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Dashboard()));
        }
        else{
          print("working now here ");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecruiterDashboard()));
          /// jsut for ddummy data RecruiterDashboard data is use
        }
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => RecruiterDashboard()));
        }
      // Navigator.of(context).pushReplacement(
      //     new MaterialPageRoute(builder: (context) => new LoginScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroSlider()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 500),(){
      return checkingLogin();
    });
    Future.delayed(Duration(seconds:2),(){
      checkFirstSeen();
      // if(uid == null || uid == ""){
      //   // return SeekerDrawerScreen();
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // }
      // else{
      //   if(type == "seeker") {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => RecruiterDashboard()));
      //   }
      //   else{
      //     /// jsut for ddummy data RecruiterDashboard data is use
      //   }
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => RecruiterDashboard()));
      //   }
        //return SignInScreen();
      });
   // Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroSlider()));});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: 250,
              width: 250,
              decoration: const BoxDecoration(
                  image:DecorationImage(
                      image:AssetImage('assets/splashlogo/splashLogo1.png',),
                      // fit: BoxFit.fill,
                  ),
              ),
          ),
        ),
      ),
    );
  }
}
