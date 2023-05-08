import 'dart:async';
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiremymate/ProfilesScreen/ProfileScreen.dart';
import 'package:hiremymate/RecruiterSection/homeScreen.dart';
import 'package:hiremymate/RecruiterSection/postJob.dart';
import 'package:hiremymate/RecruiterSection/recruiterProfile.dart';
import 'package:hiremymate/ScreenView/ChatScreen.dart';

import 'package:hiremymate/ScreenView/applyJob.dart';
import 'package:hiremymate/ScreenView/savedJob.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../Helper/notificationServices.dart';
import 'homeScreen.dart';


class Dashboard extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Dashboard> with TickerProviderStateMixin {
  int _selBottom = 0;
  late TabController _tabController;
  bool _isNetworkAvail = true;

  var userRole;
  getSharedData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('Role');
    print("user type here ${userRole}");
  }

  @override
  void initState(){
    PushNotificationService pushNotificationService = new PushNotificationService(context: context);
    pushNotificationService.initialise();
    super.initState();
    Future.delayed(Duration(milliseconds: 200),(){
      return getSharedData();
    });
  }

  List<dynamic> _handlePages = [
    HomeScreen(),
    SavedJob(isValue: false,),
    ApplyJob(isValue: false,),
    ProfileScreen()

  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: CustomColors.primaryColor
                    ),
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: CustomColors.primaryColor
                    ),
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
        // if (_tabController.index != 0) {
        //   _tabController.animateTo(0);
        //   return false;
        // }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: _handlePages[currentIndex],
          bottomNavigationBar: _getBottomNavigator(),
          // appBar: _getAppBar(),

        ),
      ),
    );
  }
  int currentIndex = 0;
  bool isLoading = false;
  Widget _getBottomNavigator() {
    return Material(
      color: CustomColors.primaryColor,
      //elevation: 2,
      child: CurvedNavigationBar(
        index: currentIndex,
        height: 50,
        buttonBackgroundColor: CustomColors.grade1,
        backgroundColor: Color(0xfff4f4f4),
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/bottom3.png',
                  height: 25.0,
                  color: _selBottom == 0 ?   Colors.white : Colors.grey,
                ),
                SizedBox(height: 4,),
                Text("Home" , style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: _selBottom == 0 ?Colors.white : Colors.grey,
                ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/bottom1.png',
                  height: 25.0,
                  color: _selBottom == 1 ?Colors.white :Colors.grey,
                ),
                SizedBox(height: 4,),
                Text("Saved jobs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 10,
                    color: _selBottom == 1 ? Colors.white : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.category,
                //   color: currentIndex == 1 ?  backgroundblack : appColorGrey,),
                Image.asset(
                  'assets/images/bottom2.png',
                  height: 25.0,
                  color: _selBottom == 2 ?  Colors.white:Colors.grey,
                ),
                SizedBox(height: 4,),
                Text("Applied Jobs" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
                  color: _selBottom == 2 ? Colors.white : Colors.grey,
                ),textAlign: TextAlign.center,)
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Column(
          //
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Image.asset(
          //         'assets/images/bottom4.png',
          //         height: 25.0,
          //         color: currentIndex == 3 ? Colors.white :Colors.grey,
          //       ),
          //       SizedBox(height: 4,),
          //       Text("Chat" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
          //         color: _selBottom == 3 ? Colors.white : Colors.grey,
          //       ),)
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 25,
                  color: currentIndex == 3 ? Colors.white :Colors.grey,
                ),
                SizedBox(height: 4,),
                Text("My profile" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
                  color: _selBottom == 3 ? Colors.white : Colors.grey,
                ),)
              ],
            ),
          ),
        ],
        onTap: (index) {
          print("current index here ${index}");
          setState(() {
            currentIndex = index;
            _selBottom = currentIndex;
            print("sel bottom ${_selBottom}");
            //_pageController.jumpToPage(index);
          });
          // if (currentIndex == 3 ) {
          // if (CUR_USERID == null) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Login(),
          //     ),
          //   );
          //   // _pageController.jumpToPage(2);
          // }
          // }
        },
      ),
    );
  }

  // _getBottomNavigator() {
  //   return Material(
  //     color: colors.primary,
  //     //elevation: 2,
  //     child: CurvedNavigationBar(
  //       index: currentIndex,
  //       height: 50,
  //       backgroundColor: Color(0xfff4f4f4),
  //       items: <Widget>[
  //
  //         Padding(
  //           padding: const EdgeInsets.all(4.0),
  //           child: Column(
  //             key: homebaxKey,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Image.asset(
  //                 'assets/images/bottom1.png',
  //                 height: 25.0,
  //                 color: currentIndex == 0 ? colors.secondary : colors.secondary,
  //               ),
  //               // Text("Home",
  //               //   style: TextStyle(
  //               //     fontWeight: FontWeight.bold, fontSize: 10,
  //               //     color: currentIndex == 0 ? Colors.black : Colors.grey,
  //               //   ),
  //               // )
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(4.0),
  //           child: Column(
  //             key: cateeKey,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               // Icon(
  //               //   Icons.category,
  //               //   color: currentIndex == 1 ?  backgroundblack : appColorGrey,),
  //               Image.asset(
  //                 'assets/images/botom2.png',
  //                 height: 25.0,
  //                 color: currentIndex == 1 ?  colors.secondary : colors.secondary,
  //               ),
  //               // Text("Category" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
  //               //   color: currentIndex == 1 ? Colors.black : Colors.grey,
  //               // ),)
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(4.0),
  //           child: Column(
  //             key: videokey,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Image.asset(
  //                 'assets/images/bottom3.png',
  //                 height: 25.0,
  //                 color: currentIndex == 2 ?   colors.secondary : colors.secondary,
  //               ),
  //               // Text("Bookings" , style: TextStyle(
  //               //   fontWeight: FontWeight.bold,
  //               //   fontSize: 10,
  //               //   color: currentIndex == 2 ? Colors.black : Colors.grey,
  //               // ),)
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(4.0),
  //           child: Column(
  //             key: cartKey,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Image.asset(
  //                 'assets/images/bottom4.png',
  //                 height: 25.0,
  //                 color: currentIndex == 3 ?  colors.secondary : colors.secondary,
  //               ),
  //               // Text("Profile" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
  //               //   color: currentIndex == 3 ? Colors.black : Colors.grey,
  //               // ),)
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(4.0),
  //           child: Column(
  //             key: profile,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Image.asset(
  //                   'assets/images/bottom5.png',
  //                   height: 25.0,
  //                   color: currentIndex == 4 ?  colors.secondary : colors.secondary
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //       onTap: (index) {
  //         print("current index here ${index}");
  //         setState(() {
  //           currentIndex = index;
  //           _selBottom = currentIndex;
  //           print("sel bottom ${_selBottom}");
  //           //_pageController.jumpToPage(index);
  //         });
  //         // if (currentIndex == 3 ) {
  //         // if (CUR_USERID == null) {
  //         //   Navigator.push(
  //         //     context,
  //         //     MaterialPageRoute(
  //         //       builder: (context) => Login(),
  //         //     ),
  //         //   );
  //         //   // _pageController.jumpToPage(2);
  //         // }
  //         // }
  //       },
  //     ),
  //   );
  // }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
