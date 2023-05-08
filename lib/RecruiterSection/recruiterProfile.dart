import 'package:flutter/material.dart';

class RecruiterProfile extends StatefulWidget {
  const RecruiterProfile({Key? key}) : super(key: key);

  @override
  State<RecruiterProfile> createState() => _RecruiterProfileState();
}

class _RecruiterProfileState extends State<RecruiterProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Recruiter Profile"),
      ),
    );
  }
}
