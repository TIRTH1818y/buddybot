import 'package:buddybot/Widgets/drawer_item/chat_historys.dart';
import 'package:buddybot/Widgets/drawer_item/profile.dart';
import 'package:buddybot/login/wel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bot/chat_history.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {

  var email;
  var name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Buddy_users');


  Future<void> getImage() async {
    DocumentSnapshot snapshot = await usersCollection.doc().get();
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
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              maxRadius: 70,
              child: Image.asset('asset/tech.png',scale: 5,),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Email : ${user!.email}"),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 4,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded,),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (e)=>ProfilePage()));},
              title: Text("Profile"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child:
              ListTile(
                leading: IconButton(
                  onPressed: (()=>signout()) ,
                  icon: Icon(
                    Icons.logout_outlined,
                    size: 30,color: Colors.red,
                  ),
                ),
                title: Text("Log Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
