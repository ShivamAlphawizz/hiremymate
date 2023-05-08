import 'dart:convert';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/Model/recentJobModel.dart';
import 'package:hiremymate/buttons/CustomCard.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect/multiselect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/ColorClass.dart';
import '../Model/AddJobDataModel.dart';
import '../Model/AllJobModel.dart';
import '../Service/api_path.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomButton.dart';

class SearchJob extends StatefulWidget {
  const SearchJob({Key? key}) : super(key: key);

  @override
  State<SearchJob> createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  final _formKey = GlobalKey<FormState>();

    List<String> jobTypeList = [];
    List<String> jobRoleList = [];
    List qualificationList = [];
    List <String> salaryList = [];
    List<String> locationList = [];
    List experienceList = [];
    List<String> designationList = [];

   // String? selectedJobType;

    List<dynamic> selectedJobType = [];
    List<String> selectedJobRole = [];
    List<dynamic> selectedLocation = [];
    List<dynamic> selectedDesignation = [];
    List<dynamic> selectedSalary = [];

  TextEditingController  designationController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  RecentJobModel? allJobModel;
  searchJob()async{
    String finalJobType = selectedJobType.join(",");
    String finaljobRole = selectedJobRole.join(",");
    String finalLocation = selectedLocation.join(",");
    String finalDesignation = selectedDesignation.join(",");
    final finalSalary = selectedSalary.join(",");

    var headers = {
      'Cookie': 'ci_session=9a100fa4c08088df707964d2dd73b4284498ceee'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}job_lists'));
    request.fields.addAll({
      'job_type': finalJobType,
      'location': finalLocation,
      'designation': finalDesignation,
      'qualification': finalSalary,
      'experience': '',
      'specialization': '',
    });
    print("params here ${request.fields} and ${ApiPath.baseUrl}job_lists");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("response code here ${response.statusCode}");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = RecentJobModel.fromJson(json.decode(finalResponse));
      setState(() {
        allJobModel = jsonResponse;
      });
   //  Navigator.pop(context);
     setState(() {
       selectedDesignation.clear();
       selectedLocation.clear();
       selectedJobType.clear();
       selectedSalary.clear();
     });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  removeFromSave(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');

    var headers = {
      'Cookie': 'ci_session=5a37ed79b483f5766738a21c88679dc79add7041'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}remove_fav_job'));
    request.fields.addAll({'job_id': '${id}', 'user_id': '${userid}'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if (jsonResponse['status'] == true) {
        setState(() {
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
         searchJob();
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }
  List<int> selectedItemsMultiDialogPaged = [];

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

      jobTypeList.clear();
      jobRoleList.clear();
      locationList.clear();
      designationList.clear();
      salaryList.clear();

      for(var i=0;i<addJobDataModel!.data!.jobTypes!.length;i++){
        jobTypeList.add(addJobDataModel!.data!.jobTypes![i].name.toString());
      }
      for(var i=0;i<addJobDataModel!.data!.jobRoles!.length;i++){
        jobRoleList.add(addJobDataModel!.data!.jobRoles![i].name.toString());
      }
      for(var i=0;i<addJobDataModel!.data!.locations!.length;i++){
        locationList.add(addJobDataModel!.data!.locations![i].name.toString());
      }
      for(var i=0;i<addJobDataModel!.data!.designations!.length;i++){
        designationList.add(addJobDataModel!.data!.designations![i].name.toString());
      }

      for(var i=0;i<addJobDataModel!.data!.expectations!.length;i++){
        salaryList.add(addJobDataModel!.data!.expectations![i].name.toString());
      }
        
      print("final data here ${addJobDataModel!.data!.jobRoles![0].name}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  List selectedList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return addJobDataFunction();
    });
  }
  List<int> selectedItemsMultiDialog = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: customAppBar(text: "Search Job",isTrue: true, context: context),
        backgroundColor: CustomColors.TransparentColor,
        endDrawer: endDwawer(),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     elevation: 5,
            //     child: TextFormField(
            //       controller: designationController,
            //       keyboardType: TextInputType.name,
            //       onTap: (){
            //         setState(() {
            //           _key.currentState!.openEndDrawer();
            //         });
            //       },
            //       onChanged: (v){
            //         setState(() {
            //           // searchCandidate();
            //         });
            //       },
            //       readOnly: true,
            //       decoration: InputDecoration(
            //           prefixIcon: Icon(Icons.work),
            //           hintText: 'Search here',
            //           border: InputBorder.none,
            //           contentPadding: EdgeInsets.only(left: 10,top: 15)
            //       ),
            //       // validator: (v) {
            //       //   if (v!.isEmpty) {
            //       //     return "UI/UX designer is required";
            //       //   }
            //       // },
            //     ),
            //   ),
            // ),
            // SizedBox(height: 15,),
            //
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10.0),
            //   ),
            //   elevation: 5,
            //   child: TextFormField(
            //     maxLines: 1,
            //     controller: locationController,
            //     keyboardType: TextInputType.name,
            //     onChanged: (v){
            //       setState(() {
            //         //searchCandidate();
            //       });
            //     },
            //     decoration: InputDecoration(
            //         prefixIcon: Icon(Icons.location_on_outlined),
            //         counterText: "",
            //         hintText: 'Mumbai, Maharashtra',
            //         border: InputBorder.none,
            //         contentPadding: EdgeInsets.only(left: 10,top: 15)
            //     ),
            //     // validator: (v) {
            //     //   if (v!.isEmpty) {
            //     //     return "Mobile is required";
            //     //   }
            //     // },
            //   ),
            // ),
            // SizedBox(height: 40,),
            /// search button here
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CustomAppBtn(
            //       height: 50,
            //       width: MediaQuery.of(context).size.height/4.6,
            //       title: 'SEARCH',
            //       onPress: () {
            //         searchJob();
            //         // if (_formKey.currentState!.validate()) {
            //         // } else {
            //         //   // Navigator.push(context,
            //         //   //     MaterialPageRoute(builder: (context) =>LoginScreen()));
            //         //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            //         // }
            //         // var snackBar = SnackBar(
            //         //   content: Text('All Fields are required!'),
            //         // );
            //         // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //
            //       },
            //     ),
            //     // InkWell(
            //     //   onTap: (){
            //     //    // Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportHelp()));
            //     //   },
            //     //   child: Padding(
            //     //     padding: const EdgeInsets.only(left: 5),
            //     //     child: Container(
            //     //         decoration: BoxDecoration(
            //     //             borderRadius: BorderRadius.circular(10),
            //     //             color: CustomColors.AppbarColor1
            //     //         ),
            //     //         height: 50,
            //     //         width: 50,
            //     //         child: Icon(
            //     //             Icons.menu
            //     //         )
            //     //     ),
            //     //   ),
            //     // ),
            //
            //   ],
            // ),

        allJobModel == null ?    ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10,top: 10),
                  child: Text(
                    "Job Type",
                    style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),),
                ),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: CustomSearchableDropDown(
                    items: jobTypeList,
                    hideSearch: true,
                    label: 'Select JobType',
                    multiSelectTag: 'Names',
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: CustomColors.lightgray.withOpacity(0.5),
                        // )
                      color: Colors.white
                    ),
                    multiSelect: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/drawerImages/jobtype.png", scale: 1.5,))
                    ),
                    dropDownMenuItems: jobTypeList.map((item) {
                      return item;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          selectedJobType = jsonDecode(value);
                        });
                      }
                      else{
                        selectedJobType.clear();
                      }
                    },
                  ),
                ),
                selectedJobType.length == 0 ? SizedBox() : Wrap(
                  children: selectedJobType.map((e){
                    return  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors.lightgray.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${e}"),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  selectedJobType.remove(e);
                                });
                              },
                              child: Icon(Icons.clear,size: 20))
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Location",
                            style: TextStyle(
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(2),
                        child: CustomSearchableDropDown(
                          items: locationList,
                          label: 'Select location',
                          multiSelectTag: 'Names',
                          decoration: BoxDecoration(
                              // border: Border.all(
                              //   color: CustomColors.lightgray.withOpacity(0.5),
                              // )
                              color: Colors.white
                          ),
                          multiSelect: true,
                          prefixIcon:  Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Container(
                                height: 30,
                                width: 30,
                                child: Image.asset("assets/drawerImages/location.png", scale: 1.5,))
                          ),
                          dropDownMenuItems: locationList.map((item) {
                            return item;
                          }).toList() ??
                              [],
                          onChanged: (value){
                            if(value!=null)
                            {
                            //  setState(() {
                                selectedLocation = jsonDecode(value);
                              //});
                            }
                            else{
                              //setState(() {
                                selectedLocation.clear();
                             // });
                            }
                          },
                        ),
                      ),
                      selectedLocation.length == 0 ? SizedBox.shrink() : Wrap(
                        children: selectedLocation.map((e){
                          return  Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                            height: 35,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColors.lightgray.withOpacity(0.2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${e}"),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap: (){
                                      setState(() {
                                        selectedLocation.remove(e);
                                      });
                                    },
                                    child: Icon(Icons.clear,size: 20,))
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      Divider(),

                      Text(
                        "Designation",
                        style: TextStyle(
                            color: CustomColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(height: 10,),
                      CustomSearchableDropDown(
                        items: designationList,
                        label: 'Select designation',
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
                        dropDownMenuItems: designationList.map((item) {
                          return item;
                        }).toList() ??
                            [],
                        onChanged: (value){
                          if(value!=null)
                          {
                          //  setState(() {
                              selectedDesignation = jsonDecode(value);
                            // });
                          }
                          else{
                            //setState(() {
                              selectedDesignation.clear();
                           // });
                          }
                        },
                      ),
                      selectedDesignation.length == 0 ? SizedBox.shrink() :  Wrap(
                        children: selectedDesignation.map((e){
                          return  Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                            height: 35,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColors.lightgray.withOpacity(0.2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${e}"),
                                SizedBox(width: 10,),
                                InkWell(
                                    onTap: (){
                                      setState(() {
                                        selectedDesignation.remove(e);
                                      });
                                    },
                                    child: Icon(Icons.clear,size: 20,))
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomAppBtn(
                    title: "Submit",
                    onPress: (){
                      searchJob();
                    },
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ) : SizedBox(),

            SizedBox(height: 20,),
            allJobModel == null ? SizedBox.shrink() : allJobModel!.data!.length == 0 ? Center(child:Text("No Result found"),) : ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: allJobModel!.data!.length,
                itemBuilder: (c,i){
                  return jobCard(context, i, allJobModel!,false,()async{
                    if(allJobModel!.data![i].isFav == true){
                      removeFromSave(allJobModel!.data![i].id);
                      setState(() {
                      });
                    }
                    else {
                      SharedPreferences prefs =
                      await SharedPreferences
                          .getInstance();
                      String? userid =
                      prefs.getString('USERID');
                      var headers = {
                        'Cookie':
                        'ci_session=fd2d1d81b1b1090c4e2ae73736a7eaeb94aefc9b'
                      };
                      var request = http
                          .MultipartRequest(
                          'POST',
                          Uri.parse(
                              '${ApiPath
                                  .baseUrl}save_job'));
                      request.fields.addAll({
                        'job_id':
                        '${allJobModel!.data![i]
                            .id}',
                        'user_id': '${userid}'
                      });
                      print(
                          "working paramers here ${request
                              .fields}");
                      request.headers.addAll(headers);
                      http.StreamedResponse response =
                      await request.send();
                      if (response.statusCode == 200) {
                        var finalResult = await response
                            .stream
                            .bytesToString();
                        final jsonResponse =
                        json.decode(finalResult);
                        if (jsonResponse['status'] ==
                            true) {
                          setState(() {
                            var snackBar = SnackBar(
                              content: Text(
                                  '${jsonResponse['message']}'),
                            );
                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(snackBar);
                           searchJob();
                          });
                        }
                      } else {
                        print(response.reasonPhrase);
                      }
                    }
                  });
                }),

          ],
        )
    );
  }
  endDwawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.2,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: MediaQuery.of(context).size.height / 8.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff2998E2),
                  Color(0xff2B5FE0),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // main
              children: [
                Text(
                  "Apply Filter",
                  style: TextStyle(
                      color: CustomColors.AppbarColor1,
                      fontWeight: FontWeight.normal,
                      fontSize: 25),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        selectedDesignation.clear();
                        selectedLocation.clear();
                        selectedJobType.clear();
                      });
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: CustomColors.AppbarColor1,
                    ))
              ],
            ),
          ),



          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Job Type",
          //             style: TextStyle(
          //                 color: CustomColors.primaryColor,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 18),
          //           ),
          //           // Text(
          //           //   "Reset All",
          //           //   style: TextStyle(
          //           //       color: CustomColors.secondaryColor,
          //           //       fontWeight: FontWeight.normal,
          //           //       fontSize: 18),
          //           // ),
          //         ],
          //       ),
          //       // DropdownSearch<String>.multiSelection(
          //       //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
          //       //   popupProps: PopupPropsMultiSelection.menu(
          //       //     showSelectedItems: true,
          //       //     disabledItemFn: (String s) => s.startsWith('I'),
          //       //   ),
          //       //   onChanged: (v){},
          //       //   selectedItems: ["Brazil"],
          //       // ),
          //      jobTypeList.length == 0 ? SizedBox.shrink() : DropDownMultiSelect(
          //         // selected_values_style: TextStyle(color: Colors.white),
          //         onChanged: (List<String> x) {
          //           setState(() {
          //             selectedJobType =x;
          //           });
          //         },
          //         options:jobTypeList,
          //         selectedValues: selectedJobType,
          //         whenEmpty: 'Select job Type',
          //       ),
          //       jobTypeList.length == 0 ? SizedBox.shrink() :    Wrap(
          //         children: selectedJobType.map((e){
          //           return  Container(
          //             margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
          //             height: 35,
          //             padding: EdgeInsets.symmetric(horizontal: 10),
          //             alignment: Alignment.center,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(15),
          //               color: CustomColors.lightgray.withOpacity(0.2),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Text("${e}"),
          //                 SizedBox(width: 10,),
          //                 InkWell(
          //                     onTap: (){
          //                       setState(() {
          //                         selectedJobType.remove(e);
          //                       });
          //                     },
          //                     child: Icon(Icons.clear,size: 20,))
          //               ],
          //             ),
          //           );
          //         }).toList(),
          //       ),
          //
          //       Divider(),
          //
          //       Text(
          //         "Job Role",
          //         style: TextStyle(
          //             color: CustomColors.primaryColor,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 18),
          //       ),
          //
          //       jobRoleList.length == 0 ? SizedBox.shrink() : DropDownMultiSelect(
          //         // selected_values_style: TextStyle(color: Colors.white),
          //         onChanged: (List<String> x) {
          //           setState(() {
          //             selectedJobRole =x;
          //           });
          //         },
          //         options:jobRoleList,
          //         selectedValues: selectedJobRole,
          //         whenEmpty: 'Select job role',
          //       ),
          //       jobRoleList.length == 0 ? SizedBox.shrink() :  Wrap(
          //         children: selectedJobRole.map((e){
          //           return  Container(
          //             margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
          //             height: 35,
          //             padding: EdgeInsets.symmetric(horizontal: 5),
          //             alignment: Alignment.center,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(15),
          //               color: CustomColors.lightgray.withOpacity(0.2),
          //             ),
          //             child: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Text("${e}"),
          //                 SizedBox(width: 10,),
          //                 InkWell(
          //                     onTap: (){
          //                       setState(() {
          //                         selectedJobRole.remove(e);
          //                       });
          //                     },
          //                     child: Icon(Icons.clear,size: 20,))
          //               ],
          //             ),
          //           );
          //         }).toList(),
          //       ),
          //     ],
          //   ),
          // ),

                    Padding(
                      padding: EdgeInsets.only(left: 10,top: 10),
                      child: Text(
                        "Job Type",
                        style: TextStyle(
                            color: CustomColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),),
                    ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.all(10),
            child: CustomSearchableDropDown(
              items: jobTypeList,
              label: 'Select JobType',
              multiSelectTag: 'Names',
              decoration: BoxDecoration(
                  border: Border.all(
                      color: CustomColors.lightgray.withOpacity(0.5),
                  )
              ),
              multiSelect: true,
              prefixIcon:  Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(Icons.search),
              ),
              dropDownMenuItems: jobTypeList.map((item) {
                return item;
              }).toList() ??
                  [],
              onChanged: (value){
                if(value!=null)
                {
                setState(() {
                  selectedJobType = jsonDecode(value);
                });
                }
                else{
                  selectedJobType.clear();
                }
              },
            ),
          ),
        selectedJobType.length == 0 ? SizedBox() :  Wrap(
            children: selectedJobType.map((e){
              return  Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                height: 35,
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: CustomColors.lightgray.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${e}"),
                    SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          setState(() {
                            selectedJobType.remove(e);
                          });
                        },
                        child: Icon(Icons.clear,size: 20,))
                  ],
                ),
              );
            }).toList(),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                          color: CustomColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(2),
                  child: CustomSearchableDropDown(
                    items: locationList,
                    label: 'Select location',
                    multiSelectTag: 'Names',
                    decoration: BoxDecoration(
                        border: Border.all( 
                            color: CustomColors.lightgray.withOpacity(0.5),
                        )
                    ),
                    multiSelect: true,
                    prefixIcon:  Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(Icons.search),
                    ),
                    dropDownMenuItems: locationList.map((item) {
                      return item;
                    }).toList() ??
                        [],
                    onChanged: (value){
                      if(value!=null)
                      {
                        setState(() {
                          selectedLocation = jsonDecode(value);
                        });
                      }
                      else{
                        setState(() {
                          selectedLocation.clear();
                        });
                      }
                    },
                  ),
                ),
                selectedLocation.length == 0 ? SizedBox.shrink() :    Wrap(
                  children: selectedLocation.map((e){
                    return  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors.lightgray.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${e}"),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  selectedLocation.remove(e);
                                });
                              },
                              child: Icon(Icons.clear,size: 20,))
                        ],
                      ),
                    );
                  }).toList(),
                ),

                Divider(),

                Text(
                  "Designation",
                  style: TextStyle(
                      color: CustomColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                  SizedBox(height: 10,),
                CustomSearchableDropDown(
                  items: designationList,
                  label: 'Select designation',
                  multiSelectTag: 'Names',
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: CustomColors.lightgray.withOpacity(0.5),
                      )
                  ),
                  multiSelect: true,
                  prefixIcon:  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.search),
                  ),
                  dropDownMenuItems: designationList.map((item) {
                    return item;
                  }).toList() ??
                      [],
                  onChanged: (value){
                    if(value!=null)
                    {
                     setState(() {
                       selectedDesignation = jsonDecode(value);
                     });
                    }
                    else{
                      setState(() {
                        selectedDesignation.clear();
                      });
                    }
                  },
                ),
                selectedDesignation.length == 0 ? SizedBox.shrink() :  Wrap(
                  children: selectedDesignation.map((e){
                    return  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors.lightgray.withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${e}"),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                                setState(() {
                                  selectedDesignation.remove(e);
                                });
                              },
                              child: Icon(Icons.clear,size: 20,))
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomAppBtn(
              title: "Submit",
              onPress: (){
                searchJob();
              },
              height: 45,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
