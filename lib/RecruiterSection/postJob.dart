// import 'dart:convert';
// import 'dart:math' as math;
//
// import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hiremymate/Helper/ColorClass.dart';
// import 'package:hiremymate/Model/LanguageModel.dart';
// import 'package:hiremymate/Model/myPlanModel.dart';
// import 'package:hiremymate/RecruiterSection/recruiterDashboard.dart';
// import 'package:hiremymate/buttons/CustomButton.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:search_choices/search_choices.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Model/AddJobDataModel.dart';
// import '../Model/RecruiterProfileModel.dart';
// import '../Service/api_path.dart';
// import '../buttons/CustomAppBar.dart';
//
// class PostJobScreen extends StatefulWidget {
//   const PostJobScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PostJobScreen> createState() => _PostJobScreenState();
// }
//
// class _PostJobScreenState extends State<PostJobScreen> {
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   String? selectedLanguages;
//   bool valuefirst = false;
//   bool valuesecond = false;
//   bool isloading =  false;
//   List<String> hiringList = [];
//   List<String> minSalaryListMonthly = [
//     "10",
//     "15",
//     "20",
//     "25",
//     "35",
//     "40"
//   ];
//   List<String> maxSalaryListMonthly = [
//     "15",
//     "20",
//     "25",
//     "30",
//     "40",
//   ];
//   List locationList = [];
//   List<String> maxSalaryListYearLy = [
//     "2",
//     "5",
//     "10",
//     "15",
//     "20"
//   ];
//   List<String> minSalaryListYearLy = [
//     "2",
//     "5",
//     "10",
//     "15",
//     "20"
//   ];
//
//   String? jobType,qualification,passingYear,experience,jobRoles,minSalary,maxSalary,vaccancy,specialization,location, selectedDesignation;
//   Razorpay _razorpay = Razorpay();
//   TextEditingController minController  =  TextEditingController();
//   TextEditingController maxController = TextEditingController();
//   TextEditingController jobRoleController = TextEditingController();
//   TextEditingController descriptionController  = TextEditingController();
//   // TextEditingController vaccancyNoController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   String? lastDateApply;
//   List _selectedItems2 =[];
//   int selectedIndex = 1;
//     String? planid;
//     String? planAmount;
//     String? userEmail;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(milliseconds: 500),(){
//       return addJobDataFunction();
//     });
//     Future.delayed(Duration(milliseconds: 150),(){
//       return getProfiledData();
//     });
//     Future.delayed(Duration(milliseconds: 150),(){
//       return getLanguanages();
//     });
//     // Future.delayed(Duration(milliseconds: 800),(){
//     //  return checkStatus();
//     // });
//     Future.delayed(Duration(milliseconds: 550),(){
//       return getPlans();
//     });
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   checkStatus(){
//     if(paymentStatus == 'no'){
//       setState(() {
//        // openPostjobDialog();
//         getPlans();
//       });
//     }
//   }
//
//   purcheasApi(String pymtid,String amount)async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userEmail = prefs.getString("");
//     var headers = {
//       'Cookie': 'ci_session=b29e882d4d300ec29020d553597463396c0bdb0c'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}payu_success'));
//     request.fields.addAll({
//       'id': '${planid}',
//       'mihpayid': '${pymtid}',
//       'email': 'daniel@gmail.com',
//       'mode': 'Razorpay',
//       'status': 'Success',
//       'amount': '${amount}'
//     });
//     print("paramters of purchase api  ${request.fields} and ${ApiPath.baseUrl}payu_success");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult =  await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResult);
//       print("final jsonResponse here for payment ${jsonResponse}");
//       if(jsonResponse['staus'] == 'true'){
//         var snackBar = SnackBar(
//           content: Text('Plan activated successfully'),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         setState(() {
//           Navigator.pop(context,true);
//         });
//         await getProfiledData();
//        // final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddJob()));
//        // print("checking result here value here ${result}");
//        // if(result == true){
//           // var snackBar = SnackBar(
//           //   content: Text('Plan activated successfully'),
//           // );
//           // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           // Navigator.pop(context);
//           // await  getProfiledData();
//           // getMyJobs();
//    //     }
//      //   if(result == null){
//
//           //await getProfiledData();
//       //  }
//         setState(() {
//         });
//       }
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   List selectedCategoryItems = [];
//   String? selectCatItems;
//
//   void _showMultiSelect() async {
//     final List? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return MultiSelect();
//         });
//       },
//     );
//
//     // Update UI
//     if (results != null) {
//       setState(() {
//         _selectedItems2 = results;
//       });
//       selectedCategoryItems = results.map((item) => item.id).toList();
//       selectCatItems = selectedCategoryItems.join(',');
//       // print(
//       //     "this is result == ${_selectedItems.toString()} aaaaand ${selectedCategoryItems.toString()} &&&&&& ${selectCatItems.toString()}");
//     }
//   }
//
//   // void _showMultiSelect() async {
//   //   final List? results = await showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return StatefulBuilder(builder: (context, setState) {
//   //         return MultiSelect(
//   //           // type: type.toString(),
//   //         );
//   //       });
//   //     },
//   //   );
//   //
//   //   // Update UI
//   //   // if (results != null) {
//   //   //   setState(() {
//   //   //     _selectedItems2 = results;
//   //   //   });
//   //   //   selectedCategoryItems = results.map((item) => item.id).toList();
//   //   //   selectCatItems = selectedCategoryItems.join(',');
//   //   // }
//   // }
//
//   checkOut() {
//     int amount  = int.parse(planAmount.toString()) * 100;
//     print("checking amount here ${amount}");
//     var options = {
//       'key': "rzp_test_CpvP0qcfS4CSJD",
//       'amount': amount,
//       'currency': 'INR',
//       'name': 'HiremyMate',
//       'description': '',
//       // 'prefill': {'contact': userMobile, 'email': userEmail},
//     };
//     print("OPTIONS ===== $options");
//     _razorpay.open(options);
//   }
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     // var userId = await MyToken.getUserID();
//     var snackBar = SnackBar(
//       content: Text('Payment Successfull'),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     //purchasePlan("$userId", planI,"${response.paymentId}");
//     purcheasApi('ssdsd', planAmount.toString(),);
//     // Do something when payment succeeds
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//     print("FAILURE === ${response.message}");
//     // UtilityHlepar.getToast("${response.message}");
//     var snackBar = SnackBar(
//       content: Text('Payment Failed'),
//     );
//
// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet was selected
//   }
//
//   List<String> jobTypeList = [];
//   List<String> jobRoleList = [];
//   List qualificationList = [];
//   List experienceList = [];
//   List<String> designationList = [];
//   List<String> specializationsList = [];
//   List yearList = [];
//   List languageList = [];
//
//   List<dynamic> selectedJobType = [];
//   List<dynamic> selectedJobRole = [];
//   List<dynamic> selectedLocation = [];
//   // List<dynamic> selectedDesignation = [];
//   List<dynamic> selectedExperience = [];
//   List<dynamic> selectedQualification = [];
//   List<dynamic> selectedYear = [];
//   List<dynamic> selectedspecializations = [];
//   // List<dynamic> selectedlanguage = [];
//
//   AddJobDataModel? addJobDataModel;
//
//   addJobDataFunction()async{
//     var headers = {
//       'Cookie': 'ci_session=b54ea4dc21bb9562023ebd8c74e28340f129a573'
//     };
//     var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}job_post_lists'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = AddJobDataModel.fromJson(json.decode(finalResponse));
//       setState(() {
//         addJobDataModel = jsonResponse;
//       });
//       print("final data here ${addJobDataModel!.data!.jobRoles![0].name}");
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   RecruiterProfileModel? recruiterProfileModel;
//   String? paymentStatus;
//
//   getProfiledData()async{
//     print("ooooooooooooooo");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString("USERID");
//     var headers = {
//       'Cookie': 'ci_session=af7c02e772664abfa7caad1f5b272362e2f3c492'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}recruiter_profile'));
//     request.fields.addAll({
//       'id': '${userid}'
//     });
//     print("parameter for recruiter profile ${request.fields} and ${ApiPath.baseUrl}recruiter_profile");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = RecruiterProfileModel.fromJson(json.decode(finalResponse));
//       print("final json response ${jsonResponse}");
//       setState(() {
//         recruiterProfileModel = jsonResponse;
//         paymentStatus = recruiterProfileModel!.data!.pay.toString();
//         print("payment status here ${paymentStatus}");
//         userEmail = recruiterProfileModel!.data!.email.toString();
//         // checkStatus();
//
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//   LanguageModel? languageModel;
//   getLanguanages()async{
//     var headers = {
//       'Cookie': 'ci_session=8b5f1079371d3dd8e3e58f25660a57224239842f'
//     };
//     var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}language_list'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       final jsonResuilt = LanguageModel.fromJson(json.decode(finalResult));
//       setState(() {
//         languageModel = jsonResuilt;
//       });
//
//       languageList.clear();
//       for(var i=0;i<languageModel!.data!.length; i++){
//         languageList.add(languageModel!.data![i].name.toString());
//         print("Languagee list name ${languageModel!.data![i].name.toString()}");
//       }
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//   postJob()async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString('USERID');
//     String hiringData = hiringList.join(",");
//
//     var headers = {
//       'Cookie': 'ci_session=c5efed1303ab938120bcaa43daf60f005db47cbb'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}add_job'));
//     request.fields.addAll({
//       'user_id': '$userid',
//       'job_type': '$jobType',
//       'designation': '$selectedDesignation',
//       'qualification': '$qualification',
//       'passing_year': '$passingYear',
//       'experience': '$experience',
//       'salary_range':  selectedIndex == 1 ? 'monthly' :'yearly',
//       'min': minController.text,
//       'max': maxController.text,
//       'no_of_vaccancies': '${vaccancy.toString()}',
//       'job_role': '$jobRoles',
//       'end_date': '$lastDateApply',
//       'hiring_process': '$hiringData',
//       'specialization': '$specialization',
//       'location': location.toString(),
//       'description': descriptionController.text,
//       'language':selectedLanguages.toString(),
//     });
//     print("paras are here ${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print("final response here ${jsonResponse}");
//       if(jsonResponse['status'] == "true"){
//         // Fluttertoast.showToast(msg: "${jsonResponse['message']}");
//         var snackBar = SnackBar(
//           content: Text('${jsonResponse['message']}'),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         // Navigator.pop(context,true)
//         Navigator.push(context, MaterialPageRoute(builder: (context) => RecruiterDashboard()));
//       }
//
//     }
//     else {
//       print(response.reasonPhrase);
//       setState(() {
//         isloading = false;
//       });
//     }
//   }
//
//
//   bool isSelected = true;
//
//  MyPlanModel? planModel;
//
//   getPlans()async {
//     var headers = {
//       'Cookie': 'ci_session=870de272991b64efd0ff1c6a3f8f9ecf1905cc7d'
//     };
//     var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}plans'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = MyPlanModel.fromJson(json.decode(finalResponse));
//       setState(() {
//         planModel = jsonResponse;
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   // openPostjobDialog(){
//   //   return showDialog(context: context, builder: (context){
//   //     return StatefulBuilder(builder: (context,setState){
//   //       return AlertDialog(
//   //         content: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: [
//   //             // Container(
//   //             //   height: 70,
//   //             //   alignment: Alignment.center,
//   //             //   color: primaryColor,
//   //             //   child: Text("Select Payment Plan", style: TextStyle(fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),),
//   //             // ),
//   //             // Container(
//   //             //     height: 250,
//   //             //     width: MediaQuery.of(context).size.width,
//   //             //     child: ListView.builder(
//   //             //         shrinkWrap: true,
//   //             //         itemCount: getPlansModel!.data!.length,
//   //             //         itemBuilder: (c,i){
//   //             //           return  CustomPlanTile(planName: "${getPlansModel!.data![i].name}",
//   //             //
//   //             //             planPrice: "₹ ${getPlansModel!.data![i].amountInr}",
//   //             //             description1: "${getPlansModel!.data![i].planDurationCount} ${getPlansModel!.data![i].planDurationType}",
//   //             //             description2: "${getPlansModel!.data![i].description}",onTap: ()async{
//   //             //               // final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddJob()));
//   //             //               // print("checking result here value here ${result}");
//   //             //               // if(result == true){
//   //             //               //   Navigator.pop(context);
//   //             //               //   getMyJobs();
//   //             //               // }
//   //             //               // if(result == null){
//   //             //               //   Navigator.pop(context);
//   //             //               // }
//   //             //               // setState(() {
//   //             //               // });
//   //             //               if(getPlansModel!.data![i].amountInr == "0"){
//   //             //                 planAmount = getPlansModel!.data![i].amountInr.toString();
//   //             //                 planid = getPlansModel!.data![i].id.toString();
//   //             //                 purcheasApi('ssdsd', planAmount,);
//   //             //                 // var snackBar = SnackBar(
//   //             //                 //   backgroundColor: primaryColor,
//   //             //                 //   content: Text("Plan amount can't be 0"),
//   //             //                 // );
//   //             //                 // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   //             //               }
//   //             //               else{
//   //             //                 setState((){
//   //             //                   planAmount = getPlansModel!.data![i].amountInr.toString();
//   //             //                   planid = getPlansModel!.data![i].id.toString();
//   //             //                 });
//   //             //                 checkOut();
//   //             //               }
//   //             //             },
//   //             //           );
//   //             //         })
//   //             // ),
//   //             // CustomTextButton(buttonText: "Close", onTap: (){
//   //             //   Navigator.of(context).pop();
//   //             // },)
//   //             Container(
//   //              // height: MediaQuery.of(context).size.height/1.6,
//   //                 child:  Column(
//   //                   children: [
//   //                     Container(
//   //                       height: MediaQuery.of(context).size.height/1.6,
//   //                       child: planModel == null ? Center(child: CircularProgressIndicator(),) : GridView.builder(
//   //                         itemCount: planModel!.data!.length,
//   //                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //                             crossAxisCount: 2,
//   //                             childAspectRatio: 3/3.8,
//   //                             crossAxisSpacing: 8.0,
//   //                             mainAxisSpacing: 8.0
//   //                         ),
//   //                         itemBuilder: (BuildContext context, int index){
//   //                           return InkWell(
//   //                             onTap: (){
//   //                               setState((){
//   //                               planid =  planModel!.data![index].id.toString();
//   //                                 planAmount = planModel!.data![index].amountInr.toString();
//   //                               checkOut();
//   //                               });
//   //                             },
//   //                             child: Stack(
//   //                               children: [
//   //                                 Container(
//   //                                   width:120,
//   //                                   height: 130,
//   //                                   decoration: BoxDecoration(
//   //                                       borderRadius: BorderRadius.circular(8),
//   //                                       color: CustomColors.TransparentColor,
//   //                                     border: Border.all(color: CustomColors.grade1,width: 2)
//   //                                   ),
//   //                                   padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
//   //                                   child: Column(
//   //                                     crossAxisAlignment: CrossAxisAlignment.center,
//   //                                     mainAxisAlignment: MainAxisAlignment.center,
//   //                                     mainAxisSize: MainAxisSize.min,
//   //                                     children: [
//   //
//   //                                       Container(
//   //                                         height: 55,
//   //                                         width: 55,
//   //                                         alignment:Alignment.center,
//   //                                         decoration: BoxDecoration(
//   //                                             color: Colors.white,
//   //                                             borderRadius: BorderRadius.circular(100)
//   //                                         ),
//   //                                         child: Text("${planModel!.data![index].name}",style: TextStyle(color: CustomColors.darkblack,fontWeight: FontWeight.w600,fontSize: 15),),
//   //                                       ),
//   //                                       SizedBox(height: 10,),
//   //                                       Text("${planModel!.data![index].description}", style:  TextStyle(color: CustomColors.grade1,fontSize: 12,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)
//   //                                     ],
//   //                                   ),
//   //                                 ),
//   //                                 Align(
//   //                                   alignment:Alignment.topRight,
//   //                                   child: Icon(Icons.check,color: CustomColors.grade1,),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //                           );
//   //                         },
//   //                       ),
//   //                     ),
//   //                     SizedBox(height: 20,),
//   //                     CustomAppBtn(title: 'CLOSE',onPress: (){
//   //                       Navigator.pop(context);
//   //                     },height: 45,)
//   //                   ],
//   //                 )),
//   //
//   //           ],
//   //         ),
//   //       );
//   //     });
//   //   });
//   // }
//
//   @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //       key: _scaffoldKey,
//   //       backgroundColor: CustomColors.TransparentColor,
//   //     body: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         CustomAppBar(text: "Post Job",),
//   //         Expanded(
//   //           child: addJobDataModel == null ? Center(child: CircularProgressIndicator() ,) : ListView(
//   //             shrinkWrap: true,
//   //             physics:AlwaysScrollableScrollPhysics(),
//   //             padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
//   //             children: [
//   //               /// job type
//   //               Text("Job Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
//   //               SizedBox(height: 5,),
//   //                 addJobDataModel == null ? Center(child: CircularProgressIndicator(),) :   Container(
//   //                 height: 60,
//   //                 alignment: Alignment.centerLeft,
//   //                 padding: EdgeInsets.only(left: 5),
//   //                 decoration: BoxDecoration(
//   //                   color: Colors.white,
//   //                   borderRadius: BorderRadius.circular(10)
//   //                 ),
//   //                 child: DropdownButton(
//   //                   isExpanded: true,
//   //                   // Initial Value
//   //                   underline: Container(),
//   //                   value: jobType,
//   //                   hint: Padding(
//   //                     padding: EdgeInsets.only(left: 5),
//   //                     child: Text("Job Type"),
//   //                   ),
//   //                   // Down Arrow Icon
//   //                   icon:  Padding(
//   //                     padding: EdgeInsets.only(right: 5),
//   //                     child: Icon(Icons.keyboard_arrow_down),
//   //                   ),
//   //                   // Array list of items
//   //                   items: addJobDataModel!.data!.jobTypes!.map((items) {
//   //                     return DropdownMenuItem(
//   //                       value: items.name.toString(),
//   //                       child: Text(items.name.toString()),
//   //                     );
//   //                   }).toList(),
//   //                   // After selecting the desired option,it will
//   //                   // change button value to selected value
//   //                   onChanged: (String? newValue) {
//   //                     setState(() {
//   //                       jobType = newValue!;
//   //                     });
//   //                   },
//   //                 ),
//   //               ),
//   //               SizedBox(height: 10,),
//   //               /// designation type
//   //               Text("Designation",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 5,),
//   //               // Container(
//   //               //   height: 55,
//   //               //   alignment: Alignment.centerLeft,
//   //               //   padding: EdgeInsets.only(left: 5),
//   //               //   decoration: BoxDecoration(
//   //               //       color: Colors.white,
//   //               //       borderRadius: BorderRadius.circular(10)
//   //               //   ),
//   //               //   child: addJobDataModel == null ? Center(child: CircularProgressIndicator(),) : DropdownButton(
//   //               //     isExpanded: true,
//   //               //     // Initial Value
//   //               //     underline: Container(),
//   //               //     value: selectedDesignation,
//   //               //     hint: Text("Designation"),
//   //               //     // Down Arrow Icon
//   //               //     icon:  Icon(Icons.keyboard_arrow_down),
//   //               //
//   //               //     // Array list of items
//   //               //     items: addJobDataModel!.data!.designations!.map(( items) {
//   //               //       return DropdownMenuItem(
//   //               //         value: items.name.toString(),
//   //               //         child: Text(items.name.toString()),
//   //               //       );
//   //               //     }).toList(),
//   //               //
//   //               //     onChanged: (String? newValue) {
//   //               //       setState(() {
//   //               //         selectedDesignation = newValue!;
//   //               //       });
//   //               //     },
//   //               //   ),
//   //               // ),
//   //
//   //               CustomSearchableDropDown(
//   //                 items: designationList,
//   //                 label: 'Select Designation',
//   //                 multiSelectTag: 'Names',
//   //                 decoration: BoxDecoration(
//   //                     color: Colors.white
//   //                 ),
//   //                 multiSelect: true,
//   //                 prefixIcon: Padding(
//   //                   padding:  EdgeInsets.all(2.0),
//   //                     child: Container(
//   //                         height: 30,
//   //                         width: 30,
//   //                         child: Image.asset("assets/drawerImages/designation.png", scale: 1.5))
//   //                 ),
//   //                 suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //                 dropDownMenuItems: designationList.map((item) {
//   //                   return item;
//   //                 }).toList() ?? [],
//   //                 onChanged: (value){
//   //                   if(value!=null)
//   //                   {
//   //                     setState(() {
//   //                       selectedDesignation = jsonDecode(value);
//   //                       // addJobDataModel = value;
//   //                     });
//   //                     print("selected designation here ${selectedDesignation}");
//   //                   }
//   //                   else{
//   //                     selectedDesignation.clear();
//   //                   }
//   //                 },
//   //               ),
//   //               selectedDesignation.length  == 0 ? SizedBox.shrink() :  Wrap(
//   //                 children:  selectedDesignation.map((e){
//   //                   return  Container(
//   //                     margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
//   //                     height: 35,
//   //                     padding: EdgeInsets.symmetric(horizontal: 5),
//   //                     alignment: Alignment.center,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       color: CustomColors.lightgray.withOpacity(0.2),
//   //                     ),
//   //                     child: Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Text("${e}"),
//   //                         SizedBox(width: 10,),
//   //                         InkWell(
//   //                             onTap: (){
//   //                               setState(() {
//   //                                 selectedDesignation.remove(e);
//   //                                 // addJobDataModel!.data!.designations!.remove(e);
//   //                               });
//   //                             },
//   //                             child: Icon(Icons.clear,size: 20,)
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 }).toList(),
//   //               ),
//   //               const SizedBox(height: 10),
//   //               /// Qualification
//   //               const Text("Qualification",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               const SizedBox(
//   //                 height: 5,
//   //               ),
//   //               // Container(
//   //               //   height: 55,
//   //               //   alignment: Alignment.centerLeft,
//   //               //   padding: EdgeInsets.only(left: 5),
//   //               //   decoration: BoxDecoration(
//   //               //       color: Colors.white,
//   //               //       borderRadius: BorderRadius.circular(10)
//   //               //   ),
//   //               //   child: DropdownButton(
//   //               //     isExpanded: true,
//   //               //     // Initial Value
//   //               //     underline: Container(),
//   //               //     value: qualification,
//   //               //     hint: Text("Qualification"),
//   //               //     // Down Arrow Icon
//   //               //     icon: const Icon(Icons.keyboard_arrow_down),
//   //               //
//   //               //     // Array list of items
//   //               //     items: addJobDataModel!.data!.qualifications!.map((items) {
//   //               //       return DropdownMenuItem(
//   //               //         value: items.name.toString(),
//   //               //         child: Text(items.name.toString()),
//   //               //       );
//   //               //     }).toList(),
//   //               //     // After selecting the desired option,it will
//   //               //     // change button value to selected value
//   //               //     onChanged: (String? newValue) {
//   //               //       setState(() {
//   //               //         qualification = newValue!;
//   //               //       });
//   //               //     },
//   //               //   ),
//   //               // ),
//   //               CustomSearchableDropDown(
//   //                 items: qualificationList,
//   //                 label: 'Select Qualification',
//   //                 multiSelectTag: 'Names',
//   //                 decoration: const BoxDecoration(
//   //                     color: Colors.white
//   //                 ),
//   //                 multiSelect: true,
//   //                 prefixIcon: Padding(
//   //                   padding:  EdgeInsets.all(2.0),
//   //                   child: Container(
//   //                       height: 30,
//   //                       width: 30,
//   //                       child: Image.asset("assets/drawerImages/qualifications.png", scale: 1.5, color: Colors.black87))),
//   //                 suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //                 dropDownMenuItems: qualificationList.map((item) {
//   //                   return item;
//   //                 }).toList() ?? [],
//   //                 onChanged: (value){
//   //                   if(value!=null)
//   //                   {
//   //                     setState(() {
//   //                       selectedQualification = jsonDecode(value);
//   //                     });
//   //                     print("selected designation here ${selectedQualification}");
//   //                   }
//   //                   else{
//   //                     selectedQualification.clear();
//   //                   }
//   //                 },
//   //               ),
//   //               selectedQualification.length  == 0 ? SizedBox.shrink() :  Wrap(
//   //                 children:  selectedQualification.map((e){
//   //                   return  Container(
//   //                     margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
//   //                     height: 35,
//   //                     padding: EdgeInsets.symmetric(horizontal: 5),
//   //                     alignment: Alignment.center,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       color: CustomColors.lightgray.withOpacity(0.2),
//   //                     ),
//   //                     child: Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Text("${e}"),
//   //                         SizedBox(width: 10,),
//   //                         InkWell(
//   //                             onTap: (){
//   //                               setState(() {
//   //                                 selectedQualification.remove(e);
//   //                                 // addJobDataModel!.data!.designations!.remove(e);
//   //                               });
//   //                             },
//   //                             child: Icon(Icons.clear,size: 20,)
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 }).toList(),
//   //               ),
//   //               SizedBox(height: 10,),
//   //               /// Location
//   //               const Text("Location",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500, ),),
//   //               SizedBox(height: 5),
//   //               // Container(
//   //               //   height: 55,
//   //               //   alignment: Alignment.centerLeft,
//   //               //   padding: EdgeInsets.only(left: 5),
//   //               //   decoration: BoxDecoration(
//   //               //       color: Colors.white,
//   //               //       borderRadius: BorderRadius.circular(10)
//   //               //   ),
//   //               //   child: DropdownButton(
//   //               //     isExpanded: true,
//   //               //     // Initial Value
//   //               //     underline: Container(),
//   //               //     value: location,
//   //               //     hint: Text("Location"),
//   //               //     // Down Arrow Icon
//   //               //     icon: const Icon(Icons.keyboard_arrow_down),
//   //               //
//   //               //     // Array list of items
//   //               //     items: addJobDataModel!.data!.locations!.map((items) {
//   //               //       return DropdownMenuItem(
//   //               //         value: items.name.toString(),
//   //               //         child: Text(items.name.toString()),
//   //               //       );
//   //               //     }).toList(),
//   //               //     // After selecting the desired option,it will
//   //               //     // change button value to selected value
//   //               //     onChanged: (String? newValue) {
//   //               //       setState(() {
//   //               //         location = newValue!;
//   //               //       });
//   //               //     },
//   //               //   ),
//   //               // ),
//   //               // CustomSearchableDropDown(
//   //               //   items: addJobDataModel!.data!.locations!,
//   //               //   label: 'Select Location',
//   //               //   decoration: const BoxDecoration(
//   //               //       color: Colors.white
//   //               //   ),
//   //               //   prefixIcon: Padding(
//   //               //     padding:  EdgeInsets.all(2.0),
//   //               //     child: Image.asset("assets/drawerImages/location.png", scale: 1.5)
//   //               //   ),
//   //               //   suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //               //   dropDownMenuItems: addJobDataModel!.data!.locations!.map((item) {
//   //               //     return item.name;
//   //               //   }).toList() ??
//   //               //       [],
//   //               //   onChanged: (value){
//   //               //     if(value!=null)
//   //               //     {
//   //               //       setState(() {
//   //               //         location = value.name.toString();
//   //               //       });
//   //               //       print("selected designation here ${location}");
//   //               //     }
//   //               //     else{
//   //               //       location=null;
//   //               //     }
//   //               //   },
//   //               // ),
//   //               CustomSearchableDropDown(
//   //                 items: locationList,
//   //                 label: 'Select Location',
//   //                 multiSelectTag: 'Names',
//   //                 decoration: const BoxDecoration(
//   //                     color: Colors.white
//   //                 ),
//   //                 multiSelect: true,
//   //                 prefixIcon: Padding(
//   //                     padding:  EdgeInsets.all(2.0),
//   //                     child: Container(
//   //                         height: 30,
//   //                         width: 30,
//   //                         child: Image.asset("assets/drawerImages/location.png", scale: 1.5, color: Colors.grey))),
//   //                 suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //                 dropDownMenuItems: locationList.map((item) {
//   //                   return item;
//   //                 }).toList() ?? [],
//   //                 onChanged: (value){
//   //                   if(value!=null)
//   //                   {
//   //                     setState(() {
//   //                       selectedLocation = jsonDecode(value);
//   //                     });
//   //                     print("selected designation here ${selectedLocation}");
//   //                   }
//   //                   else{
//   //                     selectedLocation.clear();
//   //                   }
//   //                 },
//   //               ),
//   //               selectedLocation.length  == 0 ? SizedBox.shrink() :  Wrap(
//   //                 children:  selectedLocation.map((e){
//   //                   return  Container(
//   //                     margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
//   //                     height: 35,
//   //                     padding: EdgeInsets.symmetric(horizontal: 5),
//   //                     alignment: Alignment.center,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       color: CustomColors.lightgray.withOpacity(0.2),
//   //                     ),
//   //                     child: Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Text("${e}"),
//   //                         SizedBox(width: 10,),
//   //                         InkWell(
//   //                             onTap: (){
//   //                               setState(() {
//   //                                 selectedLocation.remove(e);
//   //                                 // addJobDataModel!.data!.designations!.remove(e);
//   //                               });
//   //                             },
//   //                             child: Icon(Icons.clear,size: 20,)
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 }).toList(),
//   //               ),
//   //
//   //               // TextFormField(
//   //               //   controller: addressController ,
//   //               //   decoration: InputDecoration(
//   //               //       hintText: "Location",
//   //               //       border: UnderlineInputBorder(
//   //               //         borderSide: BorderSide(color: greyColor1)
//   //               //       )
//   //               //   ),
//   //               // ),
//   //               SizedBox(height: 20),
//   //               /// passing year
//   //               Text("Passing Year",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 5),
//   //               // Container(
//   //               //   height: 55,
//   //               //   alignment: Alignment.centerLeft,
//   //               //   padding: EdgeInsets.only(left: 5),
//   //               //   decoration: BoxDecoration(
//   //               //       color: Colors.white,
//   //               //       borderRadius: BorderRadius.circular(10)
//   //               //   ),
//   //               //   child: DropdownButton(
//   //               //     underline: Container(),
//   //               //     isExpanded: true,
//   //               //     // Initial Value
//   //               //     value: passingYear,
//   //               //     hint: Text("Passing year"),
//   //               //     // Down Arrow Icon
//   //               //     icon: const Icon(Icons.keyboard_arrow_down),
//   //               //
//   //               //     // Array list of items
//   //               //     items: addJobDataModel!.data!.years!.map((items) {
//   //               //       return DropdownMenuItem(
//   //               //         value: items.toString(),
//   //               //         child: Text(items.toString()),
//   //               //       );
//   //               //     }).toList(),
//   //               //     // After selecting the desired option,it will
//   //               //     // change button value to selected value
//   //               //     onChanged: (String? newValue) {
//   //               //       setState(() {
//   //               //         passingYear = newValue!;
//   //               //       });
//   //               //     },
//   //               //   ),
//   //               // ),
//   //               CustomSearchableDropDown(
//   //                 items: yearList,
//   //                 label: 'Select years',
//   //                 multiSelectTag: 'Names',
//   //                 multiSelect: true,
//   //                 decoration: const BoxDecoration(
//   //                     color: Colors.white
//   //                 ),
//   //                 prefixIcon: Padding(
//   //                   padding:  EdgeInsets.all(2.0),
//   //                     child: Container(
//   //                         height: 30,
//   //                         width: 30,
//   //                         child: Image.asset("assets/drawerImages/year.png", scale: 1.6,))
//   //                 ),
//   //                 suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //                 dropDownMenuItems: yearList.map((item) {
//   //                   return item;
//   //                 }).toList() ?? [],
//   //                 onChanged: (value){
//   //                   if(value!=null)
//   //                   {
//   //                     setState(() {
//   //                       selectedYear = jsonDecode(value);
//   //                       // passingYear = value.name.toString();
//   //                     });
//   //                     print("selected designation here ${selectedYear}");
//   //                   }
//   //                   else{
//   //                     selectedYear.clear();
//   //                   }
//   //                 },
//   //               ),
//   //               selectedYear.length  == 0 ? SizedBox.shrink() :  Wrap(
//   //                 children:  selectedYear.map((e){
//   //                   return  Container(
//   //                     margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
//   //                     height: 35,
//   //                     padding: EdgeInsets.symmetric(horizontal: 5),
//   //                     alignment: Alignment.center,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       color: CustomColors.lightgray.withOpacity(0.2),
//   //                     ),
//   //                     child: Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Text("${e}"),
//   //                         SizedBox(width: 10,),
//   //                         InkWell(
//   //                             onTap: (){
//   //                               setState(() {
//   //                                 selectedYear.remove(e);
//   //                                 // addJobDataModel!.data!.designations!.remove(e);
//   //                               });
//   //                             },
//   //                             child: Icon(Icons.clear,size: 20,)
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 }).toList(),
//   //               ),
//   //               SizedBox(height: 10),
//   //               /// Experience section
//   //               Text("Experience",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
//   //               SizedBox(height: 5),
//   //               // Container(
//   //               //   height: 55,
//   //               //   alignment: Alignment.centerLeft,
//   //               //   padding: EdgeInsets.only(left: 5),
//   //               //   decoration: BoxDecoration(
//   //               //       color: Colors.white,
//   //               //       borderRadius: BorderRadius.circular(10)
//   //               //   ),
//   //               //   child: DropdownButton(
//   //               //     underline: Container(),
//   //               //     isExpanded: true,
//   //               //     // Initial Value
//   //               //     value: experience,
//   //               //     hint: Text("Experience"),
//   //               //     // Down Arrow Icon
//   //               //     icon: const Icon(Icons.keyboard_arrow_down),
//   //               //
//   //               //     // Array list of items
//   //               //     items: addJobDataModel!.data!.experiences!.map(( items) {
//   //               //       return DropdownMenuItem(
//   //               //         value: items.name
//   //               //             .toString(),
//   //               //         child: Text(items.name.toString()),
//   //               //       );
//   //               //     }).toList(),
//   //               //     // After selecting the desired option,it will
//   //               //     // change button value to selected value
//   //               //     onChanged: (String? newValue) {
//   //               //       setState(() {
//   //               //         experience = newValue!;
//   //               //       });
//   //               //     },
//   //               //   ),
//   //               // ),
//   //               CustomSearchableDropDown(
//   //                 items: experienceList,
//   //                 label: 'Select experience',
//   //                 multiSelectTag: 'Names',
//   //                 multiSelect: true,
//   //                 decoration: BoxDecoration(
//   //                     color: Colors.white
//   //                 ),
//   //                 prefixIcon:  Padding(
//   //                   padding:  EdgeInsets.all(2.0),
//   //                   child: Container(
//   //                       height: 30,
//   //                       width: 30,
//   //                       child: Image.asset("assets/drawerImages/experiance.png", scale: 1.5, color: Colors.black87,))
//   //                 ),
//   //                 suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //                 dropDownMenuItems: experienceList.map((item) {
//   //                   return item;
//   //                 }).toList() ?? [],
//   //                 onChanged: (value){
//   //                   if(value!=null)
//   //                   {
//   //                     setState(() {
//   //                       selectedExperience = jsonDecode(value);
//   //                       // experience = value.name.toString();
//   //                     });
//   //                     print("selected designation here ${selectedExperience}");
//   //                   }
//   //                   else{
//   //                     selectedExperience.clear();
//   //                   }
//   //                 },
//   //               ),
//   //               selectedExperience.length  == 0 ? SizedBox.shrink() :  Wrap(
//   //                 children:  selectedExperience.map((e){
//   //                   return  Container(
//   //                     margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
//   //                     height: 35,
//   //                     padding: EdgeInsets.symmetric(horizontal: 5),
//   //                     alignment: Alignment.center,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       color: CustomColors.lightgray.withOpacity(0.2),
//   //                     ),
//   //                     child: Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Text("${e}"),
//   //                         SizedBox(width: 10,),
//   //                         InkWell(
//   //                             onTap: (){
//   //                               setState(() {
//   //                                 selectedExperience.remove(e);
//   //                                 // addJobDataModel!.data!.designations!.remove(e);
//   //                               });
//   //                             },
//   //                             child: Icon(Icons.clear,size: 20,)
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 }).toList(),
//   //               ),
//   //               SizedBox(height: 10),
//   //               Text("Specialization",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 5,),
//   //               // Container(
//   //               //   height: 55,
//   //               //   alignment: Alignment.centerLeft,
//   //               //   padding: EdgeInsets.only(left: 5),
//   //               //   decoration: BoxDecoration(
//   //               //       color: Colors.white,
//   //               //       borderRadius: BorderRadius.circular(10)
//   //               //   ),
//   //               //   child: DropdownButton(
//   //               //     isExpanded: true,
//   //               //     underline: Container(),
//   //               //     // Initial Value
//   //               //     value: specialization,
//   //               //     hint: Text("Specialization"),
//   //               //     // Down Arrow Icon
//   //               //     icon: const Icon(Icons.keyboard_arrow_down),
//   //               //
//   //               //     // Array list of items
//   //               //     items: addJobDataModel!.data!.specializations!.map(( items) {
//   //               //       return DropdownMenuItem(
//   //               //         value: items.name
//   //               //             .toString(),
//   //               //         child: Text(items.name.toString()),
//   //               //       );
//   //               //     }).toList(),
//   //               //     // After selecting the desired option,it will
//   //               //     // change button value to selected value
//   //               //     onChanged: (String? newValue) {
//   //               //       setState(() {
//   //               //         specialization = newValue!;
//   //               //       });
//   //               //     },
//   //               //   ),
//   //               // ),
//   //               CustomSearchableDropDown(
//   //                 items: specializationsList,
//   //                 label: 'Select specialization',
//   //                 multiSelectTag: 'Names',
//   //                 multiSelect: true,
//   //                 decoration: const BoxDecoration(
//   //                     color: Colors.white
//   //                 ),
//   //                 prefixIcon:  Padding(
//   //                   padding:  EdgeInsets.all(2.0),
//   //                   child:  Container(
//   //                       height: 30,
//   //                       width: 30,
//   //                       child: Image.asset("assets/drawerImages/specilization.png", scale: 1.5))
//   //                 ),
//   //                 suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //                 dropDownMenuItems: specializationsList.map((item) {
//   //                   return item;
//   //                 }).toList() ??
//   //                     [],
//   //                 onChanged: (value){
//   //                   if(value!=null)
//   //                   {
//   //                     setState(() {
//   //                       selectedspecializations = jsonDecode(value);
//   //                       // specialization = value.name.toString();
//   //                     });
//   //                     print("selected designation here ${selectedspecializations}");
//   //                   }
//   //                   else{
//   //                     selectedspecializations.clear();
//   //                    // specialization=null;
//   //                   }
//   //                 },
//   //               ),
//   //               selectedspecializations.length  == 0 ? SizedBox.shrink() :  Wrap(
//   //                 children:  selectedspecializations.map((e){
//   //                   return  Container(
//   //                     margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
//   //                     height: 35,
//   //                     padding: EdgeInsets.symmetric(horizontal: 5),
//   //                     alignment: Alignment.center,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(15),
//   //                       color: CustomColors.lightgray.withOpacity(0.2),
//   //                     ),
//   //                     child: Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Text("${e}"),
//   //                         SizedBox(width: 10,),
//   //                         InkWell(
//   //                             onTap: (){
//   //                               setState(() {
//   //                                 selectedspecializations.remove(e);
//   //                                 // addJobDataModel!.data!.designations!.remove(e);
//   //                               });
//   //                             },
//   //                             child: Icon(Icons.clear,size: 20)
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
//   //                 }).toList(),
//   //               ),
//   //               SizedBox(height: 10,),
//   //               /// salary type
//   //               Text("Salary Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
//   //               SizedBox(height: 20,),
//   //               Container(
//   //                 child: Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //                   children: [
//   //                     InkWell(
//   //                       onTap: (){
//   //                         setState(() {
//   //                           selectedIndex = 1;
//   //                         });
//   //                       },
//   //                       child: Container(
//   //                         child:
//   //                         Row(
//   //                           children: [
//   //                             Container(
//   //                               height:20,
//   //                               width: 20,
//   //                               padding: EdgeInsets.all(3),
//   //                               decoration: BoxDecoration(
//   //                                   borderRadius: BorderRadius.circular(100),
//   //                                   border: Border.all(color: selectedIndex == 1 ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//   //                               ),
//   //                               child: Container(
//   //                                 decoration: BoxDecoration(
//   //                                   borderRadius: BorderRadius.circular(100),
//   //                                   color: selectedIndex == 1 ? CustomColors.primaryColor : Colors.transparent,
//   //                                 ),
//   //                               ),
//   //                             ),
//   //                             SizedBox(width: 10,),
//   //                             Text("Monthly",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//   //                           ],
//   //                         ),
//   //                       ),
//   //                     ),
//   //                     InkWell(
//   //                       onTap: (){
//   //                         setState(() {
//   //                           selectedIndex = 2;
//   //                         });
//   //                       },
//   //                       child: Container(
//   //                         child:
//   //                         Row(
//   //                           children: [
//   //                             Container(
//   //                               height:20,
//   //                               width: 20,
//   //                               padding: EdgeInsets.all(3),
//   //                               decoration: BoxDecoration(
//   //                                   borderRadius: BorderRadius.circular(100),
//   //                                   border: Border.all(color: selectedIndex == 2 ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//   //                               ),
//   //                               child: Container(
//   //                                 decoration: BoxDecoration(
//   //                                   borderRadius: BorderRadius.circular(100),
//   //                                   color: selectedIndex == 2 ? CustomColors.primaryColor : Colors.transparent,
//   //                                 ),
//   //                               ),
//   //                             ),
//   //                             SizedBox(width: 10,),
//   //                             Text("Yearly",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//   //                           ],
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //               SizedBox(height: 10,),
//   //               /// Salary range
//   //               Text("Salary Range",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 10,),
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                 children: [
//   //                   Expanded(
//   //                     child: TextFormField(
//   //                       controller: minController ,
//   //                       keyboardType: TextInputType.number,
//   //                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//   //                       decoration: const InputDecoration(
//   //                         fillColor: Colors.white,
//   //                           filled: true,
//   //                           hintText: "Min Salary",
//   //                           border: OutlineInputBorder(
//   //                               borderSide: BorderSide(color: CustomColors.grade1)
//   //                           )
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 10,),
//   //                   Expanded(
//   //                     child: TextFormField(
//   //                       controller: maxController ,
//   //                       keyboardType: TextInputType.number,
//   //                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//   //                       decoration: const InputDecoration(
//   //                           fillColor: Colors.white,
//   //                           filled: true,
//   //                           hintText: "Max Salary",
//   //                           border: OutlineInputBorder(
//   //                               borderSide: BorderSide(color: CustomColors.grade1)
//   //                           )
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   // Expanded(
//   //                   //   child:  selectedIndex == 1 ?   DropdownButton(
//   //                   //     isExpanded: true,
//   //                   //     // Initial Value
//   //                   //     value: minSalary,
//   //                   //     hint: Text("Min Salary"),
//   //                   //     // Down Arrow Icon
//   //                   //     icon: const Icon(Icons.keyboard_arrow_down),
//   //                   //
//   //                   //     // Array list of items
//   //                   //     items: minSalaryListMonthly.map(( items) {
//   //                   //       return DropdownMenuItem(
//   //                   //         value: items
//   //                   //             .toString(),
//   //                   //         child: Text(items.toString()),
//   //                   //       );
//   //                   //     }).toList(),
//   //                   //     // After selecting the desired option,it will
//   //                   //     // change button value to selected value
//   //                   //     onChanged: (String? newValue) {
//   //                   //       setState(() {
//   //                   //         minSalary = newValue!;
//   //                   //       });
//   //                   //     },
//   //                   //   ): DropdownButton(
//   //                   //     isExpanded: true,
//   //                   //     // Initial Value
//   //                   //     value: maxSalary,
//   //                   //     hint: Text("Max Salary"),
//   //                   //     // Down Arrow Icon
//   //                   //     icon: const Icon(Icons.keyboard_arrow_down),
//   //                   //
//   //                   //     // Array list of items
//   //                   //     items:minSalaryListYearLy.map(( items) {
//   //                   //       return DropdownMenuItem(
//   //                   //         value: items
//   //                   //             .toString(),
//   //                   //         child: Text(items.toString()),
//   //                   //       );
//   //                   //     }).toList(),
//   //                   //     // After selecting the desired option,it will
//   //                   //     // change button value to selected value
//   //                   //     onChanged: (String? newValue) {
//   //                   //       setState(() {
//   //                   //         maxSalary = newValue!;
//   //                   //       });
//   //                   //     },
//   //                   //   ),
//   //                   // ),
//   //                   // SizedBox(width: 10,),
//   //                   // Expanded(
//   //                   //   child:   selectedIndex == 2 ? DropdownButton(
//   //                   //     isExpanded: true,
//   //                   //     // Initial Value
//   //                   //     value: minSalary,
//   //                   //     hint: Text("Min Salary"),
//   //                   //     // Down Arrow Icon
//   //                   //     icon: const Icon(Icons.keyboard_arrow_down),
//   //                   //
//   //                   //     // Array list of items
//   //                   //     items: maxSalaryListYearLy.map(( items) {
//   //                   //       return DropdownMenuItem(
//   //                   //         value: items
//   //                   //             .toString(),
//   //                   //         child: Text(items.toString()),
//   //                   //       );
//   //                   //     }).toList(),
//   //                   //     // After selecting the desired option,it will
//   //                   //     // change button value to selected value
//   //                   //     onChanged: (String? newValue) {
//   //                   //       setState(() {
//   //                   //         minSalary = newValue!;
//   //                   //       });
//   //                   //     },
//   //                   //   ) : DropdownButton(
//   //                   //     isExpanded: true,
//   //                   //     // Initial Value
//   //                   //     value: maxSalary,
//   //                   //     hint: Text("Max Salary"),
//   //                   //     // Down Arrow Icon
//   //                   //     icon: const Icon(Icons.keyboard_arrow_down),
//   //                   //
//   //                   //     // Array list of items
//   //                   //     items: maxSalaryListMonthly.map(( items) {
//   //                   //       return DropdownMenuItem(
//   //                   //         value: items
//   //                   //             .toString(),
//   //                   //         child: Text(items.toString()),
//   //                   //       );
//   //                   //     }).toList(),
//   //                   //     // After selecting the desired option,it will
//   //                   //     // change button value to selected value
//   //                   //     onChanged: (String? newValue) {
//   //                   //       setState(() {
//   //                   //         maxSalary = newValue!;
//   //                   //       });
//   //                   //     },
//   //                   //   ),
//   //                   // ),
//   //                 ],
//   //               ),
//   //               SizedBox(height: 20,),
//   //               /// No of vaccancies
//   //               Text("No of vacancies",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 5,),
//   //               // TextFormField(
//   //               //   controller: vaccancyNoController ,
//   //               //   keyboardType: TextInputType.number,
//   //               //   decoration: InputDecoration(
//   //               //       hintText: "No of vacancies",
//   //               //       border: UnderlineInputBorder(
//   //               //           borderSide: BorderSide(color: greyColor1)
//   //               //       )
//   //               //   ),
//   //               // ),
//   //               Container(
//   //                 height: 55,
//   //                 alignment: Alignment.centerLeft,
//   //                 padding: EdgeInsets.only(left: 5),
//   //                 decoration: BoxDecoration(
//   //                     color: Colors.white,
//   //                     borderRadius: BorderRadius.circular(10)
//   //                 ),
//   //                 child: DropdownButton(
//   //                   isExpanded: true,
//   //                   // Initial Value
//   //                   underline: Container(),
//   //                   value: vaccancy,
//   //                   hint: Text("No of vaccancies"),
//   //                   // Down Arrow Icon
//   //                   icon: const Icon(Icons.keyboard_arrow_down),
//   //                   // Array list of items
//   //                   items: ['1','2','3','4','5','6','7','8','9','10'].map(( items) {
//   //                     return DropdownMenuItem(
//   //                       value: items
//   //                           .toString(),
//   //                       child: Text(items.toString()),
//   //                     );
//   //                   }).toList(),
//   //                   // After selecting the desired option,it will
//   //                   // change button value to selected value
//   //                   onChanged: (String? newValue) {
//   //                     setState(() {
//   //                       vaccancy = newValue!;
//   //                     });
//   //                   },
//   //                 ),
//   //               ),
//   //               SizedBox(height: 20,),
//   //               /// job Role
//   //               Text("Job Role",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 5,),
//   //               // Container(
//   //               //   height: 55,
//   //               //   alignment: Alignment.centerLeft,
//   //               //   padding: EdgeInsets.only(left: 5),
//   //               //   decoration: BoxDecoration(
//   //               //       color: Colors.white,
//   //               //       borderRadius: BorderRadius.circular(10)
//   //               //   ),
//   //               //   child: DropdownButton(
//   //               //     isExpanded: true,
//   //               //     // Initial Value
//   //               //     underline: Container(),
//   //               //     value: jobRoles,
//   //               //     hint: Text("Job Role"),
//   //               //     // Down Arrow Icon
//   //               //     icon: const Icon(Icons.keyboard_arrow_down),
//   //               //
//   //               //     // Array list of items
//   //               //     items: addJobDataModel!.data!.jobRoles!.map((items) {
//   //               //       return DropdownMenuItem(
//   //               //         value: items.name.toString(),
//   //               //         child: Text(items.name.toString()),
//   //               //       );
//   //               //     }).toList(),
//   //               //     // After selecting the desired option,it will
//   //               //     // change button value to selected value
//   //               //     onChanged: (String? newValue) {
//   //               //       setState(() {
//   //               //         jobRoles = newValue!;
//   //               //       });
//   //               //     },
//   //               //   ),
//   //               // ),
//   //               CustomSearchableDropDown(
//   //                 items: addJobDataModel!.data!.jobRoles!,
//   //                 label: 'Select JobRole',
//   //                 decoration: BoxDecoration(
//   //                     color: Colors.white
//   //                 ),
//   //                 prefixIcon:  Padding(
//   //                   padding:  EdgeInsets.all(1.0),
//   //                   child:  Image.asset("assets/drawerImages/jobrole.png", scale: 1.5)
//   //                 ),
//   //                 suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//   //                 dropDownMenuItems: addJobDataModel!.data!.jobRoles!.map((item) {
//   //                   return item.name;
//   //                 }).toList() ??
//   //                     [],
//   //                 onChanged: (value){
//   //                   if(value!=null)
//   //                   {
//   //                     setState(() {
//   //                       jobRoles = value.name.toString();
//   //                     });
//   //                     print("selected designation here ${jobRoles}");
//   //                   }
//   //                   else{
//   //                     jobRoles=null;
//   //                   }
//   //                 },
//   //               ),
//   //
//   //               SizedBox(height: 20,),
//   //               /// language
//   //               Text("Select Language",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 5,),
//   //             languageModel == null ? SizedBox.shrink() :  Container(
//   //                 height: 55,
//   //                 alignment: Alignment.centerLeft,
//   //                 padding: EdgeInsets.only(left: 5),
//   //                 decoration: BoxDecoration(
//   //                     color: Colors.white,
//   //                     borderRadius: BorderRadius.circular(10)
//   //                 ),
//   //                 child: DropdownButton(
//   //                   isExpanded: true,
//   //                   // Initial Value
//   //                   underline: Container(),
//   //                   value: selectedLanguages,
//   //                   hint: Text("Select Languages"),
//   //                   // Down Arrow Icon
//   //                   icon: const Icon(Icons.keyboard_arrow_down),
//   //                   // Array list of items
//   //                   items: languageModel!.data!.map((items) {
//   //                     return DropdownMenuItem(
//   //                       value: items.name.toString(),
//   //                       child: Text(items.name.toString()),
//   //                     );
//   //                   }).toList(),
//   //                   // After selecting the desired option,it will
//   //                   // change button value to selected value
//   //                   onChanged: (String? newValue) {
//   //                     setState(() {
//   //                       selectedLanguages = newValue!;
//   //                     });
//   //                   },
//   //                 ),
//   //               ),
//   //
//   //               SizedBox(height: 10,),
//   //               Text("Last date of application",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 15,),
//   //               InkWell(
//   //                 onTap: () async {
//   //                   DateTime? pickedDate = await showDatePicker(
//   //                       context: context,
//   //                       initialDate: DateTime.now(),
//   //                       firstDate: DateTime(1950),
//   //                       //DateTime.now() - not to allow to choose before today.
//   //                       lastDate: DateTime(2100),
//   //                       builder: (context,child){
//   //                         return Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(
//   //                           primary: CustomColors.primaryColor,
//   //                         )), child: child!);
//   //                       }
//   //                   );
//   //
//   //                   if (pickedDate != null) {
//   //                     //pickedDate output format => 2021-03-10 00:00:00.000
//   //                     String formattedDate =
//   //                     DateFormat('yyyy-MM-dd').format(pickedDate);
//   //                     //formatted date output using intl package =>  2021-03-16
//   //                     setState(() {
//   //                       lastDateApply =
//   //                           formattedDate; //set output date to TextField value.
//   //                     });
//   //                   } else {}
//   //                 },
//   //                 child: Container(
//   //                   height: 55,
//   //                   padding: EdgeInsets.symmetric(horizontal: 10),
//   //                   alignment: Alignment.centerLeft,
//   //                   decoration: BoxDecoration(
//   //                   color: Colors.white,
//   //                     borderRadius: BorderRadius.circular(10)
//   //                   ),
//   //                   child: lastDateApply == null ? Text("Last date",) : Text("${lastDateApply}",),
//   //                 ),
//   //               ),
//   //               SizedBox(height: 20,),
//   //               /// Hiring Process
//   //               Text("Hiring Process",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 10,),
//   //               Container(
//   //                 child: Column(
//   //                   children: [
//   //                     Row(
//   //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //                       crossAxisAlignment: CrossAxisAlignment.center,
//   //                       children: [
//   //                         Expanded(
//   //                           child: Container(
//   //                             child:
//   //                             InkWell(
//   //                               onTap:(){
//   //                                 if(hiringList.contains('Face to Face')){
//   //                                   hiringList.remove('Face to Face');
//   //                                 }
//   //                                 else{
//   //                                   hiringList.add('Face to Face');
//   //                                 }
//   //                                 setState(() {
//   //
//   //                                 });
//   //                               },
//   //                               child:Container(
//   //                                 child:
//   //                                 Row(
//   //                                   children: [
//   //                                     Container(
//   //                                       height:20,
//   //                                       width: 20,
//   //                                       padding: EdgeInsets.all(3),
//   //                                       decoration: BoxDecoration(
//   //                                           borderRadius: BorderRadius.circular(100),
//   //                                           border: Border.all(color: hiringList.contains('Face to Face') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//   //                                       ),
//   //                                       child: Container(
//   //                                         decoration: BoxDecoration(
//   //                                           borderRadius: BorderRadius.circular(100),
//   //                                           color: hiringList.contains('Face to Face') ? CustomColors.primaryColor : Colors.transparent,
//   //                                         ),
//   //                                       ),
//   //                                     ),
//   //                                     SizedBox(width: 10,),
//   //                                     Text("Face to Face",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//   //                                   ],
//   //                                 ),
//   //                               ),
//   //                               // Row(
//   //                               //     children: [
//   //                               //       Container(
//   //                               //         height: 20,
//   //                               //         width: 20,
//   //                               //         //padding: EdgeInsets.all(3),
//   //                               //         alignment: Alignment.center,
//   //                               //         decoration: BoxDecoration(
//   //                               //             border: Border.all(color: primaryColor)
//   //                               //         ),
//   //                               //         child: hiringList.contains('Face to Face') ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//   //                               //       ),
//   //                               //       SizedBox(width: 10,),
//   //                               //       Text("Face to Face"),
//   //                               //     ],
//   //                               // ),
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         Expanded(
//   //                           child: InkWell(
//   //                             onTap: (){
//   //                               if(hiringList.contains('Written-test')){
//   //                                 hiringList.remove('Written-test');
//   //                               }
//   //                               else{
//   //                                 hiringList.add('Written-test');
//   //                               }
//   //                               setState(() {
//   //
//   //                               });
//   //                             },
//   //                             child: Container(
//   //                               child:Row(
//   //                                 children: [
//   //                                   Container(
//   //                                     height:20,
//   //                                     width: 20,
//   //                                     padding: EdgeInsets.all(3),
//   //                                     decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(100),
//   //                                         border: Border.all(color: hiringList.contains('Written-test') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//   //                                     ),
//   //                                     child: Container(
//   //                                       decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(100),
//   //                                         color: hiringList.contains('Written-test') ? CustomColors.primaryColor : Colors.transparent,
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                   SizedBox(width: 10,),
//   //                                   Text("Written-test",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//   //                                 ],
//   //                               ),
//   //                               // Row(
//   //                               //   children: [
//   //                               //     Container(
//   //                               //       height: 20,
//   //                               //       width: 20,
//   //                               //     //  padding: EdgeInsets.all(3),
//   //                               //       alignment: Alignment.center,
//   //                               //       decoration: BoxDecoration(
//   //                               //           border: Border.all(color: primaryColor)
//   //                               //       ),
//   //                               //       child:hiringList.contains('Written-test')  ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//   //                               //     ),
//   //                               //     SizedBox(width: 10,),
//   //                               //     Text("Written-test"),
//   //                               //   ],
//   //                               // ),
//   //                             ),
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                     SizedBox(height: 10,),
//   //                     Row(
//   //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //                       crossAxisAlignment: CrossAxisAlignment.center,
//   //                       children: [
//   //                         Expanded(
//   //                           child: InkWell(
//   //                             onTap:(){
//   //                               if(hiringList.contains('HR Round')){
//   //                                 hiringList.remove('HR Round');
//   //                               }
//   //                               else{
//   //                                 hiringList.add('HR Round');
//   //                               }
//   //                               setState(() {
//   //
//   //                               });
//   //                             },
//   //                             child: Container(
//   //                               child:Row(
//   //                                 children: [
//   //                                   Container(
//   //                                     height:20,
//   //                                     width: 20,
//   //                                     padding: EdgeInsets.all(3),
//   //                                     decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(100),
//   //                                         border: Border.all(color: hiringList.contains('HR Round') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//   //                                     ),
//   //                                     child: Container(
//   //                                       decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(100),
//   //                                         color: hiringList.contains('HR Round') ? CustomColors.primaryColor : Colors.transparent,
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                   SizedBox(width: 10,),
//   //                                   Text("HR Round",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//   //                                 ],
//   //                               ),
//   //                               // Row(
//   //                               //   children: [
//   //                               //     Container(
//   //                               //       height: 20,
//   //                               //       width: 20,
//   //                               //      // padding: EdgeInsets.all(3),
//   //                               //       alignment: Alignment.center,
//   //                               //       decoration: BoxDecoration(
//   //                               //           border: Border.all(color: primaryColor)
//   //                               //       ),
//   //                               //       child:hiringList.contains('HR Round') ?  Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//   //                               //     ),
//   //                               //     SizedBox(width: 10,),
//   //                               //     Text("HR Round"),
//   //                               //   ],
//   //                               // ),
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         Expanded(
//   //                           child: InkWell(
//   //                             onTap: (){
//   //                               if(hiringList.contains('Group Discussion')){
//   //                                 hiringList.remove('Group Discussion');
//   //                               }
//   //                               else{
//   //                                 hiringList.add('Group Discussion');
//   //                               }
//   //                               setState(() {
//   //
//   //                               });
//   //                             },
//   //                             child: Container(
//   //                               child:Row(
//   //                                 children: [
//   //                                   Container(
//   //                                     height:20,
//   //                                     width: 20,
//   //                                     padding: EdgeInsets.all(3),
//   //                                     decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(100),
//   //                                         border: Border.all(color: hiringList.contains('Group Discussion') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//   //                                     ),
//   //                                     child: Container(
//   //                                       decoration: BoxDecoration(
//   //                                         borderRadius: BorderRadius.circular(100),
//   //                                         color: hiringList.contains('Group Discussion') ? CustomColors.primaryColor : Colors.transparent,
//   //                                       ),
//   //                                     ),
//   //                                   ),
//   //                                   SizedBox(width: 10,),
//   //                                   Text("Group Discussion",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//   //                                 ],
//   //                               ),
//   //                               // Row(
//   //                               //   children: [
//   //                               //     Container(
//   //                               //       height: 20,
//   //                               //       width: 20,
//   //                               //      // padding: EdgeInsets.all(3),
//   //                               //       alignment: Alignment.center,
//   //                               //       decoration: BoxDecoration(
//   //                               //           border: Border.all(color: primaryColor)
//   //                               //       ),
//   //                               //       child: hiringList.contains('Group Discussion') ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//   //                               //     ),
//   //                               //     SizedBox(width: 10,),
//   //                               //     Text("Group Discussion"),
//   //                               //   ],
//   //                               // ),
//   //                             ),
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //               SizedBox(height: 20,),
//   //               /// Job description
//   //               Text("Job Description",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//   //               SizedBox(height: 10,),
//   //               TextFormField(
//   //                 controller: descriptionController ,
//   //                 maxLines: 3,
//   //                 decoration: InputDecoration(
//   //                   filled: true,
//   //                     fillColor: Colors.white,
//   //                     hintText: "Job description",
//   //                     border: OutlineInputBorder(
//   //                         borderRadius: BorderRadius.circular(8)
//   //                     )
//   //                 ),
//   //               ),
//   //               SizedBox(height: 20,),
//   //               InkWell(
//   //                 onTap: ()async{
//   //                   setState(() {
//   //                     isloading = true;
//   //                   });
//   //                   // if(paymentStatus == "no"){
//   //                   //   await openPostjobDialog();
//   //                   // }
//   //                 //  else {
//   //                     if (jobType == null && selectedDesignation == null &&
//   //                         qualification == null && location == null &&
//   //                         passingYear == null && experience == null &&
//   //                         specialization == null && jobRoles == null) {
//   //                       var snackBar = SnackBar(
//   //                         content: Text('All fields are required'),
//   //                       );
//   //                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   //                      setState(() {
//   //                        isloading = false;
//   //                      });
//   //                     }
//   //                     else {
//   //                       postJob();
//   //                     }
//   //                  // }
//   //                 },
//   //                 child: Container(
//   //                   height: 45,
//   //                   alignment: Alignment.center,
//   //                   decoration: BoxDecoration(
//   //                       gradient: LinearGradient(
//   //                         colors: [
//   //                           Color(0xff2998E2),
//   //                           Color(0xff2B5FE0),
//   //                         ]
//   //                       ),
//   //                       borderRadius:
//   //                       BorderRadius.circular(6)
//   //                   ),
//   //                   child: isloading == true ? CircularProgressIndicator(color: Colors.white,) : Text("Post Job",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
//   //                 ),
//   //               ),
//   //               SizedBox(height: 20),
//   //             ],
//   //           ),
//   //         )
//   //       ],
//   //     )
//   //   );
//   // }
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: CustomColors.TransparentColor,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomAppBar(text: "Post Job",),
//             Expanded(
//               child: addJobDataModel == null ? Center(child: CircularProgressIndicator() ,) : ListView(
//                 shrinkWrap: true,
//                 physics:AlwaysScrollableScrollPhysics(),
//                 padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
//                 children: [
//                   /// job type
//                   Text("Job Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   addJobDataModel == null ? Center(child: CircularProgressIndicator(),) :   Container(
//                     height: 55,
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(left: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: DropdownButton(
//                       isExpanded: true,
//                       // Initial Value
//                       underline: Container(),
//                       value: jobType,
//                       hint: Padding(
//                         padding: EdgeInsets.only(left: 5),
//                         child: Text("Job Type"),
//                       ),
//                       // Down Arrow Icon
//                       icon:  Padding(
//                         padding: EdgeInsets.only(right: 5),
//                         child: Icon(Icons.keyboard_arrow_down),
//                       ),
//
//                       // Array list of items
//                       items: addJobDataModel!.data!.jobTypes!.map((items) {
//                         return DropdownMenuItem(
//                           value: items.name.toString(),
//                           child: Text(items.name.toString()),
//                         );
//                       }).toList(),
//                       // After selecting the desired option,it will
//                       // change button value to selected value
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           jobType = newValue!;
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   /// designation type
//                   Text("Designation",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   // Container(
//                   //   height: 55,
//                   //   alignment: Alignment.centerLeft,
//                   //   padding: EdgeInsets.only(left: 5),
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //   ),
//                   //   child: addJobDataModel == null ? Center(child: CircularProgressIndicator(),) : DropdownButton(
//                   //     isExpanded: true,
//                   //     // Initial Value
//                   //     underline: Container(),
//                   //     value: selectedDesignation,
//                   //     hint: Text("Designation"),
//                   //     // Down Arrow Icon
//                   //     icon:  Icon(Icons.keyboard_arrow_down),
//                   //
//                   //     // Array list of items
//                   //     items: addJobDataModel!.data!.designations!.map(( items) {
//                   //       return DropdownMenuItem(
//                   //         value: items.name.toString(),
//                   //         child: Text(items.name.toString()),
//                   //       );
//                   //     }).toList(),
//                   //
//                   //     onChanged: (String? newValue) {
//                   //       setState(() {
//                   //         selectedDesignation = newValue!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//                   CustomSearchableDropDown(
//                     items: addJobDataModel!.data!.designations!,
//                     label: 'Select Designation',
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     prefixIcon:  Padding(
//                       padding:  EdgeInsets.all(0.0),
//                       child: Icon(Icons.search),
//                     ),
//                     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//                     dropDownMenuItems: addJobDataModel!.data!.designations!.map((item) {
//                       return item.name;
//                     }).toList() ??[],
//                     onChanged: (value){
//                       if(value!=null)
//                       {
//                         setState(() {
//                           selectedDesignation = value.toString();
//                         });
//                         print("selected designation here ${selectedDesignation}");
//                       }
//                       else{
//                         selectedDesignation=null;
//                       }
//                     },
//                   ),
//
//                   SizedBox(height: 10,),
//                   /// Qualification
//                   Text("Qualification",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(
//                     height: 5,
//                   ),
//
//                   // Container(
//                   //   height: 55,
//                   //   alignment: Alignment.centerLeft,
//                   //   padding: EdgeInsets.only(left: 5),
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //   ),
//                   //   child: DropdownButton(
//                   //     isExpanded: true,
//                   //     // Initial Value
//                   //     underline: Container(),
//                   //     value: qualification,
//                   //     hint: Text("Qualification"),
//                   //     // Down Arrow Icon
//                   //     icon: const Icon(Icons.keyboard_arrow_down),
//                   //
//                   //     // Array list of items
//                   //     items: addJobDataModel!.data!.qualifications!.map((items) {
//                   //       return DropdownMenuItem(
//                   //         value: items.name.toString(),
//                   //         child: Text(items.name.toString()),
//                   //       );
//                   //     }).toList(),
//                   //     // After selecting the desired option,it will
//                   //     // change button value to selected value
//                   //     onChanged: (String? newValue) {
//                   //       setState(() {
//                   //         qualification = newValue!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//
//                   CustomSearchableDropDown(
//                     items: addJobDataModel!.data!.qualifications!,
//                     label: 'Select Qualification',
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     prefixIcon:  Padding(
//                       padding:  EdgeInsets.all(0.0),
//                       child: Icon(Icons.search),
//                     ),
//                     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//                     dropDownMenuItems: addJobDataModel!.data!.qualifications!.map((item) {
//                       return item.name;
//                     }).toList() ??
//                         [],
//                     onChanged: (value){
//                       if(value!=null)
//                       {
//                         setState(() {
//                           qualification = value.name.toString();
//                         });
//                         print("selected designation here ${qualification}");
//                       }
//                       else{
//                         qualification=null;
//                       }
//                     },
//                   ),
//
//                   SizedBox(height: 10,),
//
//                   /// Location
//                   Text("Location",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   // Container(
//                   //   height: 55,
//                   //   alignment: Alignment.centerLeft,
//                   //   padding: EdgeInsets.only(left: 5),
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //   ),
//                   //   child: DropdownButton(
//                   //     isExpanded: true,
//                   //     // Initial Value
//                   //     underline: Container(),
//                   //     value: location,
//                   //     hint: Text("Location"),
//                   //     // Down Arrow Icon
//                   //     icon: const Icon(Icons.keyboard_arrow_down),
//                   //
//                   //     // Array list of items
//                   //     items: addJobDataModel!.data!.locations!.map((items) {
//                   //       return DropdownMenuItem(
//                   //         value: items.name.toString(),
//                   //         child: Text(items.name.toString()),
//                   //       );
//                   //     }).toList(),
//                   //     // After selecting the desired option,it will
//                   //     // change button value to selected value
//                   //     onChanged: (String? newValue) {
//                   //       setState(() {
//                   //         location = newValue!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//
//                   CustomSearchableDropDown(
//                     items: addJobDataModel!.data!.locations!,
//                     label: 'Select Location',
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     prefixIcon:  Padding(
//                       padding:  EdgeInsets.all(0.0),
//                       child: Icon(Icons.search),
//                     ),
//                     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//                     dropDownMenuItems: addJobDataModel!.data!.locations!.map((item) {
//                       return item.name;
//                     }).toList() ??
//                         [],
//                     onChanged: (value){
//                       if(value!=null)
//                       {
//                         setState(() {
//                           location = value.name.toString();
//                         });
//                         print("selected designation here ${location}");
//                       }
//                       else{
//                         location=null;
//                       }
//                     },
//                   ),
//                   // TextFormField(
//                   //   controller: addressController ,
//                   //   decoration: InputDecoration(
//                   //       hintText: "Location",
//                   //       border: UnderlineInputBorder(
//                   //         borderSide: BorderSide(color: greyColor1)
//                   //       )
//                   //   ),
//                   // ),
//                   SizedBox(height: 20,),
//                   /// passing year
//                   Text("Passing Year",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   // Container(
//                   //   height: 55,
//                   //   alignment: Alignment.centerLeft,
//                   //   padding: EdgeInsets.only(left: 5),
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //   ),
//                   //   child: DropdownButton(
//                   //     underline: Container(),
//                   //     isExpanded: true,
//                   //     // Initial Value
//                   //     value: passingYear,
//                   //     hint: Text("Passing year"),
//                   //     // Down Arrow Icon
//                   //     icon: const Icon(Icons.keyboard_arrow_down),
//                   //
//                   //     // Array list of items
//                   //     items: addJobDataModel!.data!.years!.map((items) {
//                   //       return DropdownMenuItem(
//                   //         value: items.toString(),
//                   //         child: Text(items.toString()),
//                   //       );
//                   //     }).toList(),
//                   //     // After selecting the desired option,it will
//                   //     // change button value to selected value
//                   //     onChanged: (String? newValue) {
//                   //       setState(() {
//                   //         passingYear = newValue!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//
//                   CustomSearchableDropDown(
//                     items: addJobDataModel!.data!.years!,
//                     label: 'Select years',
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     prefixIcon:  Padding(
//                       padding:  EdgeInsets.all(0.0),
//                       child: Icon(Icons.search),
//                     ),
//                     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//                     dropDownMenuItems: addJobDataModel!.data!.years!.map((item) {
//                       return item;
//                     }).toList() ??
//                         [],
//                     onChanged: (value){
//                       if(value!=null)
//                       {
//                         setState(() {
//                           passingYear = value.name.toString();
//                         });
//                         print("selected designation here ${passingYear}");
//                       }
//                       else{
//                         passingYear=null;
//                       }
//                     },
//                   ),
//                   SizedBox(height: 10,),
//
//                   /// Experience section
//                   Text("Experience",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   // Container(
//                   //   height: 55,
//                   //   alignment: Alignment.centerLeft,
//                   //   padding: EdgeInsets.only(left: 5),
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //   ),
//                   //   child: DropdownButton(
//                   //     underline: Container(),
//                   //     isExpanded: true,
//                   //     // Initial Value
//                   //     value: experience,
//                   //     hint: Text("Experience"),
//                   //     // Down Arrow Icon
//                   //     icon: const Icon(Icons.keyboard_arrow_down),
//                   //
//                   //     // Array list of items
//                   //     items: addJobDataModel!.data!.experiences!.map(( items) {
//                   //       return DropdownMenuItem(
//                   //         value: items.name
//                   //             .toString(),
//                   //         child: Text(items.name.toString()),
//                   //       );
//                   //     }).toList(),
//                   //     // After selecting the desired option,it will
//                   //     // change button value to selected value
//                   //     onChanged: (String? newValue) {
//                   //       setState(() {
//                   //         experience = newValue!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//
//                   CustomSearchableDropDown(
//                     items: addJobDataModel!.data!.experiences!,
//                     label: 'Select experience',
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     prefixIcon:  Padding(
//                       padding:  EdgeInsets.all(0.0),
//                       child: Icon(Icons.search),
//                     ),
//                     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//                     dropDownMenuItems: addJobDataModel!.data!.experiences!.map((item) {
//                       return item.name;
//                     }).toList() ??
//                         [],
//                     onChanged: (value){
//                       if(value!=null)
//                       {
//                         setState(() {
//                           experience = value.name.toString();
//                         });
//                         print("selected designation here ${experience}");
//                       }
//                       else{
//                         experience=null;
//                       }
//                     },
//                   ),
//
//                   SizedBox(height: 10,),
//                   Text("Specialization",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   // Container(
//                   //   height: 55,
//                   //   alignment: Alignment.centerLeft,
//                   //   padding: EdgeInsets.only(left: 5),
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //   ),
//                   //   child: DropdownButton(
//                   //     isExpanded: true,
//                   //     underline: Container(),
//                   //     // Initial Value
//                   //     value: specialization,
//                   //     hint: Text("Specialization"),
//                   //     // Down Arrow Icon
//                   //     icon: const Icon(Icons.keyboard_arrow_down),
//                   //
//                   //     // Array list of items
//                   //     items: addJobDataModel!.data!.specializations!.map(( items) {
//                   //       return DropdownMenuItem(
//                   //         value: items.name
//                   //             .toString(),
//                   //         child: Text(items.name.toString()),
//                   //       );
//                   //     }).toList(),
//                   //     // After selecting the desired option,it will
//                   //     // change button value to selected value
//                   //     onChanged: (String? newValue) {
//                   //       setState(() {
//                   //         specialization = newValue!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//
//                   CustomSearchableDropDown(
//                     items: addJobDataModel!.data!.specializations!,
//                     label: 'Select specialization',
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     prefixIcon:  Padding(
//                       padding:  EdgeInsets.all(0.0),
//                       child: Icon(Icons.search),
//                     ),
//                     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//                     dropDownMenuItems: addJobDataModel!.data!.specializations!.map((item) {
//                       return item.name;
//                     }).toList() ??
//                         [],
//                     onChanged: (value){
//                       if(value!=null)
//                       {
//                         setState(() {
//                           specialization = value.name.toString();
//                         });
//                         print("selected designation here ${specialization}");
//                       }
//                       else{
//                         // specialization=null;
//                       }
//                     },
//                   ),
//
//                   SizedBox(height: 10,),
//                   /// salary type
//                   Text("Salary Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 20,),
//
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         InkWell(
//                           onTap: (){
//                             setState(() {
//                               selectedIndex = 1;
//                             });
//                           },
//                           child: Container(
//                             child:
//                             Row(
//                               children: [
//                                 Container(
//                                   height:20,
//                                   width: 20,
//                                   padding: EdgeInsets.all(3),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       border: Border.all(color: selectedIndex == 1 ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       color: selectedIndex == 1 ? CustomColors.primaryColor : Colors.transparent,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10,),
//                                 Text("Monthly",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//                               ],
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             setState(() {
//                               selectedIndex = 2;
//                             });
//                           },
//                           child: Container(
//                             child:
//                             Row(
//                               children: [
//                                 Container(
//                                   height:20,
//                                   width: 20,
//                                   padding: EdgeInsets.all(3),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       border: Border.all(color: selectedIndex == 2 ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       color: selectedIndex == 2 ? CustomColors.primaryColor : Colors.transparent,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10,),
//                                 Text("Yearly",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10,),
//                   /// Salary range
//                   Text("Salary Range",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 10,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: minController ,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                           decoration: InputDecoration(
//                               fillColor: Colors.white,
//                               filled: true,
//                               hintText: "Min Salary",
//                               border: OutlineInputBorder(
//
//                                   borderSide: BorderSide(color: CustomColors.grade1)
//                               )
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//                       Expanded(
//                         child: TextFormField(
//                           controller: maxController ,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                           decoration: InputDecoration(
//                               fillColor: Colors.white,
//                               filled: true,
//                               hintText: "Max Salary",
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: CustomColors.grade1)
//                               )
//                           ),
//                         ),
//                       ),
//                       // Expanded(
//                       //   child:  selectedIndex == 1 ?   DropdownButton(
//                       //     isExpanded: true,
//                       //     // Initial Value
//                       //     value: minSalary,
//                       //     hint: Text("Min Salary"),
//                       //     // Down Arrow Icon
//                       //     icon: const Icon(Icons.keyboard_arrow_down),
//                       //
//                       //     // Array list of items
//                       //     items: minSalaryListMonthly.map(( items) {
//                       //       return DropdownMenuItem(
//                       //         value: items
//                       //             .toString(),
//                       //         child: Text(items.toString()),
//                       //       );
//                       //     }).toList(),
//                       //     // After selecting the desired option,it will
//                       //     // change button value to selected value
//                       //     onChanged: (String? newValue) {
//                       //       setState(() {
//                       //         minSalary = newValue!;
//                       //       });
//                       //     },
//                       //   ): DropdownButton(
//                       //     isExpanded: true,
//                       //     // Initial Value
//                       //     value: maxSalary,
//                       //     hint: Text("Max Salary"),
//                       //     // Down Arrow Icon
//                       //     icon: const Icon(Icons.keyboard_arrow_down),
//                       //
//                       //     // Array list of items
//                       //     items:minSalaryListYearLy.map(( items) {
//                       //       return DropdownMenuItem(
//                       //         value: items
//                       //             .toString(),
//                       //         child: Text(items.toString()),
//                       //       );
//                       //     }).toList(),
//                       //     // After selecting the desired option,it will
//                       //     // change button value to selected value
//                       //     onChanged: (String? newValue) {
//                       //       setState(() {
//                       //         maxSalary = newValue!;
//                       //       });
//                       //     },
//                       //   ),
//                       // ),
//                       // SizedBox(width: 10,),
//                       // Expanded(
//                       //   child:   selectedIndex == 2 ? DropdownButton(
//                       //     isExpanded: true,
//                       //     // Initial Value
//                       //     value: minSalary,
//                       //     hint: Text("Min Salary"),
//                       //     // Down Arrow Icon
//                       //     icon: const Icon(Icons.keyboard_arrow_down),
//                       //
//                       //     // Array list of items
//                       //     items: maxSalaryListYearLy.map(( items) {
//                       //       return DropdownMenuItem(
//                       //         value: items
//                       //             .toString(),
//                       //         child: Text(items.toString()),
//                       //       );
//                       //     }).toList(),
//                       //     // After selecting the desired option,it will
//                       //     // change button value to selected value
//                       //     onChanged: (String? newValue) {
//                       //       setState(() {
//                       //         minSalary = newValue!;
//                       //       });
//                       //     },
//                       //   ) : DropdownButton(
//                       //     isExpanded: true,
//                       //     // Initial Value
//                       //     value: maxSalary,
//                       //     hint: Text("Max Salary"),
//                       //     // Down Arrow Icon
//                       //     icon: const Icon(Icons.keyboard_arrow_down),
//                       //
//                       //     // Array list of items
//                       //     items: maxSalaryListMonthly.map(( items) {
//                       //       return DropdownMenuItem(
//                       //         value: items
//                       //             .toString(),
//                       //         child: Text(items.toString()),
//                       //       );
//                       //     }).toList(),
//                       //     // After selecting the desired option,it will
//                       //     // change button value to selected value
//                       //     onChanged: (String? newValue) {
//                       //       setState(() {
//                       //         maxSalary = newValue!;
//                       //       });
//                       //     },
//                       //   ),
//                       // ),
//                     ],
//                   ),
//
//                   SizedBox(height: 20,),
//                   /// No of vaccancies
//                   Text("No of vacancies",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//
//                   Container(
//                     height: 55,
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(left: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: DropdownButton(
//                       isExpanded: true,
//                       // Initial Value
//                       underline: Container(),
//                       value: vaccancy,
//                       hint: Text("No of vaccancies"),
//                       // Down Arrow Icon
//                       icon: const Icon(Icons.keyboard_arrow_down),
//
//                       // Array list of items
//                       items: ['1','2','3','4','5','6','7','8','9','10'].map(( items) {
//                         return DropdownMenuItem(
//                           value: items
//                               .toString(),
//                           child: Text(items.toString()),
//                         );
//                       }).toList(),
//                       // After selecting the desired option,it will
//                       // change button value to selected value
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           vaccancy = newValue!;
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   /// job Role
//                   Text("Job Role",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   // Container(
//                   //   height: 55,
//                   //   alignment: Alignment.centerLeft,
//                   //   padding: EdgeInsets.only(left: 5),
//                   //   decoration: BoxDecoration(
//                   //       color: Colors.white,
//                   //       borderRadius: BorderRadius.circular(10)
//                   //   ),
//                   //   child: DropdownButton(
//                   //     isExpanded: true,
//                   //     // Initial Value
//                   //     underline: Container(),
//                   //     value: jobRoles,
//                   //     hint: Text("Job Role"),
//                   //     // Down Arrow Icon
//                   //     icon: const Icon(Icons.keyboard_arrow_down),
//                   //
//                   //     // Array list of items
//                   //     items: addJobDataModel!.data!.jobRoles!.map((items) {
//                   //       return DropdownMenuItem(
//                   //         value: items.name.toString(),
//                   //         child: Text(items.name.toString()),
//                   //       );
//                   //     }).toList(),
//                   //     // After selecting the desired option,it will
//                   //     // change button value to selected value
//                   //     onChanged: (String? newValue) {
//                   //       setState(() {
//                   //         jobRoles = newValue!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//
//                   CustomSearchableDropDown(
//                     items: addJobDataModel!.data!.jobRoles!,
//                     label: 'Select JobRole',
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     prefixIcon:  Padding(
//                       padding:  EdgeInsets.all(0.0),
//                       child: Icon(Icons.search),
//                     ),
//                     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
//                     dropDownMenuItems: addJobDataModel!.data!.jobRoles!.map((item) {
//                       return item.name;
//                     }).toList() ??
//                         [],
//                     onChanged: (value){
//                       if(value!=null)
//                       {
//                         setState(() {
//                           jobRoles = value.name.toString();
//                         });
//                         print("selected designation here ${jobRoles}");
//                       }
//                       else{
//                         jobRoles=null;
//                       }
//                     },
//                   ),
//
//                   SizedBox(height: 20,),
//                   /// language
//                   Text("Select Language",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 5,),
//                   languageModel == null ? SizedBox.shrink() :  Container(
//                     height: 55,
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(left: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: DropdownButton(
//                       isExpanded: true,
//                       // Initial Value
//                       underline: Container(),
//                       value: selectedLanguages,
//                       hint: Text("Select Languages"),
//                       // Down Arrow Icon
//                       icon: const Icon(Icons.keyboard_arrow_down),
//
//                       // Array list of items
//                       items: languageModel!.data!.map((items) {
//                         return DropdownMenuItem(
//                           value: items.name.toString(),
//                           child: Text(items.name.toString()),
//                         );
//                       }).toList(),
//                       // After selecting the desired option,it will
//                       // change button value to selected value
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedLanguages = newValue!;
//                         });
//                       },
//                     ),
//                   ),
//
//                   SizedBox(height: 10,),
//                   Text("Last date of application",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 15,),
//                   InkWell(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1950),
//                           //DateTime.now() - not to allow to choose before today.
//                           lastDate: DateTime(2100),
//                           builder: (context,child){
//                             return Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(
//                               primary: CustomColors.primaryColor,
//                             )), child: child!);
//                           }
//                       );
//
//                       if (pickedDate != null) {
//                         //pickedDate output format => 2021-03-10 00:00:00.000
//                         String formattedDate =
//                         DateFormat('yyyy-MM-dd').format(pickedDate);
//                         //formatted date output using intl package =>  2021-03-16
//                         setState(() {
//                           lastDateApply =
//                               formattedDate; //set output date to TextField value.
//                         });
//                       } else {}
//                     },
//                     child: Container(
//                       height: 55,
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       child: lastDateApply == null ? Text("Last date",) : Text("${lastDateApply}",),
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   /// Hiring Process
//                   Text("Hiring Process",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 10,),
//                   Container(
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 child:
//                                 InkWell(
//                                   onTap:(){
//                                     if(hiringList.contains('Face to Face')){
//                                       hiringList.remove('Face to Face');
//                                     }
//                                     else{
//                                       hiringList.add('Face to Face');
//                                     }
//                                     setState(() {
//
//                                     });
//                                   },
//                                   child:Container(
//                                     child:
//                                     Row(
//                                       children: [
//                                         Container(
//                                           height:20,
//                                           width: 20,
//                                           padding: EdgeInsets.all(3),
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(100),
//                                               border: Border.all(color: hiringList.contains('Face to Face') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//                                           ),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(100),
//                                               color: hiringList.contains('Face to Face') ? CustomColors.primaryColor : Colors.transparent,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(width: 10,),
//                                         Text("Face to Face",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//                                       ],
//                                     ),
//                                   ),
//                                   // Row(
//                                   //     children: [
//                                   //       Container(
//                                   //         height: 20,
//                                   //         width: 20,
//                                   //         //padding: EdgeInsets.all(3),
//                                   //         alignment: Alignment.center,
//                                   //         decoration: BoxDecoration(
//                                   //             border: Border.all(color: primaryColor)
//                                   //         ),
//                                   //         child: hiringList.contains('Face to Face') ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//                                   //       ),
//                                   //       SizedBox(width: 10,),
//                                   //       Text("Face to Face"),
//                                   //     ],
//                                   // ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: (){
//                                   if(hiringList.contains('Written-test')){
//                                     hiringList.remove('Written-test');
//                                   }
//                                   else{
//                                     hiringList.add('Written-test');
//                                   }
//                                   setState(() {
//
//                                   });
//                                 },
//                                 child: Container(
//                                   child:Row(
//                                     children: [
//                                       Container(
//                                         height:20,
//                                         width: 20,
//                                         padding: EdgeInsets.all(3),
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(100),
//                                             border: Border.all(color: hiringList.contains('Written-test') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//                                         ),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(100),
//                                             color: hiringList.contains('Written-test') ? CustomColors.primaryColor : Colors.transparent,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10,),
//                                       Text("Written-test",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//                                     ],
//                                   ),
//                                   // Row(
//                                   //   children: [
//                                   //     Container(
//                                   //       height: 20,
//                                   //       width: 20,
//                                   //     //  padding: EdgeInsets.all(3),
//                                   //       alignment: Alignment.center,
//                                   //       decoration: BoxDecoration(
//                                   //           border: Border.all(color: primaryColor)
//                                   //       ),
//                                   //       child:hiringList.contains('Written-test')  ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//                                   //     ),
//                                   //     SizedBox(width: 10,),
//                                   //     Text("Written-test"),
//                                   //   ],
//                                   // ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: InkWell(
//                                 onTap:(){
//                                   if(hiringList.contains('HR Round')){
//                                     hiringList.remove('HR Round');
//                                   }
//                                   else{
//                                     hiringList.add('HR Round');
//                                   }
//                                   setState(() {
//
//                                   });
//                                 },
//                                 child: Container(
//                                   child:Row(
//                                     children: [
//                                       Container(
//                                         height:20,
//                                         width: 20,
//                                         padding: EdgeInsets.all(3),
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(100),
//                                             border: Border.all(color: hiringList.contains('HR Round') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//                                         ),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(100),
//                                             color: hiringList.contains('HR Round') ? CustomColors.primaryColor : Colors.transparent,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10,),
//                                       Text("HR Round",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//                                     ],
//                                   ),
//                                   // Row(
//                                   //   children: [
//                                   //     Container(
//                                   //       height: 20,
//                                   //       width: 20,
//                                   //      // padding: EdgeInsets.all(3),
//                                   //       alignment: Alignment.center,
//                                   //       decoration: BoxDecoration(
//                                   //           border: Border.all(color: primaryColor)
//                                   //       ),
//                                   //       child:hiringList.contains('HR Round') ?  Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//                                   //     ),
//                                   //     SizedBox(width: 10,),
//                                   //     Text("HR Round"),
//                                   //   ],
//                                   // ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: (){
//                                   if(hiringList.contains('Group Discussion')){
//                                     hiringList.remove('Group Discussion');
//                                   }
//                                   else{
//                                     hiringList.add('Group Discussion');
//                                   }
//                                   setState(() {
//
//                                   });
//                                 },
//                                 child: Container(
//                                   child:Row(
//                                     children: [
//                                       Container(
//                                         height:20,
//                                         width: 20,
//                                         padding: EdgeInsets.all(3),
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(100),
//                                             border: Border.all(color: hiringList.contains('Group Discussion') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
//                                         ),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(100),
//                                             color: hiringList.contains('Group Discussion') ? CustomColors.primaryColor : Colors.transparent,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10,),
//                                       Text("Group Discussion",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
//                                     ],
//                                   ),
//                                   // Row(
//                                   //   children: [
//                                   //     Container(
//                                   //       height: 20,
//                                   //       width: 20,
//                                   //      // padding: EdgeInsets.all(3),
//                                   //       alignment: Alignment.center,
//                                   //       decoration: BoxDecoration(
//                                   //           border: Border.all(color: primaryColor)
//                                   //       ),
//                                   //       child: hiringList.contains('Group Discussion') ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
//                                   //     ),
//                                   //     SizedBox(width: 10,),
//                                   //     Text("Group Discussion"),
//                                   //   ],
//                                   // ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   /// Job description
//                   Text("Job Description",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
//                   SizedBox(height: 10,),
//                   TextFormField(
//                     controller: descriptionController ,
//                     maxLines: 3,
//                     decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: "Job description",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8)
//                         )
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   InkWell(
//                     onTap: ()async{
//                       setState(() {
//                         isloading = true;
//                       });
//                       // if(paymentStatus == "no"){
//                       //   await openPostjobDialog();
//                       // }
//                       //  else {
//                       if (jobType == null && selectedDesignation == null &&
//                           qualification == null && location == null &&
//                           passingYear == null && experience == null &&
//                           specialization == null && jobRoles == null) {
//                         var snackBar = SnackBar(
//                           content: Text('All fields are required'),
//                         );
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         setState(() {
//                           isloading = false;
//                         });
//                       }
//                       else {
//                         postJob();
//                       }
//                       // }
//                     },
//                     child: Container(
//                       height: 45,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                               colors: [
//                                 Color(0xff2998E2),
//                                 Color(0xff2B5FE0),
//                               ]
//                           ),
//                           borderRadius:
//                           BorderRadius.circular(6)
//                       ),
//                       child: isloading == true ? CircularProgressIndicator(color: Colors.white,) : Text("Post Job",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//
//                 ],
//               ),
//             )
//           ],
//         )
//     );
//   }
// }
//


import 'dart:convert';
import 'dart:math' as math;

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hiremymate/Helper/ColorClass.dart';
import 'package:hiremymate/Model/LanguageModel.dart';
import 'package:hiremymate/Model/myPlanModel.dart';
import 'package:hiremymate/RecruiterSection/recruiterDashboard.dart';
import 'package:hiremymate/buttons/CustomButton.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/AddJobDataModel.dart';
import '../Model/RecruiterProfileModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // String? selectedLanguages;
   List<dynamic> selectedLanguages = [];
  bool isloading =  false;
  List<String> hiringList = [];
  List<String> minSalaryListMonthly = [
    "10",
    "15",
    "20",
    "25",
    "35",
    "40"
  ];

  List<String> maxSalaryListMonthly = [
    "15",
    "20",
    "25",
    "30",
    "40",
  ];
  List locationList = [];
  List<String> maxSalaryListYearLy = [
    "2",
    "5",
    "10",
    "15",
    "20"
  ];
  List<String> minSalaryListYearLy = [
    "2",
    "5",
    "10",
    "15",
    "20"
  ];
  String? jobType,selectedDesignation,qualification,passingYear,experience,jobRoles,minSalary,maxSalary,vaccancy,specialization,location;
  Razorpay _razorpay = Razorpay();
  TextEditingController minController  =  TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController jobRoleController = TextEditingController();
  TextEditingController descriptionController  = TextEditingController();
  // TextEditingController vaccancyNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? lastDateApply;
  int selectedIndex = 1;
  String? planid;
  String? planAmount;
  List<dynamic> languagesList = [];
  String? userEmail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      return addJobDataFunction();
    });
    Future.delayed(Duration(milliseconds: 150),(){
      return getProfiledData();
    });
    Future.delayed(Duration(milliseconds: 150),(){
      return getLanguanages();
    });
    // Future.delayed(Duration(milliseconds: 800),(){
    //  return checkStatus();
    // });
    Future.delayed(Duration(milliseconds: 550),(){
      return getPlans();
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  checkStatus(){
    if(paymentStatus == 'no'){
      setState(() {
        // openPostjobDialog();
        getPlans();
      });
    }
  }

  purcheasApi(String pymtid,String amount)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString("");
    var headers = {
      'Cookie': 'ci_session=b29e882d4d300ec29020d553597463396c0bdb0c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}payu_success'));
    request.fields.addAll({
      'id': '${planid}',
      'mihpayid': '${pymtid}',
      'email': 'daniel@gmail.com',
      'mode': 'Razorpay',
      'status': 'Success',
      'amount': '${amount}'
    });
    print("paramters of purchase api  ${request.fields} and ${ApiPath.baseUrl}payu_success");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult =  await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print("final jsonResponse here for payment ${jsonResponse}");
      if(jsonResponse['staus'] == 'true'){
        var snackBar = SnackBar(
          content: Text('Plan activated successfully'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          Navigator.pop(context,true);
        });
        await getProfiledData();
        // final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddJob()));
        // print("checking result here value here ${result}");
        // if(result == true){
        // var snackBar = SnackBar(
        //   content: Text('Plan activated successfully'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Navigator.pop(context);
        // await  getProfiledData();
        // getMyJobs();
        //     }
        //   if(result == null){

        //await getProfiledData();
        //  }
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


  checkOut() {
    int amount  = int.parse(planAmount.toString()) * 100;
    print("checking amount here ${amount}");
    var options = {
      'key': "rzp_test_CpvP0qcfS4CSJD",
      'amount': amount,
      'currency': 'INR',
      'name': 'HiremyMate',
      'description': '',
      // 'prefill': {'contact': userMobile, 'email': userEmail},
    };
    print("OPTIONS ===== $options");
    _razorpay.open(options);
  }
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // var userId = await MyToken.getUserID();
    var snackBar = SnackBar(
      content: Text('Payment Successfull'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //purchasePlan("$userId", planI,"${response.paymentId}");
    purcheasApi('ssdsd', planAmount.toString(),);
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("FAILURE === ${response.message}");
    // UtilityHlepar.getToast("${response.message}");
    var snackBar = SnackBar(
      content: Text('Payment Failed'),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }


  AddJobDataModel? addJobDataModel;
  addJobDataFunction()async{
    var headers = {
      'Cookie': 'ci_session=b54ea4dc21bb9562023ebd8c74e28340f129a573'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}job_post_lists'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddJobDataModel.fromJson(json.decode(finalResponse));
      setState(() {
        addJobDataModel = jsonResponse;
      });

      print("final data here ${addJobDataModel!.data!.years}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  RecruiterProfileModel? recruiterProfileModel;

  String? paymentStatus;
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
        paymentStatus = recruiterProfileModel!.data!.pay.toString();
        print("payment status here ${paymentStatus}");
        userEmail = recruiterProfileModel!.data!.email.toString();
        // checkStatus();

      });

    }
    else {
      print(response.reasonPhrase);
    }
  }

  LanguageModel? languageModel;

  getLanguanages()async{
    var headers = {
      'Cookie': 'ci_session=8b5f1079371d3dd8e3e58f25660a57224239842f'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}language_list'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResuilt = LanguageModel.fromJson(json.decode(finalResult));
      setState(() {
        languageModel = jsonResuilt;
      });
      languagesList.clear();

      for(var i=0;i<languageModel!.data!.length;i++){
        languagesList.add(languageModel!.data![i].name);
        print("Lamguagggeeeeeeee ${languageModel!.data![i].name}");
        print("select languageeeee nowwww ${selectedLanguages}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  postJob()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    String hiringData = hiringList.join(",");

    var headers = {
      'Cookie': 'ci_session=c5efed1303ab938120bcaa43daf60f005db47cbb'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}add_job'));
    request.fields.addAll({
      'user_id': '$userid',
      'job_type': '$jobType',
      'designation': '$selectedDesignation',
      'qualification': '$qualification',
      'passing_year': '$passingYear',
      'experience': '$experience',
      'salary_range':  selectedIndex == 1 ? 'monthly' :'yearly',
      'min': minController.text,
      'max': maxController.text,
      'no_of_vaccancies': '${vaccancy.toString()}',
      'job_role': '$jobRoles',
      'end_date': '$lastDateApply',
      'hiring_process': '$hiringData',
      'specialization': '$specialization',
      'location': location.toString(),
      'description': descriptionController.text,
      'language':selectedLanguages.toString(),
    });

    print("paras are here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("final response here ${jsonResponse}");
      if(jsonResponse['status'] == "true"){
         Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        // var snackBar = SnackBar(
        //   content: Text('${jsonResponse['message']}'),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Navigator.pop(context,true)
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecruiterDashboard()));
      }
      else{
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    }
    else {
      print(response.reasonPhrase);
      setState(() {
        isloading = false;
      });
    }
  }

  bool isSelected = true;

  MyPlanModel? planModel;

  getPlans()async {
    var headers = {
      'Cookie': 'ci_session=870de272991b64efd0ff1c6a3f8f9ecf1905cc7d'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}plans'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MyPlanModel.fromJson(json.decode(finalResponse));
      setState(() {
        planModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: CustomColors.TransparentColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(text: "Post Job",),
            Expanded(
              child: addJobDataModel == null ? Center(child: CircularProgressIndicator() ,) : ListView(
                shrinkWrap: true,
                physics:AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                children: [
                  /// job type
                  Text("Job Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  addJobDataModel == null ? Center(child: CircularProgressIndicator(),) :   Container(
                    height: 55,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      // Initial Value
                      underline: Container(),
                      value: jobType,
                      hint: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text("Job Type"),
                      ),
                      // Down Arrow Icon
                      icon:  Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      // Array list of items
                      items: addJobDataModel!.data!.jobTypes!.map((items) {
                        return DropdownMenuItem(
                          value: items.name.toString(),
                          child: Text(items.name.toString()),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          jobType = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  /// designation type
                  Text("Designation",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  CustomSearchableDropDown(
                    items: addJobDataModel!.data!.designations!,
                    label: 'Select Designation',
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.all(1.0),
                      child:  Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/designation.png", scale: 1.5,)
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    dropDownMenuItems: addJobDataModel!.data!.designations!.map((item) {
                      return item.name;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          selectedDesignation = value.name.toString();
                        });
                        print("selected designation here ${selectedDesignation}");
                      }
                      else{
                        selectedDesignation=null;
                      }
                    },
                  ),

                  SizedBox(height: 10,),
                  /// Qualification
                  Text("Qualification",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 5,
                  ),

                  CustomSearchableDropDown(
                    items: addJobDataModel!.data!.qualifications!,
                    label: 'Select Qualification',
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.all(1.0),
                      child:  Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/qualifications.png", scale: 1.5, color: Colors.black87,)
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    dropDownMenuItems: addJobDataModel!.data!.qualifications!.map((item) {
                      return item.name;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          qualification = value.name.toString();
                        });
                        print("selected designation here ${qualification}");
                      }
                      else{
                        qualification=null;
                      }
                    },
                  ),

                  SizedBox(height: 10,),

                  /// Location
                  Text("Location",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  CustomSearchableDropDown(
                    items: addJobDataModel!.data!.locations!,
                    label: 'Select Location',
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.all(1.0),
                      child: Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/location.png", scale: 1.5,)
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    dropDownMenuItems: addJobDataModel!.data!.locations!.map((item) {
                      return item.name;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          location = value.name.toString();
                        });
                        print("selected designation here ${location}");
                      }
                      else{
                        location=null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  /// passing year
                  Text("Passing Year",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  CustomSearchableDropDown(
                    items: addJobDataModel!.data!.years!,
                    label: 'Select years',
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.all(1.0),
                      child:  Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/year.png", scale: 1.5,)
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    dropDownMenuItems: addJobDataModel!.data!.years!.map((item) {
                      return item;
                    }).toList() ?? [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          passingYear = value.toString();
                        });
                        print("selected passing year here ${passingYear}");
                      }
                      else{
                        passingYear = null;
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  /// Experience section
                  Text("Experience",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  CustomSearchableDropDown(
                    items: addJobDataModel!.data!.experiences!,
                    label: 'Select experience',
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.all(1.0),
                      child:  Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/experiance.png", scale: 1.5, color: Colors.black87,)
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    dropDownMenuItems: addJobDataModel!.data!.experiences!.map((item) {
                      return item.name;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          experience = value.name.toString();
                        });
                        print("selected designation here ${experience}");
                      }
                      else{
                        experience= null;
                      }
                    },
                  ),

                  SizedBox(height: 10,),
                  Text("Specialization",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  CustomSearchableDropDown(
                    items: addJobDataModel!.data!.specializations!,
                    label: 'Select specialization',
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.all(1.0),
                      child:  Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/specilization.png", scale: 1.5,)
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    dropDownMenuItems: addJobDataModel!.data!.specializations!.map((item) {
                      return item.name;
                    }).toList() ?? [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          specialization = value.name.toString();
                        });
                        print("selected designation here ${specialization}");
                      }
                      else{
                        // specialization=null;
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  /// salary type
                  Text("Salary Type",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 20,),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            child:
                            Row(
                              children: [
                                Container(
                                  height:20,
                                  width: 20,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: selectedIndex == 1 ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedIndex == 1 ? CustomColors.primaryColor : Colors.transparent,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text("Monthly",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          child: Container(
                            child:
                            Row(
                              children: [
                                Container(
                                  height:20,
                                  width: 20,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: selectedIndex == 2 ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedIndex == 2 ? CustomColors.primaryColor : Colors.transparent,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text("Yearly",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  /// Salary range
                  Text("Salary Range",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: minController ,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Min Salary",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.grade1)
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          controller: maxController ,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Max Salary",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.grade1)
                              )
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child:  selectedIndex == 1 ?   DropdownButton(
                      //     isExpanded: true,
                      //     // Initial Value
                      //     value: minSalary,
                      //     hint: Text("Min Salary"),
                      //     // Down Arrow Icon
                      //     icon: const Icon(Icons.keyboard_arrow_down),
                      //
                      //     // Array list of items
                      //     items: minSalaryListMonthly.map(( items) {
                      //       return DropdownMenuItem(
                      //         value: items
                      //             .toString(),
                      //         child: Text(items.toString()),
                      //       );
                      //     }).toList(),
                      //     // After selecting the desired option,it will
                      //     // change button value to selected value
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         minSalary = newValue!;
                      //       });
                      //     },
                      //   ): DropdownButton(
                      //     isExpanded: true,
                      //     // Initial Value
                      //     value: maxSalary,
                      //     hint: Text("Max Salary"),
                      //     // Down Arrow Icon
                      //     icon: const Icon(Icons.keyboard_arrow_down),
                      //
                      //     // Array list of items
                      //     items:minSalaryListYearLy.map(( items) {
                      //       return DropdownMenuItem(
                      //         value: items
                      //             .toString(),
                      //         child: Text(items.toString()),
                      //       );
                      //     }).toList(),
                      //     // After selecting the desired option,it will
                      //     // change button value to selected value
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         maxSalary = newValue!;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // SizedBox(width: 10,),
                      // Expanded(
                      //   child:   selectedIndex == 2 ? DropdownButton(
                      //     isExpanded: true,
                      //     // Initial Value
                      //     value: minSalary,
                      //     hint: Text("Min Salary"),
                      //     // Down Arrow Icon
                      //     icon: const Icon(Icons.keyboard_arrow_down),
                      //
                      //     // Array list of items
                      //     items: maxSalaryListYearLy.map(( items) {
                      //       return DropdownMenuItem(
                      //         value: items
                      //             .toString(),
                      //         child: Text(items.toString()),
                      //       );
                      //     }).toList(),
                      //     // After selecting the desired option,it will
                      //     // change button value to selected value
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         minSalary = newValue!;
                      //       });
                      //     },
                      //   ) : DropdownButton(
                      //     isExpanded: true,
                      //     // Initial Value
                      //     value: maxSalary,
                      //     hint: Text("Max Salary"),
                      //     // Down Arrow Icon
                      //     icon: const Icon(Icons.keyboard_arrow_down),
                      //
                      //     // Array list of items
                      //     items: maxSalaryListMonthly.map(( items) {
                      //       return DropdownMenuItem(
                      //         value: items
                      //             .toString(),
                      //         child: Text(items.toString()),
                      //       );
                      //     }).toList(),
                      //     // After selecting the desired option,it will
                      //     // change button value to selected value
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         maxSalary = newValue!;
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),

                  SizedBox(height: 20,),
                  /// No of vaccancies
                  Text("No of vacancies",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  Container(
                    height: 55,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      // Initial Value
                      underline: Container(),
                      value: vaccancy,
                      hint: Text("No of vaccancies"),
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: ['1','2','3','4','5','6','7','8','9','10'].map(( items) {
                        return DropdownMenuItem(
                          value: items
                              .toString(),
                          child: Text(items.toString()),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          vaccancy = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  /// job Role
                  Text("Job Role",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  CustomSearchableDropDown(
                    items: addJobDataModel!.data!.jobRoles!,
                    label: 'Select JobRole',
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    prefixIcon:  Padding(
                      padding:  EdgeInsets.all(1.0),
                      child: Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/jobrole.png", scale: 1.5,)
                      ),
                    ),
                    suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                    dropDownMenuItems: addJobDataModel!.data!.jobRoles!.map((item) {
                      return item.name;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          jobRoles = value.name.toString();
                        });
                        print("selected designation here ${jobRoles}");
                      }
                      else{
                        jobRoles=null;
                      }
                    },
                  ),

                  SizedBox(height: 20,),
                  /// language
                  Text("Select Language",style: TextStyle(color: CustomColors.lightgray,fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),

                  CustomSearchableDropDown(
                    items: languagesList,
                    label: 'Select Language',
                    multiSelectTag: 'Names',
                    decoration: BoxDecoration(
                        color: Colors.white
                      // border: Border.all(
                      //   color: CustomColors.lightgray.withOpacity(0.5),
                      // )
                    ),
                    multiSelect: true,
                    prefixIcon:  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/designation.png", scale: 1.5,)
                      ),
                    ),
                    dropDownMenuItems: languagesList.map((item) {
                      return item;
                    }).toList() ?? [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        //  setState(() {
                        selectedLanguages = jsonDecode(value);
                        // });
                      }
                      else{
                        //setState(() {
                        selectedLanguages.clear();
                        // });
                      }
                    },
                  ),
                  selectedLanguages.length == 0 ? SizedBox.shrink() : Wrap(
                    children: selectedLanguages.map((e){
                      return  Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColors.lightgray.withOpacity(0.2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${e}"),
                            const SizedBox(width: 10,),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    selectedLanguages.remove(e);
                                  });
                                },
                                child: Icon(Icons.clear,size: 20)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  // languageModel == null ? SizedBox.shrink() :  Container(
                  //   height: 55,
                  //   alignment: Alignment.centerLeft,
                  //   padding: EdgeInsets.only(left: 5),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10)
                  //   ),
                  //   child: DropdownButton(
                  //     isExpanded: true,
                  //     // Initial Value
                  //     underline: Container(),
                  //     value: selectedLanguages,
                  //     hint: Text("Select Languages"),
                  //     // Down Arrow Icon
                  //     icon: const Icon(Icons.keyboard_arrow_down),
                  //     // Array list of items
                  //     items: languageModel!.data!.map((items) {
                  //       return DropdownMenuItem(
                  //         value: items.name.toString(),
                  //         child: Text(items.name.toString()),
                  //       );
                  //     }).toList(),
                  //     // After selecting the desired option,it will
                  //     // change button value to selected value
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         selectedLanguages = newValue!;
                  //       });
                  //     },
                  //   ),
                  // ),

                  SizedBox(height: 10,),
                  Text("Last date of application",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100),
                          builder: (context,child){
                            return Theme(data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(
                              primary: CustomColors.primaryColor,
                            )), child: child!);
                          }
                      );

                      if (pickedDate != null) {
                        //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                        //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          lastDateApply =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                    child: Container(
                      height: 55,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: lastDateApply == null ? Text("Last date",) : Text("${lastDateApply}",),
                    ),
                  ),
                  SizedBox(height: 20,),
                  /// Hiring Process
                  Text("Hiring Process",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child:
                                InkWell(
                                  onTap:(){
                                    if(hiringList.contains('Face to Face')){
                                      hiringList.remove('Face to Face');
                                    }
                                    else{
                                      hiringList.add('Face to Face');
                                    }
                                    setState(() {

                                    });
                                  },
                                  child:Container(
                                    child:
                                    Row(
                                      children: [
                                        Container(
                                          height:20,
                                          width: 20,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: hiringList.contains('Face to Face') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: hiringList.contains('Face to Face') ? CustomColors.primaryColor : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text("Face to Face",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //     children: [
                                  //       Container(
                                  //         height: 20,
                                  //         width: 20,
                                  //         //padding: EdgeInsets.all(3),
                                  //         alignment: Alignment.center,
                                  //         decoration: BoxDecoration(
                                  //             border: Border.all(color: primaryColor)
                                  //         ),
                                  //         child: hiringList.contains('Face to Face') ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
                                  //       ),
                                  //       SizedBox(width: 10,),
                                  //       Text("Face to Face"),
                                  //     ],
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  if(hiringList.contains('Written-test')){
                                    hiringList.remove('Written-test');
                                  }
                                  else{
                                    hiringList.add('Written-test');
                                  }
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  child:Row(
                                    children: [
                                      Container(
                                        height:20,
                                        width: 20,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(color: hiringList.contains('Written-test') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: hiringList.contains('Written-test') ? CustomColors.primaryColor : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("Written-test",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       height: 20,
                                  //       width: 20,
                                  //     //  padding: EdgeInsets.all(3),
                                  //       alignment: Alignment.center,
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(color: primaryColor)
                                  //       ),
                                  //       child:hiringList.contains('Written-test')  ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
                                  //     ),
                                  //     SizedBox(width: 10,),
                                  //     Text("Written-test"),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap:(){
                                  if(hiringList.contains('HR Round')){
                                    hiringList.remove('HR Round');
                                  }
                                  else{
                                    hiringList.add('HR Round');
                                  }
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  child:Row(
                                    children: [
                                      Container(
                                        height:20,
                                        width: 20,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(color: hiringList.contains('HR Round') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: hiringList.contains('HR Round') ? CustomColors.primaryColor : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("HR Round",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       height: 20,
                                  //       width: 20,
                                  //      // padding: EdgeInsets.all(3),
                                  //       alignment: Alignment.center,
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(color: primaryColor)
                                  //       ),
                                  //       child:hiringList.contains('HR Round') ?  Icon(Icons.check,size: 16,) : SizedBox.shrink(),
                                  //     ),
                                  //     SizedBox(width: 10,),
                                  //     Text("HR Round"),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  if(hiringList.contains('Group Discussion')){
                                    hiringList.remove('Group Discussion');
                                  }
                                  else{
                                    hiringList.add('Group Discussion');
                                  }
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  child:Row(
                                    children: [
                                      Container(
                                        height:20,
                                        width: 20,
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(color: hiringList.contains('Group Discussion') ? CustomColors.primaryColor : CustomColors.lightgray,width: 2)
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: hiringList.contains('Group Discussion') ? CustomColors.primaryColor : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text("Group Discussion",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       height: 20,
                                  //       width: 20,
                                  //      // padding: EdgeInsets.all(3),
                                  //       alignment: Alignment.center,
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(color: primaryColor)
                                  //       ),
                                  //       child: hiringList.contains('Group Discussion') ? Icon(Icons.check,size: 16,) : SizedBox.shrink(),
                                  //     ),
                                  //     SizedBox(width: 10,),
                                  //     Text("Group Discussion"),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  /// Job description
                  Text("Job Description",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: descriptionController ,
                    maxLines: 3,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Job description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: ()async{

                      setState(() {
                        isloading = true;
                      });
                      // if(paymentStatus == "no"){
                      //   await openPostjobDialog();
                      // }
                      //  else {
                      if (jobType != null
                          && selectedDesignation != null
                          && qualification != null
                          && location != null
                          && passingYear != null
                          && experience != null
                          && specialization != null
                          && jobRoles != null
                          && selectedLanguages != null
                          && minController.text != null
                          && maxController.text != null
                          && descriptionController.text != null
                          && lastDateApply != null
                          && vaccancy.toString() != null
                          && selectedIndex != null
                          && hiringList != null) {
                        postJob();

                      }
                      else {
                        setState(() {
                          isloading = false;
                        });
                         var snackBar = const SnackBar(content: Text('All fields are required, Pls filled all the fields'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print("nnnnnnnnnnnnnnnnnnn");
                        // postJob();
                      }
                      // }
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xff2998E2),
                                Color(0xff2B5FE0),
                              ]
                          ),
                          borderRadius:
                          BorderRadius.circular(6)
                      ),
                      child: isloading == true ? CircularProgressIndicator(color: Colors.white,) : Text("Post Job",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                    ),
                  ),
                  SizedBox(height: 20,),

                ],
              ),
            )
          ],
        )
    );
  }
}
