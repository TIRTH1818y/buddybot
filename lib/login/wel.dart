import 'package:flutter/material.dart';

class welcome extends StatefulWidget {
  const welcome({super.key});

  @override
  State<welcome> createState() => _welcomeState();
}
final bgimage= Image.asset('asset/blue1.jpg',fit:BoxFit.cover,height: double.infinity,);

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(

    //  endDrawerEnableOpenDragGesture: true,
      body:bgimage
        ,
    );
  }
}
