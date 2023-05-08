import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/ColorClass.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isVisible = true;
  bool allSelected = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  changePassword()async{
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    String? userType = prefs.getString('Role');
    String? userMobile = prefs.getString("userMobile");
    print("user type here ${userType}");
    var headers = {
      'Cookie': 'ci_session=26cd91f2343081c76d73d176a32b875d72c65b57'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}change_password/${userType}'));
    request.fields.addAll({
      'mobile': userMobile.toString(),
      'password': newPasswordController.text,
      "old_password": oldPasswordController.text,
    });
    print("paramters are here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("final response here ${jsonResponse}");
      var snackBar = SnackBar(
        backgroundColor:CustomColors.primaryColor,
        content: Text('${jsonResponse['message']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:  customAppBar(text: "Change Password",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Old Password",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: TextFormField(
                        controller: oldPasswordController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText: 'Enter Your Old Password',
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
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding:  EdgeInsets.only(left: 5),
                    child: Text("New Password",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: TextFormField(
                        controller: newPasswordController,
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
                            hintText: 'Enter New Password',
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
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("Your New Password must be Different From Your Previous Passwords.",style: TextStyle(color: CustomColors.grade),),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding:  EdgeInsets.only(left: 5),
                    child: Text("Confirm New Password",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: TextFormField(

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
                            hintText: 'Confirm New Password',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10,top: 12)
                        ),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Confirm New Password is required";
                          }
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CustomAppBtn(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.1,
                      title: 'SAVE',
                      onPress: () {
                        // if (_formKey.currentState!.validate()) {
                          changePassword();

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) =>LoginScreen()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                        // const snackBar = SnackBar(
                        //   content: Text('All Fields are required!'),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
