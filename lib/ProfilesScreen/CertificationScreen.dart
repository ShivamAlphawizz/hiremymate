import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../AuthenticationView/loginScreen.dart';
import '../Helper/ColorClass.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({Key? key}) : super(key: key);

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool allSelected = false;
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController joindatecontroller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController aboutController  = TextEditingController();
  TextEditingController cirtificationController = TextEditingController();
  TextEditingController uploadController = TextEditingController();


  String _dateValue = '';
  var dateFormate;
  String? getCertificate;
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: CustomColors.primaryColor,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  CustomColors.primaryColor),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
       // datecontroller = TextEditingController(text: _dateValue);
        joindatecontroller = TextEditingController(text: _dateValue);
      });
  }

  Future _selectDate1() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: CustomColors.primaryColor,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  CustomColors.primaryColor),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
        // datecontroller = TextEditingController(text: _dateValue);
        enddatecontroller = TextEditingController(text: _dateValue);
      });
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
     // resumeData = null;
      uploadController.text = filesPath.toString();
    });
    var snackBar = SnackBar(
      backgroundColor: CustomColors.primaryColor,
      content: Text('Profile upload successfully'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> showExitPopup() async {
    return await showDialog(

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
        uploadController.text = imageFile!.path;
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
        uploadController.text = imageFile!.path;
      });
      Navigator.pop(context);
    }
  }

   updateJobPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=eaead07e6f52e460bd970ec144bbfe053f691157'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}certification'));
    request.fields.addAll({
      'id':userid.toString(),
      'certification_title': titleController.text,
      'certification_university': universityController.text,
      'certification_start': joindatecontroller.text,
      'certification_end': enddatecontroller.text,
      'about_certificate': aboutController.text,
      'certification_number': cirtificationController.text,
    });
   filesPath == null ? null : request.files.add(await http.MultipartFile.fromPath('certificate', filesPath.toString()));
   print("paramters are here now ${request.fields}");
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


  var jobPreferrence;

  getWorkExperienceData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    var headers = {
      'Cookie': 'ci_session=4ca4db028106c3b1f9d427ffefd3d6b5a5394040'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}certification_list'));
    request.fields.addAll({
      'id': '${userid}'
    });
    print("api parameter with response here ${request.fields} and ${ApiPath.baseUrl}certification_list");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        jobPreferrence = jsonResponse['data'];
        print("checking pppppppppppppppppppppppppppppppppppppppppppppppppp ${jobPreferrence}");
        titleController.text  = jobPreferrence[0]['certification_title'] == "" || jobPreferrence[0]['certification_title'] == "null" ? null : jobPreferrence[0]['certification_title'];
        universityController.text = jobPreferrence[0]['certification_uni'] == ""  || jobPreferrence[0]['certification_uni'] ==  'null' ? null : jobPreferrence[0]['certification_uni'];
        joindatecontroller.text = jobPreferrence[0]['certification_start'] == ""  || jobPreferrence[0]['certification_start'] ==  'null' ? null : jobPreferrence[0]['certification_start'];
        enddatecontroller.text = jobPreferrence[0]['certification_end']  == "" || jobPreferrence[0]['certification_end'] == "null" ? null : jobPreferrence[0]['certification_end'] ;
        aboutController.text = jobPreferrence[0]['about_certificate'] == "" || jobPreferrence[0]['about_certificate'] == "null"  ? null : jobPreferrence[0]['about_certificate'];
        cirtificationController.text = jobPreferrence[0]['certification_number'] == "" || jobPreferrence[0]['certification_number'] == "null" ? null :   jobPreferrence[0]['certification_number'];
        uploadController.text = jobPreferrence[0]['certificate'] == "" || jobPreferrence[0]['certificate'] == "null" ? null : jobPreferrence[0]['certificate'];
        //  courseType.text = jobPreferrence[0]['course_type'] == "" || jobPreferrence[0]['course_type'] == "null" ? null : jobPreferrence[0]['course_type'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds:400),(){
      return getWorkExperienceData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: customAppBar(text: "Certification",isTrue: true, context: context),
          backgroundColor: CustomColors.TransparentColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 12,top: 30,right: 12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        Text("Title",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: 'Enter Your  title',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),

                            ),
                          ),
                        ),

                        SizedBox(height: 8,),
                        Text("University / Institute",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: universityController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                hintText: 'Enter Your University / Institute',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),

                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Started from",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: joindatecontroller,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(onTap: (){
                                  _selectDate();
                                },
                                    child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose Started from',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text("Ended on",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                            controller: enddatecontroller,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: (){
                                      _selectDate1();
                                    },
                                    child: Icon(Icons.calendar_month_rounded,color: CustomColors.secondaryColor,)),
                                hintText: 'Choose End on',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10,top: 15)
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Text("About Certification",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: TextFormField(
                              controller: aboutController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: 'Enter About Certification',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)
                            ),

                          ),
                        ),

                        SizedBox(height: 10,),
                        Text("Upload Certification",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),

                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              onTap: (){
                                _pickFile();
                              },
                              controller: uploadController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: 'Upload Certificate',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Certification number",style: TextStyle(color: CustomColors.grayColor,fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: cirtificationController,
                              decoration: InputDecoration(
                                  counterText: "",
                                  hintText: 'Enter Certification number',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)
                              ),
                            ),
                          ),
                        ),


                        SizedBox(height: 40,),

                        CustomAppBtn(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
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
              ],
            ),
          )
      ),
    );
  }
}
