import 'package:buddybot/login/wel.dart';
import 'package:buddybot/login/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../int.dart';

class login_signup extends StatefulWidget {
  const login_signup({super.key});

  @override
  State<login_signup> createState() => _login_signupState();
}

class _login_signupState extends State<login_signup> {
  bool isHide = true;
  bool isloading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkCheck().initializeInternetStatus(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    NetworkCheck().cancelSubscription();
  }

  signin() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
    NetworkCheck().initializeInternetStatus(context);
  }

  signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email.text, password: Password.text);
    Get.offAll(wrapper());
    final firestore = FirebaseFirestore.instance;
    firestore
        .collection("Buddy_users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "userid": FirebaseAuth.instance.currentUser!.uid,
      "name": username.text,
      "email": Email.text,
      "password": Password.text,
    });
  }

  login() async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleauth =
        await googleuser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool loginpage = false;
  bool signinpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  endDrawerEnableOpenDragGesture: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'asset/blue4.jpg',
              height: 900,
              fit: BoxFit.fitHeight,
            ),
            //Image.asset('asset/blue1.jpg',fit:BoxFit.cover,height: double.infinity,,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 250,
                ),
                SizedBox(
                    child: Image.asset(
                  'asset/tech.png',
                  height: 70,
                )),
                Container(
                  width: 200,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          "WELCOME TO THE BUDDYBOT ",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            offset: Offset.fromDirection(0, -3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(5, 5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black38,
                            side: BorderSide(color: Colors.white10, width: 3)),
                        onPressed: () {
                          setState(() {
                            loginpage =
                                !loginpage; // Toggle the login container
                          });
                        },
                        child: Text(
                          loginpage ? 'Login' : 'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.shade200,
                            offset: Offset.fromDirection(0, -3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(5, 5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              side: BorderSide(
                                  color: Colors.blue.shade400, width: 3)),
                          onPressed: () {
                            setState(() {
                              signinpage = !signinpage;
                            });
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: loginpage ? 0 : -800,
              // Adjust height based on visibility
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    loginpage =
                                        !loginpage; // Toggle the login container
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Text(
                                  'WELCOME BACK..!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(-4, -4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: email,
                              autofocus: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.blue),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              maxLength: 6,
                              controller: password,
                              obscureText: isHide,
                              obscuringCharacter: '●',
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHide = !isHide;
                                      });
                                    },
                                    icon: Icon(isHide
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.blue),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 250),
                            // child: TextButton(
                            //     onPressed: () {},
                            //     child: Text(
                            //       "Forgot Pasword",
                            //       style: TextStyle(color: Colors.indigo),
                            //     )),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.greenAccent, Colors.blueAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                              ),
                              onPressed: () {
                                if (email.text == "" && password.text == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Please Enter All fields",
                                    style: TextStyle(color: Colors.red),
                                  )));
                                } else if (email.text == null ||
                                    email.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                      'Please Enter Email!',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                  );
                                } else if (!email.text.contains('@')) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                      'Email must contain @',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                  );
                                } else if (password.text == null ||
                                    password.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please Enter password',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  );
                                } else if (password.text.length != 6) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Password must be 6 characters long',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  );
                                } else {
                                  try {
                                    setState(() {
                                      isloading = true;
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    String error = "check your data";
                                    setState(() {
                                      isloading = true;
                                    });
                                    switch (e.code) {
                                      case 'ERROR_INVALID_EMAIL':
                                        print(
                                            "///////////////////////////////////////////////////////Invalid Email////////////////////////////////////////////////////////// ");
                                        break;
                                      default:
                                        ('An unexpected error occurred: ${e.message}');
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(error)));
                                  }

                                  signin();
                                }
                                return null;
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: (() => login()),
                            child: Column(
                              children: [
                                Image.asset('asset/google_photo.png',
                                    height: 70),
                                Text("You Have Google Account?")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: signinpage ? 0 : -800,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    signinpage =
                                        !signinpage; // Toggle the login container
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  'Create an Account',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(-4, -4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: username,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                labelText: 'Username',
                                labelStyle: TextStyle(color: Colors.blue),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(-4, -4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: Email,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.blue),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(-4, -4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: Password,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.blue),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.greenAccent, Colors.blueAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 8,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 160, vertical: 15),
                              ),
                              onPressed: () {
                                if (Email.text == "" &&
                                    Password.text == "" &&
                                    username.text == "") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Please Enter All fields",
                                    style: TextStyle(color: Colors.red),
                                  )));
                                } else if (username.text == null ||
                                    username.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Please Enter username",
                                    style: TextStyle(color: Colors.red),
                                  )));
                                } else if (Email.text == null ||
                                    Email.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Please Enter email",
                                    style: TextStyle(color: Colors.red),
                                  )));
                                } else if (!Email.text.contains('@')) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Please Enter email",
                                    style: TextStyle(color: Colors.red),
                                  )));
                                } else if (Password.text == null ||
                                    password.toString().isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Please Enter Password",
                                    style: TextStyle(color: Colors.red),
                                  )));
                                } else if (Password.text.length != 6) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Password must be 6 characters long",
                                    style: TextStyle(color: Colors.red),
                                  )));
                                } else {
                                  signup();
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: (() => login()),
                            child: Column(
                              children: [
                                Image.asset('asset/google_photo.png',
                                    height: 70),
                                Text("Sign With Google")
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              // Handle navigation to login page
                            },
                            child: Text(
                              'Already have an account? Log In',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
