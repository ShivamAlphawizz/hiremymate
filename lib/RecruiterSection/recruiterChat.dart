import 'package:flutter/material.dart';

class RecruiterChatScren extends StatefulWidget {
  const RecruiterChatScren({Key? key}) : super(key: key);

  @override
  State<RecruiterChatScren> createState() => _RecruiterChatScrenState();
}

class _RecruiterChatScrenState extends State<RecruiterChatScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Recruiter Chat"),
      ),
    );
  }
}
