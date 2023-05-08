import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/ColorClass.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.AppbarColor1,
        body: Padding(
          padding: EdgeInsets.only(left: 10,top: 10,right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:40),
                Container(
                  height: MediaQuery.of(context).size.height/3.0,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height/3.0,
                          width:double.infinity,
                          decoration: BoxDecoration(
                            color: CustomColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      Positioned(
                        left: 120,
                          child:Image.asset("assets/images/successimages.png",height: 150,),
                      ),
                      Positioned(
                          top: 130,
                          left: 170,
                          child: Text("I am an\nEmployer",style: TextStyle(
                              color: CustomColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 22
                          ),)
                      ),
                      Positioned(
                          top: 100,
                          left: 170  ,
                          child: Text("I want to find job for me",style: TextStyle(
                              color: CustomColors.AppbarColor1,fontWeight: FontWeight.bold,fontSize: 13
                          ),)
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
