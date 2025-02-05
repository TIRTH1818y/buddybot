import 'dart:ui';

import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        flexibleSpace: ClipRRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade700, Colors.cyanAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
        title: Text("About",style: TextStyle(color: Colors.white),),

      ),
      body: Container(
        width: double.infinity,
        color: Colors.black87,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CircleAvatar(child: Image.asset("asset/tech.png",width: 100,),maxRadius: 70,
                backgroundColor: Colors.black54,),
            ),
            SizedBox(height: 50,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 350,
                child: Row(
                  children: [
                    SizedBox(width: 50),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white38,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,left: 15),
                        child: Text(" ●  Buddy Bot is your smart AI assistant, designed to help with study-related queries and IT problem-solving. Whether you're tackling coding challenges, troubleshooting technical issues, or seeking study guidance, Buddy Bot is here to assist you anytime!",
                          style: TextStyle(color: Colors.cyanAccent,fontSize: 17),),
                      )
                      ),
                    SizedBox(width: 45,),
                    Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white38,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,),
                          child: Column(
                            children: [
                              Text(" ● DEVLOPER DETAILS :",
                                style: TextStyle(color: Colors.greenAccent,fontSize: 18),),
                            SizedBox(height: 10,),
                            Text("DEVLOPER : TIRTH SONIGARA",style: TextStyle(color: Colors.cyanAccent),),
                            Text("EMAIL : sonigaratirth@gmail.com",style: TextStyle(color: Colors.cyanAccent)),
                            Text("GitHub : TIRTH1818y",style: TextStyle(color: Colors.cyanAccent)),
                              SizedBox(height: 10,),
                              Text("● Version & Updates",style: TextStyle(color: Colors.greenAccent,fontSize: 18),),
                              SizedBox(height: 10,),
                              Text("Version : 1.0.0",style: TextStyle(color: Colors.cyanAccent)),
                              Text("Latest Update : 5 February 2025",style: TextStyle(color: Colors.cyanAccent)),
                              Text("Latest Update :Image generator, copy Text",style: TextStyle(color: Colors.cyanAccent)),
                            ],
                          ),
                        )
                    ),
                    SizedBox(width: 50,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
