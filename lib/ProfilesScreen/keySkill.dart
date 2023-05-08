
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AuthenticationView/loginScreen.dart';
import '../Helper/ColorClass.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';
import 'package:http/http.dart' as http;


class KeySkill extends StatefulWidget {
  const KeySkill({Key? key}) : super(key: key);

  @override
  State<KeySkill> createState() => _KeySkillState();
}

class _KeySkillState extends State<KeySkill> {
   List<String> _skillNames = [];

  TextEditingController keyController =  TextEditingController();

   updateJobPreference()async{
     String myskill = _skillNames.join(",");
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userid = prefs.getString('USERID');
     var headers = {
       'Cookie': 'ci_session=b4873b943acc967ee047ebd7a85bd88bc25be78e'
     };
     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}key_skill'));
     request.fields.addAll({
       'id':userid.toString(),
       'key_skill': myskill.toString()
     });
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
     if (response.statusCode == 200) {
       var finalResult = await response.stream.bytesToString();
       final jsonResponse = json.decode(finalResult);
       if(jsonResponse['status'] == true){
         setState(() {
           var snackBar = SnackBar(
             content: Text('${jsonResponse['message']}'),
           );
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
         });
         Navigator.pop(context);
       }
     }
     else {
       print(response.reasonPhrase);
     }

   }

   var skildata;

   getlanguageList()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userid = prefs.getString('USERID');
     var headers = {
       'Cookie': 'ci_session=f159e04de9e8f05169e00df14cc3e3c1b651acec'
     };
     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}key_skill_list'));
     request.fields.addAll({
       'id': '${userid}'
     });
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
     if (response.statusCode == 200) {
       var finalResult = await response.stream.bytesToString();
       final jsonResponse = json.decode(finalResult);
       if(jsonResponse['status'] == true){
         setState(() {
           skildata = jsonResponse['data'][0]['key_skill'];
           _skillNames = skildata.split(",");
         });
       }
     }
     else {
       print(response.reasonPhrase);
     }
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getlanguageList();
    });
  }


   int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "Key Skill",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add key skill",style: TextStyle(
                        color: CustomColors.primaryColor,fontSize: 18,fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.AppbarColor1
                      ),
                      height: 50,
                      width: double.maxFinite,
                      child: TextFormField(
                        controller: keyController,
                        onFieldSubmitted: (v){

                          setState(() {
                              _skillNames.add(v);
                          });
                          keyController.clear();
                        },
                        onSaved: (v){
                          setState(() {
                            _skillNames.add(v.toString());
                          });
                          keyController.clear();
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                            hintText: 'Add key skill',
                            border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                     decoration: BoxDecoration(
                       color: CustomColors.AppbarColor1,
                       borderRadius: BorderRadius.circular(10)
                     ),
                     height: MediaQuery.of(context).size.height/2.0,
                     width: double.maxFinite,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Skill Added",style: TextStyle(
                               color: CustomColors.primaryColor,fontSize: 18,fontWeight: FontWeight.bold
                           ),),
                           SizedBox(height: 20,),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Container(
                                 height: MediaQuery.of(context).size.height/3.0,
                                 child: _skillNames.length == 0 ? Text("No skills added") : GridView.builder(
                                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                       mainAxisExtent: 40,
                                       childAspectRatio: 5,
                                      mainAxisSpacing: 8,
                                       crossAxisSpacing: 5
                                     ),
                                     itemCount:_skillNames.length,
                                     itemBuilder: (BuildContext ctx, index) {
                                       return Container(
                                         height: MediaQuery.of(context).size.height/3.0,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(20),
                                             border: Border.all(color:
                                             // isSelected  ?  CustomColors.grade:
                                             CustomColors.lightback)
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Center(
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Expanded(
                                                   child: Text(
                                                     _skillNames[index],
                                                     style: TextStyle(color: CustomColors.darkblack,
                                                         fontSize: 15,
                                                         fontWeight: FontWeight
                                                             .normal),
                                                     textAlign: TextAlign.center,
                                                   ),
                                                 ),
                                                 InkWell(
                                                     onTap: (){
                                                       setState(() {
                                                         _skillNames.removeAt(index);
                                                       });
                                                     },
                                                     child: Icon(Icons.close))
                                               ],
                                             ),
                                           )
                                         ),
                                       );
                                     }),
                               ),

                             ],
                           ),

                         ],
                       ),
                     ),
                   ),
                    SizedBox(height: MediaQuery.of(context).size.height/7.0,),

                    CustomAppBtn(
                      height: 50,
                      width: MediaQuery.of(context).size.height/1.2,
                      title: 'SAVE',
                      onPress: () {
                        updateJobPreference();
                      },
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
