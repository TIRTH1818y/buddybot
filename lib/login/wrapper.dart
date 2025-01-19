import 'package:buddybot/login/login_&_signin.dart';
import 'package:buddybot/login/sign_Up.dart';
import 'package:buddybot/login/wel.dart';
import 'package:buddybot/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshort){
            if(snapshort.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if(snapshort.hasError){
              return Center(child: Text("error"));
            }
            else {
              if(snapshort.data == null){
                return login_signup();
              }else {
                return welcome();
              }
            }              return login_signup();
          }),
    );
  }
}
