import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFF121212), // Dark background
      body: Center(child: DarkMode3DButton()),
    ),
  ));
}

class DarkMode3DButton extends StatefulWidget {
  const DarkMode3DButton({Key? key}) : super(key: key);

  @override
  State<DarkMode3DButton> createState() => _DarkMode3DButtonState();
}

class _DarkMode3DButtonState extends State<DarkMode3DButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.black,
        title: Text("hello login",style: TextStyle(color: Colors.white),),
      ),
      body:  GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          transform: _isPressed
              ? Matrix4.translationValues(0, 3, 0) // Simulates button press depth
              : Matrix4.translationValues(0, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A), // Button background color
            borderRadius: BorderRadius.circular(8),
            boxShadow: _isPressed
                ? [ // Active state shadows
              const BoxShadow(
                color: Color(0xFF3A3A3A),
                offset: Offset(0, 1),
                blurRadius: 0,
              ),
              const BoxShadow(
                color: Color(0xFF252525),
                offset: Offset(0, 2),
                blurRadius: 0,
              ),
              const BoxShadow(
                color: Color(0xFF202020),
                offset: Offset(0, 4),
                blurRadius: 0,
              ),
              const BoxShadow(
                color: Color(0xFF1C1C1C),
                offset: Offset(0, 6),
                blurRadius: 0,
              ),
            ]
                : [ // Default state shadows
              const BoxShadow(
                color: Color(0xFF3A3A3A),
                offset: Offset(0, 1),
                blurRadius: 0,
              ),
              const BoxShadow(
                color: Color(0xFF252525),
                offset: Offset(0, 2),
                blurRadius: 0,
              ),
              const BoxShadow(
                color: Color(0xFF202020),
                offset: Offset(0, 4),
                blurRadius: 0,
              ),
              const BoxShadow(
                color: Color(0xFF1C1C1C),
                offset: Offset(0, 6),
                blurRadius: 0,
              ),
              const BoxShadow(
                color: Color(0xFF141414),
                offset: Offset(0, 7),
                blurRadius: 0,
              ),
            ],
          ),
          child: Text(
            "Login",
            style: TextStyle(
              color: const Color(0xFFE0E0E0), // Text color
              fontSize: 20,
              fontWeight: FontWeight.w600,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ) ,
    );


  }
}
