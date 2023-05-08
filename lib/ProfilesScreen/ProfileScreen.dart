import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:hiremymate/ProfilesScreen/ProjectScreen.dart';
import 'package:hiremymate/RecruiterSection/recruiterDashboard.dart';
import 'package:hiremymate/ScreenView/Dashbord.dart';
import 'package:hiremymate/ScreenView/NotificationScreen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/ColorClass.dart';
import '../Model/RecruiterProfileModel.dart';
import '../Model/userModel.dart';
import '../RecruiterSection/companyDetails.dart';
import '../RecruiterSection/companyDetailsRecuiter.dart';
import '../RecruiterSection/companyVerification.dart';
import '../Service/api_path.dart';
import 'CertificationScreen.dart';
import 'Education.dart';
import 'JobPreference.dart';
import 'keySkill.dart';
import 'languagesScreen.dart';
import 'personalDetails.dart';
import 'workExperience.dart';
import '../buttons/CustomAppBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? recriuterImageFile;  /// recruiter profile image
  File? imageFile;   /// for seeker profile image
  File? imageFile1;  /// for seeker resume upload
  final ImagePicker _picker = ImagePicker();


  /// for seeeker profile image
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

  downloadFile(String url, String filename) async {
    print("Path herrrrr ${url}");
    print("Apiiii Pathhhh ${ApiPath.resumeUrl} ${url}");
    FileDownloader.downloadFile(
        url: "${ApiPath.resumeUrl}${url}",
        name: "Report",
        onDownloadCompleted: (path) {
          final File file = File(path);
          print("path here ${file}");
          var snackBar = SnackBar(
            backgroundColor: CustomColors.primaryColor,
            content: Text('Resume saved in your downloads'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //This will be the path of the downloaded file
        });
  }

  /// for seeker resume upload
  Future<bool> showExitPopup1() async {
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
                  _getFromCamera1();
                },
                //return false when click on "NO"
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _getFromGallery1();
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

  /// for seeker profile image
  _getFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    // if (pickedFile != null) {
    //   setState(() {
    //  //   imageFile = File(pickedFile.path);
    //   });
    //  // uploadProfile();
    //  // Navigator.pop(context);
    // }
    getCropImage(context, pickedFile!.path);
  }

  /// for seeker profile image
  _getFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    // if (pickedFile != null) {
    //   setState(() {
    //   //  imageFile = File(pickedFile.path);
    //   });
    //
    //   //uploadProfile();
    //  // Navigator.pop(context);
    // }
    getCropImage(context, pickedFile!.path);
  }

  /// for seeker resume upload
  _getFromGallery1() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });
      uploadResume();
      Navigator.pop(context);
    }
  }
  /// for seeker resume upload
  _getFromCamera1() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });
      uploadResume();
      Navigator.pop(context);
    }
  }


  /// for recruiter profile section here
  Future<bool> showRecruiterProfileDialog() async {
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
                  _getRecruiterFromCamera();
                },
                //return false when click on "NO"
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _getRecruiterFromGallery();
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

  /// for recruiter profile upload
  _getRecruiterFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    // if (pickedFile != null) {
    //   setState(() {
    //     recriuterImageFile = File(pickedFile.path);
    //   });
    //   uploadRecruiterProfile();
    //  // uploadResume();
    //   Navigator.pop(context);
    // }
    getCropImage1(context, pickedFile!.path);
  }
  /// for recruiter profile upload
  _getRecruiterFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    // if (pickedFile != null) {
    //   setState(() {
    //     recriuterImageFile = File(pickedFile.path);
    //   });
    //   uploadRecruiterProfile();
    //  // uploadResume();
    //   Navigator.pop(context);
    // }
    getCropImage1(context, pickedFile!.path);
  }


  var filesPath;
  String? fileName;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    setState(() {
      filesPath = result.files.first.path ?? "";
      fileName = result.files.first.name;
      // reportList.add(result.files.first.path.toString());

    });
    var snackBar = SnackBar(
      backgroundColor: CustomColors.primaryColor,
      content: const Text('Document uploaded successfully!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  var resumePath;
  void resumeFunction() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    setState(() {
      resumePath = result.files.first.path ?? "";
      //fileName = result.files.first.name;
      // reportList.add(result.files.first.path.toString());
      uploadResume();
    });
    var snackBar = SnackBar(
      backgroundColor: CustomColors.primaryColor,
      content: const Text('Document uploaded successfully!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  SeekerProfileModel? userModel;
  var userData;

  /// seeker info function
  getSeekerInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=ccda7f4a97a293e93102a0faa100ac3db98f0723'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}seeker_info'));
    request.fields.addAll({
      'seeker_email': '${uid}'
    });
    print("request here now ${request.fields} and ${ApiPath.baseUrl}seeker_info");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonRespone = SeekerProfileModel.fromJson(json.decode(finalResponse));
      // final jsonResponse = json.decode(finalResponse);
      setState(() {
        userModel = jsonRespone;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  RecruiterProfileModel? recruiterProfileModel;

    String? userType;
    getSharedData()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userType =prefs.getString('Role');
      print("user role here now ${userType}");
    }

    /// get recruiter profile function
  getProfiledData()async{
    print("ooooooooooooooo");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString("USERID");
    var headers = {
      'Cookie': 'ci_session=af7c02e772664abfa7caad1f5b272362e2f3c492'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}recruiter_profile'));
    request.fields.addAll({
      'id': '${userid}'
    });
    print("parameter for recruiter profile ${request.fields} and ${ApiPath.baseUrl}recruiter_profile");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = RecruiterProfileModel.fromJson(json.decode(finalResponse));
      print("final json response ${jsonResponse}");
      setState(() {
        recruiterProfileModel = jsonResponse;
      //  paymentStatus = recruiterProfileModel!.data!.pay.toString();
       // print("payment status here ${paymentStatus}");
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      return getSeekerInfo();
    });
    Future.delayed(Duration(milliseconds: 500),(){
      return getProfiledData();
    });
    Future.delayed(Duration(milliseconds: 200),(){
      return getSharedData();
    });
    Future.delayed(Duration(milliseconds: 300),(){
      return getResume();
    });
  }



  List<Map<String, dynamic>> profile = [
    {
      'text': 'Personal Details',
      'address': 'Mumbai',
    },
    {
      'text': 'Job Preference',
      'address': 'Mumbai',
    },

    {
      'text': 'Work Experience',
      'address': 'Mumbai',
    },

    // {"image": "assets/images/2022.png", "name":"card night" ,"location":"assets/images/location.png","address": "Palsia, Indore"},
  ];

    /// upload seeker resume function
  uploadResume()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=4ea291f9defe34e633030f4dfbf00a607f5d706a'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}resume'));
    request.fields.addAll({
      'id':userid.toString(),
    });
   resumePath == null ? null : request.files.add(await http.MultipartFile.fromPath('resume', resumePath.toString()));
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
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  /// upload seeker profile image function
  uploadProfile()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=4ea291f9defe34e633030f4dfbf00a607f5d706a'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}profile_image'));
    request.fields.addAll({
      'id':userid.toString(),
    });
    imageFile == null ? null : request.files.add(await http.MultipartFile.fromPath('img', imageFile!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("checking result here  ${response.statusCode}");
     if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
        setState(() {
          getSeekerInfo();
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
       // Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  var resumedata;

  /// get / show resume function
  getResume()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=aebd16ab147f01fbb42c55f2341879b2753f19a0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}resume_list'));
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
          resumedata = jsonResponse['data'][0]['resume'];
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }

  uploadRecruiterProfile()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=63edff4833db2273038332316db6f2d29afd633b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}update_recruiter_img'));
    request.fields.addAll({
      'id': '${userid}'
    });
   recriuterImageFile == null ? null : request.files.add(await http.MultipartFile.fromPath('img', recriuterImageFile!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
        setState(() {
          getProfiledData();
          var snackBar = SnackBar(
            backgroundColor: CustomColors.primaryColor,
            content: const Text('Profile  uploaded successfully!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        });
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }


  void getCropImage(BuildContext , var image) async {
    print("checking uimage here ${image}");
    var croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    if(croppedFile != null){
    setState(() {
      imageFile = File(croppedFile.path);
    });
    Navigator.pop(context);
    uploadProfile();
    }
    // setState(() {
    //   //imageFile = File(croppedFile!.path);
    // });

  }

  void getCropImage1(BuildContext , var image) async {
    print("checking uimage here ${image}");
    var croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    if(croppedFile != null){
      setState(() {
        recriuterImageFile = File(croppedFile.path);
      });
      Navigator.pop(context);
      uploadRecruiterProfile();
    }
    // setState(() {
    //   //imageFile = File(croppedFile!.path);
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.grade1,
                  CustomColors.grade,
                ],
              ),
            ),
          ),
          centerTitle: true,
          leading: const Icon(
            Icons.add,color:CustomColors.grade1,
          ),
          title: const Text(
            'My Profile',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            InkWell(
              onTap: () {
                // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8), 
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                      CustomColors.AppbarColor1.withOpacity(0.4)),
                  child: const Icon(
                    Icons.notifications_none,
                    color: CustomColors.AppbarColor1,
                  ),
                ),
              ),
            ),
          ]),
        body: SingleChildScrollView(
          child:   userType == 'seeker' ?  userModel ==  null ? Center(child: CircularProgressIndicator(),) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/6.5,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/13,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                CustomColors.grade1,
                                CustomColors.grade,
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          // top: 40,
                          // right: 0,
                          // left: 0,
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 125,
                            width: 125,
                            // height:
                            //     MediaQuery.of(context).size.height / 5.2,
                            // width: MediaQuery.of(context).size.width / 3.2,
                            child: userModel!.data!.img == null  || userModel!.data!.img == "" ? CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  FileImage(imageFile ?? File(" ")),
                              backgroundColor: CustomColors.secondaryColor,
                            ) : CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage('${userModel!.data!.img}'),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                            // top: 130,
                            // right: 140,
                            // left: 180,
                            child: Padding(
                              padding: EdgeInsets.only(left: 78,bottom: 5
                              ),
                              child: InkWell(
                                onTap: () {
                                  showExitPopup();
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: CustomColors.AppbarColor1,
                                      borderRadius: BorderRadius.circular(100)),
                                  // height: 30,
                                  // width: 30,
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: CustomColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${userModel!.data!.name}",
                style: TextStyle(
                    color: CustomColors.darkblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "${userModel!.data!.designation}",
                style: TextStyle(
                    color: CustomColors.darkblack,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                        onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalDetails()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.AppbarColor1,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Personal Details",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about Personal Details",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: const Center(
                                      child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>JobPreference()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomColors.AppbarColor1,
                          ),

                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Job Preference",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about your Job Preference",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkExperience()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomColors.AppbarColor1,
                          ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Work Experience",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about your Work Experience",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Education()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomColors.AppbarColor1,
                          ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Education",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us if you Education",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProjectScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomColors.AppbarColor1,
                          ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Projects",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about your Projects",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CertificationScreen()));
                      },
                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: CustomColors.AppbarColor1,
                        ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Certification",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about your Certification",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>KeySkill()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomColors.AppbarColor1,
                          ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Key Skill",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about your Key Skill",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguagesScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: CustomColors.AppbarColor1,
                          ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Language",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about Personal Details",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),

                    InkWell(
                      onTap: (){
                      //  showExitPopup1();
                        resumeFunction();
                        // FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
                        //
                        // if (result != null) {
                        //  setState(() {
                        //     resume = File(result.files.single.path.toString());
                        //  });
                        // } else {
                        //   // User canceled the picker
                        // }
                      },
                      child:
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0,),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: CustomColors.AppbarColor1,
                            ),
                            height: MediaQuery.of(context).size.height/6.0,
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
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  const Text("Upload Resume",style: TextStyle(
                                      color: CustomColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                                  SizedBox(height: 10),
                                  Center(child: Icon(Icons.upload_file_outlined, color: CustomColors.primaryColor)),
                                  SizedBox(height: 10),
                                 resumePath ==  null ?  resumedata == "" || resumedata == null ? SizedBox.shrink() : Text("${resumedata}")
                                     : Text("${resumePath}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10),
                                 ),
                                ],
                              ),
                            ),
                              // : Text("${resumeData}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10),),
                          ),
                        ),
                      ),

                    ),
                    resumedata ==  null || resumedata == "" ? SizedBox() : MaterialButton(onPressed: (){
                      downloadFile(resumedata.toString(), "resume");
                    },child: Text("Download resume",style: TextStyle(color:Colors.white,),),color: CustomColors.primaryColor,),

                    // Card(
                    //   child: InkWell(
                    //     onTap: (){
                    //       showExitPopup();
                    //     },
                    //     child: Container(
                    //       color: CustomColors.AppbarColor1,
                    //       height: MediaQuery.of(context).size.height / 7,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   "Upload Resume",
                    //                   style: TextStyle(
                    //                       color: CustomColors.primaryColor,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 18),
                    //                 ),
                    //                 SizedBox(height: 20,),
                    //                 Text(
                    //                   "Tell us about Personal Details",
                    //                   style: TextStyle(
                    //                       color: CustomColors.darkblack,
                    //                       fontWeight: FontWeight.normal,
                    //                       fontSize: 15),
                    //                 )
                    //               ],
                    //             ),
                    //             Container(
                    //               height: 45,
                    //               width: 45,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(50),
                    //                   color: CustomColors.lightgray.withOpacity(0.1)
                    //               ),
                    //               child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),
                    //
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 15,),
                  ],
                ),
              )
            ],
          ) :
          recruiterProfileModel == null  ? Center(child: CircularProgressIndicator(),) :  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 11.9,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  CustomColors.grade1,
                                  CustomColors.grade,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Column(
                            children: [
                              Container(
                                height:
                                MediaQuery.of(context).size.height / 5.2,
                                width: MediaQuery.of(context).size.width / 3.2,
                                child: recruiterProfileModel!.data!.img == null  || recruiterProfileModel!.data!.img == "" ? CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                  FileImage(recriuterImageFile ?? File(" ")),
                                  backgroundColor: CustomColors.secondaryColor,
                                ) : CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage('${recruiterProfileModel!.data!.img}'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: 120,
                            right: 145,
                            // left: 180,
                            child: InkWell(
                              onTap: () {
                                showRecruiterProfileDialog();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: CustomColors.AppbarColor1,
                                    borderRadius: BorderRadius.circular(100),
                                ),
                                // height: 30,
                                // width: 30,
                                child: const Center(
                                  child: Icon(
                                    Icons.edit,
                                    color: CustomColors.secondaryColor,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${recruiterProfileModel!.data!.company}",
                style: const TextStyle(
                    color: CustomColors.darkblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                "${recruiterProfileModel!.data!.email}",
                style: const TextStyle(
                    color: CustomColors.darkblack,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalDetails()));
                        },
                        child: Container(
                        decoration: BoxDecoration(
                          color: CustomColors.AppbarColor1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Personal Details",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about Personal Details",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyDetails()));
                        },
                        child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12)
                         ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Company Details",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Tell us about Company Detail",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyVerification()));
                        },
                        child: Container(
                         decoration: BoxDecoration(
                           color: CustomColors.AppbarColor1,
                           borderRadius: BorderRadius.circular(12),
                         ),
                          height: MediaQuery.of(context).size.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Company Verification",
                                      style: TextStyle(
                                          color: CustomColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      "Start Company Verification",
                                      style: TextStyle(
                                          color: CustomColors.darkblack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.lightgray.withOpacity(0.1)
                                  ),
                                  child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Card(
                    //   child: InkWell(
                    //     onTap: (){
                    //       showExitPopup();
                    //     },
                    //     child: Container(
                    //       color: CustomColors.AppbarColor1,
                    //       height: MediaQuery.of(context).size.height / 7,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   "Upload Resume",
                    //                   style: TextStyle(
                    //                       color: CustomColors.primaryColor,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 18),
                    //                 ),
                    //                 SizedBox(height: 20,),
                    //                 Text(
                    //                   "Tell us about Personal Details",
                    //                   style: TextStyle(
                    //                       color: CustomColors.darkblack,
                    //                       fontWeight: FontWeight.normal,
                    //                       fontSize: 15),
                    //                 )
                    //               ],
                    //             ),
                    //             Container(
                    //               height: 45,
                    //               width: 45,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(50),
                    //                   color: CustomColors.lightgray.withOpacity(0.1)
                    //               ),
                    //               child: Center(child: Icon(Icons.arrow_forward_ios_sharp,color: CustomColors.darkblack,)),
                    //
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
