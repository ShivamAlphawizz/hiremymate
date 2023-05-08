import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import 'homeScreen.dart';

class ReferJob extends StatefulWidget {
  const ReferJob({Key? key}) : super(key: key);

  @override
  State<ReferJob> createState() => _ReferJobState();
}

class _ReferJobState extends State<ReferJob> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: customAppBar(text: "Refer Job",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text("Invite Your Friend/Family To Find a ",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.bold,fontSize: 20,),),
                SizedBox(height: 3,),
                Text("job on Hiremymate",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.bold,fontSize: 20,),),
                SizedBox(height: 20,),
                Image.asset("assets/images/referfriend.png"),
                SizedBox(height: 20,),
                Text("Share Via",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.bold,fontSize: 20,),),

                SizedBox(height: 20,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                  child: Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height/3.0,
                    decoration: BoxDecoration(
                        color: CustomColors.AppbarColor1,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                            onTap:()async{
                                              const url = 'https://www.facebook.com/';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              }  else {
                                                print("can't open Facebook");
                                              }
                                            },
                                            child: Image.asset("assets/images/facebook.png",height: 70,width: 70,)),
                                        Text("Facebook"),
                                        SizedBox(height: 30,),
                                        InkWell(
                                            onTap: ()async{
                                              const url = 'https://www.instagram.com/';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              }  else {
                                                print("can't open Instagram");
                                              }
                                            },
                                            child: Image.asset("assets/images/instagram-logo.png",height: 70,width: 70,)),
                                        Text("Instragram"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                            onTap:()async{
                                              const url = 'https://www.twitter.com/';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              }  else {
                                                print("can't open twitter");
                                              }
                                            },
                                            child: Image.asset("assets/images/twitter.png",height: 70,width: 70,)),
                                        Text("Twitter"),
                                        SizedBox(height: 30,),
                                        InkWell(
                                            onTap: ()async{

                                            },
                                            child: Image.asset("assets/images/whatsapp.png",height: 70,width: 70,)),
                                        Text("whatsapp"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                            onTap:()async{
                                              const url = 'https://support.google.com/answer/2451065?hl=en';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              }  else {
                                                print("can't open twitter");
                                              }
                                            },
                                            child: Image.asset("assets/images/google-plus.png",height: 70,width: 70,)),
                                        Text("Google+"),
                                        SizedBox(height: 30,),
                                        InkWell(
                                            onTap: ()async{
                                            },
                                            child: Image.asset("assets/images/email.png",height: 70,width: 70,)),
                                        Text("Email"),
                                      ],
                                    ),
                                  ],
                                )
                          ],
                        )
                    ),
                  ),
                ),

              ],
            )
          ),
        ),

      ),
    );
  }

  getDrawer(){
    return ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        DrawerHeader(
          child: Text("Header"),
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/homeicon.png",scale: 4.2,),
          title: const Text(' Home ',style: TextStyle(color: CustomColors.primaryColor)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/rideicon.png",scale: 4.2,),
          title: const Text('Rides',style: TextStyle(color: CustomColors.primaryColor)),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => RequestinfoScreens()),
            // );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/abouticon.png",scale: 4.2,),
          title: const Text(' My Profile ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => UserProfileScreen()),
            // );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/acomondationicon4.png",scale: 4.2,),
          title: const Text(' Accommodation ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => StoryDemo()),
            // );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/tiffinicon5.png",scale: 4.2,),
          title: const Text(' Tiffin Center  ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => RideScreen()),
            // );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/festival6.png",scale: 4.2,),
          title: const Text(' Festivals & Events ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/holyplace7.png",scale: 4.2,),
          title: const Text(' Holy Places ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/indianstore8.png",scale: 4.2,),
          title: const Text(' Indian Store ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/videoicon.png",scale: 4.2,),
          title: const Text(' Video ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/abouticon.png",scale: 4.2,),
          title: const Text(' About ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: Image.asset("assets/drawerassets/settingicon.png",scale: 4.2,),
          title: const Text(' Settings ',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),

        ListTile(
          leading: Image.asset("assets/drawerassets/logout.png",scale: 4.2,),

          title: const Text('LogOut',style: TextStyle(color: CustomColors.primaryColor),),
          onTap: () {
            // Alert(
            //   context: context,
            //   title: "Log out",
            //   desc: "Are you sure you want to log out?",
            //   style: AlertStyle(
            //       isCloseButton: false,
            //       descStyle:
            //       TextStyle(fontFamily: "MuliRegular", fontSize: 15),
            //       titleStyle: TextStyle(fontFamily: "MuliRegular")),
            //   buttons: [
            //     DialogButton(
            //       child: Text(
            //         "OK",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontFamily: "MuliRegular"),
            //       ),
            //       onPressed: () async {
            //         setState(() {
            //           userID = '';
            //           userEmail = '';
            //           userMobile = '';
            //           likedProduct = [];
            //           likedService = [];
            //         });
            //         // signOutGoogle();
            //         //signOutFacebook();
            //         preferences!
            //             .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
            //             .then((_) {
            //           Navigator.of(context).pushAndRemoveUntil(
            //             MaterialPageRoute(
            //               builder: (context) => Welcome2(),
            //             ),
            //                 (Route<dynamic> route) => false,
            //           );
            //         });
            //
            //         Navigator.of(context, rootNavigator: true).pop();
            //       },
            //       color: backgroundblack,
            //       // color: Color.fromRGBO(0, 179, 134, 1.0),
            //     ),
            //     DialogButton(
            //       child: Text(
            //         "Cancel",
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontFamily: "MuliRegular"),
            //       ),
            //       onPressed: () {
            //         Navigator.of(context, rootNavigator: true).pop();
            //       },
            //       color: backgroundblack,
            //       // gradient: LinearGradient(colors: [
            //       //   Color.fromRGBO(116, 116, 191, 1.0),
            //       //   Color.fromRGBO(52, 138, 199, 1.0)
            //       // ]),
            //     ),
            //   ],
            // ).show();
          },
        ),
      ],
    );
  }
}
