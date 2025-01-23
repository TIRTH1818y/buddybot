import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buddybot/login/wel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Widgets/button.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

final bgimage = Image.asset(
  'asset/blue6.jpg',
  fit: BoxFit.cover,
  height: double.infinity,
);

class _welcomeState extends State<welcome> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  endDrawerEnableOpenDragGesture: true,
      body:
            Padding(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Container(
                  width: 500,
                  height: 500,
                  child: Column(
                    children: [
                      Text("Welcome to BuddyBot",style: TextStyle(fontSize: 40,color: Colors.green)),
                      Text("${user!.email}",style:TextStyle(fontSize: 30,color: Colors.blueAccent),),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: (()=>signout()) , child: Icon(Icons.logout_outlined,size: 30,)),
                      Text("log out")
                    ],
                  ),
                ),
              ),
            )
      // Column(
      //   children: [
      //     Center(
      //         child: Text(
      //       "hello ${user!.email}you are in Buddy team",
      //       style: TextStyle(color: Colors.black, fontSize: 30),
      //     )),
      //     ElevatedButton(onPressed: (()=>signout()) , child: Icon(Icons.logout_outlined))
      //   ],
      //
      ,
    );
  }
}
