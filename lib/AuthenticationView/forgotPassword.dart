import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/AuthenticationView/loginScreen.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomButton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10,right: 20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: CustomColors.grade,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.arrow_back,
                        color: CustomColors.AppbarColor1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Forgot password",
                    style: TextStyle(
                        color: CustomColors.TextColors,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enter the Email ID/ Mobile no. associated with your",
                    style: TextStyle(color: CustomColors.lightblackAllText,fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Account we will send you a link to reset your password",
                    style: TextStyle(color: CustomColors.lightblackAllText,fontSize: 14),
                  ),
                  SizedBox(height: 20,),
                  Center(child: Image.asset("assets/images/forgotpasswrd.png",height: 150,)),

                  SizedBox(height: 20,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color: CustomColors.secondaryColor,),
                          hintText: 'Email',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10,top: 15)
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

                  SizedBox(
                    height: 40,
                  ),
                  CustomAppBtn(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    title: 'SEND',
                    onPress: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
