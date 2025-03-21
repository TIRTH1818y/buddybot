import 'package:buddybot/Widgets/drawer_item/about.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bot/chat_history.dart';
import 'drawer_item/profile.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

bool theme = false;

class _drawerState extends State<drawer> {
  var email;
  var name;
  bool googleuser = false;

  void checkUserAuthMethod() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      for (var provider in user.providerData) {
        if (provider.providerId == 'google.com') {
          setState(() {
            googleuser = true;
          });
          print("User signed in using Google");
        } else if (provider.providerId == 'password') {
          print("User signed in using Email & Password");
        } else {
          print("User signed in using another method: ${provider.providerId}");
        }
      }
    } else {
      print("No user is signed in");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
    checkUserAuthMethod();
  }

  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Buddy_users');

  Future<void> getImage() async {
    DocumentSnapshot snapshot =
        await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snapshot.exists) {
      final Email = snapshot['email'];
      final Name = snapshot['name'];
      setState(() {
        email = Email;
        name = Name;
      });
    }
  }


  signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: theme ? Colors.white38 : Colors.black38,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "asset/blue4.jpg",
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white10,
                    maxRadius: 70,
                    child: Image.asset(
                      'asset/tech.png',
                      scale: 5,
                    ),
                  ),
                  Text(
                    "Email : ${user!.email}",
                    style: TextStyle(color: Colors.cyanAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 4,
              color: Colors.grey,
            ),
            googleuser == true
                ? Center()
                : ListTile(
                    leading: Icon(Icons.account_circle_rounded,
                        color:
                            theme ? Colors.blue.shade700 : Colors.greenAccent,
                        size: 30),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (e) => MyProfile()));
                    },
                    title: Text(
                      "profile",
                      style:
                          TextStyle(color: theme ? Colors.black : Colors.cyan),
                    ),
                  ),
            ListTile(
              leading: Icon(Icons.contact_support_outlined,
                  color: theme ?Colors.blue.shade700 : Colors.greenAccent,
                  size: 30),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (e) => about()));
              },
              title: Text(
                "About ",
                style: TextStyle(color: theme ? Colors.black : Colors.cyan),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                size: 30,
                color: Colors.red,
              ),
              onTap: (() => signout()),
              title: Text(
                "Log Out",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
