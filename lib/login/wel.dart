import 'package:flutter/material.dart';
class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  endDrawerEnableOpenDragGesture: true,
      body: Stack(
        children: [
          Image.asset('asset/rock.jpg',fit:BoxFit.cover,height: double.infinity,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                width: 200,
                height: 200,
                child:  Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    "WELCOME TO THE BUDDYBOT ",
                    style: TextStyle(color: Colors.white,fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset.fromDirection(0, -3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black54,
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
                              backgroundColor: Colors.black38),
                          onPressed: () {
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset.fromDirection(0, -2),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(5, 5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white10,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (e) => welcome()));
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
