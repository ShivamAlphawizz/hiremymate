import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';

class SupportHelp extends StatefulWidget {
  const SupportHelp({Key? key}) : super(key: key);

  @override
  State<SupportHelp> createState() => _SupportHelpState();
}

class _SupportHelpState extends State<SupportHelp> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  customAppBar(text: "Support & Help",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 5,
                  child: Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height/4.0,
                    decoration: BoxDecoration(
                        color: CustomColors.AppbarColor1,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(top: 15,left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Job Description",style: TextStyle(color: CustomColors.primaryColor,fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Icon(Icons.call,color: CustomColors.secondaryColor,size: 30,)
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("General Support",style: TextStyle(color: CustomColors.darkblack,fontSize: 16,fontWeight: FontWeight.normal)),
                                      Text("Contactus@hiremymate.com",style: TextStyle(color: CustomColors.grade,fontSize: 16,fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                )

                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Icon(Icons.call,color: CustomColors.secondaryColor,size: 30,)
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Website",style: TextStyle(color: CustomColors.darkblack,fontSize: 16,fontWeight: FontWeight.normal)),
                                      Text("www.Hiremymate.com",style: TextStyle(color: CustomColors.grade,fontSize: 16,fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                // SizedBox(height: 10,),
                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: ExpansionTile(
                //     title: Text('How can I update my profile'),
                //     // Contents
                //     children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit"),
                //     )
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: ExpansionTile(
                //     title: Text('How can I update my profile'),
                //     // Contents
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit"),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: ExpansionTile(
                //     title: Text('How can I update my profile'),
                //     // Contents
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit"),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: ExpansionTile(
                //     title: Text('How can I update my profile'),
                //     // Contents
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit"),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: ExpansionTile(
                //     title: Text('How can I update my profile'),
                //     // Contents
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit"),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("If you Can't find a solution You can Write About Your Problem and Send to us",style: TextStyle(color: CustomColors.darkblack),),
                // ),
                // SizedBox(height: 10,),
                // Container(
                //   height: MediaQuery.of(context).size.height/4.5,
                //   decoration: BoxDecoration(
                //     color: CustomColors.AppbarColor1,
                //     borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: TextFormField(
                //     maxLines: 1,
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 10),
                //       border: InputBorder.none,
                //       hintText: "Describe Your Problem here"
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20,),
                // SizedBox(height: MediaQuery.of(context).size.height/11.0,),
                // CustomAppBtn(
                //   height: 50,
                //   width: MediaQuery.of(context).size.height/3.2,
                //   title: 'SEND',
                //   onPress: () {
                //     // Navigator.push(context,
                //     //     MaterialPageRoute(builder: (context) =>LoginScreen()));
                //   },
                // ),
                //
                SizedBox(height: 10,),
              ],
            )
          ),
        )
    );
  }
}
