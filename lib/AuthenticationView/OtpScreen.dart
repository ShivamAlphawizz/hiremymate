import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../Helper/ColorClass.dart';
import '../ScreenView/homeScreen.dart';
import '../ScreenView/successScreen.dart';
import '../buttons/CustomButton.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
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
                  "Enter your 4 digit code",
                  style: TextStyle(
                      color: CustomColors.TextColors,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Don't share it with any other",
                  style: TextStyle(color: CustomColors.lightblackAllText),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Image.asset(
                  "assets/images/otpimages.png",
                  height: 150,
                  width: 150,
                )),
                SizedBox(height: 20,),
                Center(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          // Specify direction if desired
                          textDirection: TextDirection.ltr,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10,right: 20),
                            child: Pinput(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              controller: pinController,
                              // focusNode: focusNode,
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsUserConsentApi,
                              listenForMultipleSmsOnAndroid: true,
                              // defaultPinTheme: defaultPinTheme,
                              // validator: (value) {
                              //   return value == '2222' ? null : 'Pin is incorrect';
                              // },
                              onClipboardFound: (value) {
                                debugPrint('onClipboardFound: $value');
                                pinController.setText(value);
                              },
                              hapticFeedbackType: HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                              },
                              onChanged: (value) {
                                debugPrint('onChanged: $value');
                              },
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                color: CustomColors.AppbarColor2,
                                    margin:  EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("00.23"),
                        SizedBox(width: 5,),
                        Text("Sec left",style: TextStyle(
                            color: CustomColors.secondaryColor
                        ),)
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          Text("Didn't Got Code?"),
                          SizedBox(width: 5,),
                          Text("Resend",style: TextStyle(
                              color: CustomColors.secondaryColor
                          ),)
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 40,
                ),
                CustomAppBtn(
                  height: 50,
                  width: 320,
                  title: 'VERIFY',
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SuccessScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
