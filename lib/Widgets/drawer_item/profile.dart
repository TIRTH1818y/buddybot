import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.exists == false || !snapshot.hasData) {
            return const Center(
              child: Text("No Data Available."),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            username = data["name"].toString();
            email = data["email"].toString();

            return Scaffold(
              backgroundColor: Colors.blueGrey,
              appBar: AppBar(
                backgroundColor: Colors.blueGrey.shade700,
                title: const Text(
                  "My Profile",
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                actions: [
                  if (modifyUsername)
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              modifyUsername = false;
                            });
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                        const SizedBox(width: 10),
                        !loading
                            ? TextButton(
                          onPressed: () {
                            updateProfile();
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        )
                            : const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black87,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person_2_outlined, color: Colors.blue, size: 30),
                          const SizedBox(width: 15),
                          Expanded(
                            child: modifyUsername
                                ? TextField(
                              controller: usernameC,
                              style: const TextStyle(fontSize: 18,color: Colors.deepPurple),
                            )
                                : Text(username, style: const TextStyle(fontSize: 18,color: Colors.white)),
                          ),
                          if (!modifyUsername)
                            IconButton(
                              icon: const Icon(Icons.mode_edit_outline_outlined, color: Colors.blue),
                              onPressed: () {
                                setState(() {
                                  modifyUsername = true;
                                  usernameC.text = username;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black87,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.email_outlined, color: Colors.blue, size: 30),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(email, style: const TextStyle(fontSize: 18,color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center();
        });
  }
}