import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';

class CompanyVerification extends StatefulWidget {
  const CompanyVerification({Key? key}) : super(key: key);

  @override
  State<CompanyVerification> createState() => _CompanyVerificationState();
}

class _CompanyVerificationState extends State<CompanyVerification> {
  File? imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController typeController = TextEditingController();
  TextEditingController docNumberController = TextEditingController();
  String? selectedDoctype;

    verifyCompany()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userid = prefs.getString('USERID');
      var headers = {
        'Cookie': 'ci_session=5f3902fb6f3bf35eee79bf1f4acdebb05e626cd7'
      };
      var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}update_recruiter/${userid}'));
      request.fields.addAll({
        'type': 'verification_details',
        'doc_type': selectedDoctype.toString(),
        'doc_number': docNumberController.text
      });
     filesPath == null ? null : request.files.add(await http.MultipartFile.fromPath('document', filesPath.toString()));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var finalResult = await response.stream.bytesToString();
        final jsonResonse = json.decode(finalResult);
        if(jsonResonse['status'] == true){
         setState(() {
           var snackBar = SnackBar(
             content: Text('${jsonResonse['message']}'),
           );
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
         });
          Navigator.pop(context,true);
        }
        else{
          var snackBar = SnackBar(
            content: Text('${jsonResonse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      }
      else {
        print(response.reasonPhrase);
      }

    }


  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _getFromCamera();
                },
                //return false when click on "NO"
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _getFromGallery();
                  // Navigator.pop(context,true);
                  // Navigator.pop(context,true);
                },
                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
  final _formKey = GlobalKey<FormState>();


  var recruiterData;
  String? documentImg;
  getRecruiterDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=f1ec907c5cc3c27da75b5336623f196926b2a903'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}recruiter_profile'));
    request.fields.addAll({
      'id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        recruiterData = jsonResponse['data'];
        typeController.text =
        recruiterData['doc_type'] == "" || recruiterData['doc_type'] == "null"
            ? null
            : recruiterData['doc_type'];
        docNumberController.text = recruiterData['doc_number'] == "" ||
            recruiterData['doc_number'] == "null"
            ? null
            : recruiterData['doc_number'];
        documentImg = recruiterData['document'] == "" || documentImg == "null"
            ? null
            : recruiterData['document'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  var filesPath;
      String? fileName;

  String? resumeData;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    setState(() {
      filesPath = result.files.first.path ?? "";
      fileName = result.files.first.name;
      // reportList.add(result.files.first.path.toString());
      resumeData = null;
    });
    var snackBar = SnackBar(
      backgroundColor:CustomColors.primaryColor,
      content: Text('Profile upload successfully',style: TextStyle(color: Colors.white),),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getRecruiterDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "Company Verification",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 15,left: 12,right: 12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        Text("Document type",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child:
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton(
                        underline: Container(),
                              isExpanded: true,
                              hint: Text("Select document type"),
                              // Initial Value
                              value: selectedDoctype,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              // Array list of items
                              items: ['Company PanCard','GST Number','Registered Number'].map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDoctype = newValue!;
                                });
                              },
                            ),
                          )
                          // TextFormField(
                          //   controller: typeController,
                          //   keyboardType: TextInputType.name,
                          //   decoration: InputDecoration(
                          //       hintText: 'Enter Document type',
                          //       border: InputBorder.none,
                          //       contentPadding: EdgeInsets.only(left: 10)
                          //   ),
                          //   validator: (v) {
                          //     if (v!.isEmpty) {
                          //       return "Document type is required";
                          //     }
                          //
                          //   },
                          // ),
                        ),
                        SizedBox(height: 10,),
                        Text("Document Number",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: docNumberController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: 'Enter Document Number',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Document Number is required";
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Upload documnet",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: (){
                           // showExitPopup();
                            _pickFile();
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: CustomColors.AppbarColor1,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              height: 65,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              // alignment: Alignment.centerLeft,
                              // decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(10)
                              // ),
                              // child: resumeData ==  null  || resumeData == "" ? filesPath == null || filesPath == "" ? Text('Upload resume',style: TextStyle(color: greyColor1,fontSize: 14,fontWeight: FontWeight.w500),) :
                              // Text("${resumeData}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10),)
                              //     : Text("${resumeData}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10),),
                              child:  Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Upload documnet"),
                                        Icon(Icons.upload_file_outlined, color: CustomColors.primaryColor),
                                      ],
                                    ),
                                    SizedBox(height: 1,),
                                  filesPath == null  ? documentImg == "" || documentImg == "null" ? SizedBox() : Text("${documentImg}") :  Text("${filesPath}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10,),maxLines: 2,)
                                  ],
                                ),
                              ),
                              // : Text("${resumeData}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10),),

                            ),
                          ),
                        ),

                        SizedBox(height: 40,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomAppBtn(
                            height: 50,

                            title: 'SAVE',
                            onPress: () {
                              if (selectedDoctype != null) {
                                verifyCompany();
                              } else {  const snackBar = SnackBar(
                                content: Text('All Fields are required!'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) =>LoginScreen()));
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                              }

                            },
                          ),
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          )

      ),
    );
  }
}
