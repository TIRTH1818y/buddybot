// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    super.key,
  });

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool modifyUsername = false;

  final usernameC = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final userid = FirebaseAuth.instance.currentUser!.uid;
  bool loading = false;
  final userData = FirebaseFirestore.instance
      .collection("Buddy_users")
      .doc(FirebaseAuth.instance.currentUser!.uid);
  var username;
  var email;


  updateProfile() async {
    try {
      setState(() {
        loading = true;
      });
      if (usernameC.text != username && modifyUsername) {
        await _firestore
            .collection("Buddy_users")
            .doc(userid)
            .update({"name": usernameC.text});
      }

      setState(() {
        loading = false;
        modifyUsername = false;
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userData.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.data!.exists == false) {
              return Center();
            }
          }
          if (snapshot.hasData) {
            final data = snapshot.data?.data() as Map<String, dynamic>;
            username = data["name"].toString();

            email = data["email"].toString();

            return Scaffold(
              appBar: AppBar(
                actions: [
                  if (modifyUsername == true)
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                modifyUsername = false;
                              });
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: VerticalDivider(),
                        ),
                        !loading
                            ? TextButton(
                                onPressed: () {
                                  updateProfile();
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                ))
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator()),
                              ),
                      ],
                    )
                ],
                title: Text(
                  "My Profile",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
              ),
              body: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      color: Colors.blue,
                      Icons.person_2_outlined,
                      size: 30,
                    ),
                    title: Text(
                      "Username",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                    subtitle: modifyUsername
                        ? TextFormField(
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            autofocus: true,
                            controller: usernameC,
                          )
                        : Text(
                            username,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                    trailing: modifyUsername
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                modifyUsername = true;
                                usernameC.text = username;
                              });
                            },
                            icon: Icon(
                              color: Colors.blue,
                              Icons.mode_edit_outline_outlined,
                              size: 30,
                            )),
                  ),
                  ListTile(
                    leading: Icon(
                      color: Colors.blue,
                      Icons.email_outlined,
                      size: 30,
                    ),
                    title: Text(
                      "Email",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                    subtitle: Text(
                      email,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center();
        });
  }
}
