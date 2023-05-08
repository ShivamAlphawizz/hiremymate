import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremymate/Helper/ColorClass.dart';
import 'package:hiremymate/Model/chatModel.dart';
import 'package:hiremymate/Service/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../buttons/CustomAppBar.dart';

class ChatDetailScreen extends StatefulWidget {
  String? otherid, otherName;
  ChatDetailScreen({this.otherid,this.otherName});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {

  TextEditingController  chatController = TextEditingController();
  StreamController<ChatModel> _postsController = StreamController();
  String textValue = "";

  ScrollController _scrollController = ScrollController();

  String? userType;
  getSharedData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('Role');
  }

   _scrollDown() {
      if(_scrollController.hasClients){
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
  }
  Timer? timer;

  @override
  void initState() {
    _postsController =  StreamController();
    Future.delayed(Duration(milliseconds: 300),(){
      return _scrollDown();
    });
     Timer.periodic(Duration(seconds: 2), (Timer t) {

     getMessage();
     loadMessage();

   });

    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getSharedData();
    });
    // chatReference =
    //     db.collection("chats").doc(userID).collection('messages');
  }


  XFile? imageFiles;

  loadMessage() async {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    getMessage().then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  generateMessages(AsyncSnapshot<ChatModel> snapshot) {
    return snapshot.data!.data!
        .map<Widget>((doc) {
      print("check docs here ${doc}");
      if(userType =='seeker'){
        print("working seeker");
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: doc.senderType == "seeker" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: <Widget>[
                      doc.msg == "" || doc.msg == null
                          ? const SizedBox.shrink()
                          : doc.msgType == "image" ? Container(
                        height: 90,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              "${ApiPath.imageUrl}${doc.msg}", fit: BoxFit.fill,)
                        ),
                      ) : Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey, width: 1)
                        ),
                        child: Text("${doc.msg}",
                            // widget.user!.name.toString(),
                            //documentSnapshot.data['sender_name'],
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600
                            ),
                        ),
                      ),
                      //: SizedBox(height: 0,),
                    ],
                  ),
                ),
              ]
            //doc.data['sender_id']
            //     "1" != "1"
            // ? generateReceiverLayout(doc)
            // : generateSenderLayout(doc),
          ),
        );
      }
      else{
        print("working recruiter");
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: doc.senderType == "recruiter" ?
                        CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: <Widget>[
                      doc.msg == "" || doc.msg == null
                          ? const SizedBox.shrink()
                          : doc.msgType == "image" ? Container(
                        height: 90,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              "${ApiPath.imageUrl}${doc.msg}", fit: BoxFit.fill)
                        ),
                      ) : Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black54, width: 1)
                        ),
                        child: Text("${doc.msg}",
                            // widget.user!.name.toString(),
                            //documentSnapshot.data['sender_name'],
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black45,
                                fontWeight: FontWeight.bold)
                        ),
                      ),
                      //: SizedBox(height: 0,),
                    ],
                  ),
                ),
              ]
            //doc.data['sender_id']
            //     "1" != "1"
            // ? generateReceiverLayout(doc)
            // : generateSenderLayout(doc),
          ),
        );
      }
    })
        .toList();
  }
  final _formKey = GlobalKey<FormState>();

  /// send message function

  Future getMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    String? usertype = prefs.getString('Role');
    var headers = {
      'Cookie': 'ci_session=132b223a903b145b8f1056a17a0c9ef325151d5f'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}view_message'));
    request.fields.addAll({
      'user_from':userid.toString(),
      'user_to':widget.otherid.toString(),
      'sender_type': usertype.toString(),
    });
    // if(usertype == 'seeker'){
    //   print("working 1 here");
    //   request.fields.addAll({
    //     'user_from':widget.otherid.toString(),
    //     'user_to': userid.toString()
    //   });
    // }
    // else if(usertype == 'recruiter'){
    //   print("working 2 here");
    //
    //
    // }
    print("checking msg from here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      // final jsonResponse = GetChatModel.fromJson(json.decode(finalResult));
      // setState(() {
      //   getChatModel = jsonResponse;
      // });
      //return json.decode(finalResult);
        setState(() {
          print("this is trueeeeeeeeeee__________________");

        });
      return ChatModel.fromJson(json.decode(finalResult));


    }
    else {
      print(response.reasonPhrase);
    }
  }

  sendMsg(String type)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('USERID');
    String? userType = prefs.getString('Role');
    var headers = {
      'Cookie': 'ci_session=7e3c9a5792c1cc46d273b24f731e8d617cb2e408'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}send_message'));

    if(userType == "seeker"){
      request.fields.addAll({
        'user_from': 'seeker-${userid}',
        'user_to': 'recruiter-${widget.otherid}',
        'msg_type': '${type}',
        'msg':chatController.text,
        'sender_type':userType.toString()
      });
    }
    else{
      request.fields.addAll({
        'user_from': 'recruiter-${userid}',
        'user_to': 'seeker-${widget.otherid}',
        'msg_type': '${type}',
        'msg':chatController.text,
        'sender_type':userType.toString()
      });
    }
    print("paramter here for send ${request.fields}");
    imageFiles == null ? null : request.files.add(
        await http.MultipartFile.fromPath(
            'img', '${imageFiles!.path.toString()}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
      //     duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      chatController.clear();
      getMessage().then(( res)async{
        _postsController.add(res);
        return res;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  Future<Null> refreshFunction() async {
      await getMessage();

  }


  Widget _buildTextComposer() {
    return IconTheme(
        data: const IconThemeData(
          color: Color(0xffF7F7F7)
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: const Icon(
                      Icons.photo_camera,
                      color: CustomColors.grade1,
                    ),
                    onPressed: () async {
                      PickedFile? image = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                      imageFiles = XFile(image!.path);
                      print("image files here ${imageFiles!.path.toString()}");
                      if (imageFiles != null) {
                        setState(() {
                          sendMsg("image");
                          getMessage().then((res) async {
                            _postsController.add(res);
                            return res;
                          });
                          // textController.clear();
                        });
                      }
                    }),
              ),
               Flexible(
                child: Form(
               //   key: _formKey,
                  child: TextFormField(
                    controller: chatController,
                    onChanged: (String v){
                      setState(() {
                        textValue = v;
                      });
                    },
                    // onChanged: (String messageText){
                    //   setState(() {
                    //     _isWritting = messageText.length >0 ;
                    //   });
                    // },
                    decoration: InputDecoration.collapsed(hintText: "Send a message"),

                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  IconButton getDefaultSendButton() {
    return IconButton(
        icon: const Icon(Icons.send, color: Colors.yellow,),
        onPressed: () {
            setState(() {
              sendMsg('text');
              refreshFunction();
              getMessage().then((res) async {
                _postsController.add(res);
                return res;
              });
              // textValue = "";
              // textController.clear();
              FocusManager.instance.primaryFocus?.unfocus();
            });
            getMessage();


        }
    );
  }

  @override
  Widget build(BuildContext context) {
    print("scroll controller here ${_scrollController.hasClients}");
    // getMessage();
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: customAppBar(text: "${widget.otherName}",isTrue: true, context: context),
        body: RefreshIndicator(
          onRefresh: refreshFunction,
          child: Column(
            children: [
              StreamBuilder<ChatModel>(
                stream: _postsController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<ChatModel> snapshot) {
                  if (!snapshot.hasData) return  Text("No Chat");
                  return Expanded(
                    child:
                    ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      reverse: true,
                      children: generateMessages(snapshot),
                    ),
                  );
                },
              ),
               Divider(height: 1.0),
               Container(
                decoration:  BoxDecoration(color: Theme
                    .of(context)
                    .cardColor),
                child: _buildTextComposer(),
              ),
               Builder(builder: (BuildContext context) {
                return new Container(width: 0.0, height: 0.0);
              })
            ],
          ),
        ),
      ),
    );
  }
}
