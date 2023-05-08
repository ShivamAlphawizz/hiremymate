import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hiremymate/ScreenView/chatDetail.dart';

import '../Helper/ColorClass.dart';
import '../buttons/CustomAppBar.dart';
import '../buttons/CustomCard.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.TransparentColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(text: "Chat",),
              ListView.builder(
                 physics:  AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: chatCard.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen()));
                        },
                        child: chatUi(context,index,chatCard));
                  })
            ],
          ),
        )
    );
  }
}
