import 'dart:convert';
import 'dart:ui';
import 'package:buddybot/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'chat_history.dart';

void main() {
  runApp(const buddychat());
}

class buddychat extends StatelessWidget {
  const buddychat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterPythonBackend(),
    );
  }
}

class FlutterPythonBackend extends StatefulWidget {
  const FlutterPythonBackend({super.key});

  @override
  _FlutterPythonBackendState createState() => _FlutterPythonBackendState();
}

class _FlutterPythonBackendState extends State<FlutterPythonBackend> {
  final String baseUrl =
      'https://6000-idx-buddyspace-1736773471127.cluster-a3grjzek65cxex762e4mwrzl46.cloudworkstations.dev/api/data'; // Localhost URL
  final TextEditingController promptController = TextEditingController();

  // List to store chat messages
  final List<Map<String, String>> chatMessages = [];

  // ScrollController for ListView
  final ScrollController _scrollController = ScrollController();

  // Send data to the backend
  Future<void> sendData(String userMessage) async {
    setState(() {
      chatMessages.add({'sender': 'user', 'message': userMessage,});
      _scrollToBottom();
    });

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"message": userMessage}),
      );

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        setState(() {
          chatMessages.add({
            'sender': 'bot',
            'message': responseData['response'] ?? 'server busy wait...',
          });
          _scrollToBottom(); // Scroll to the bottom after adding bot's response
        });
      } else {
        setState(() {
          chatMessages.add({
            'sender': 'bot',
            'message': 'Failed to get a response.',
          });
          _scrollToBottom();
        });
      }
    } catch (error) {
      setState(() {
        print(error);
        chatMessages.add({'sender': 'bot', 'message': 'Error: $error'});
        _scrollToBottom();
      });
    }
  }

  // Function to scroll to the bottom of the ListView
  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the ScrollController when the widget is removed
    _scrollController.dispose();
    promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
   // backgroundColor: Colors.black,
      drawer: drawer(),
      appBar: AppBar(
        elevation: 5,
              title: const Text("BuddyBot", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        flexibleSpace: ClipRRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade500, Colors.black87],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatHistoryScreen(chatMessages),
                ),
              );
            },
            icon: const Icon(
              Icons.history,
              color: Colors.cyan,
            ),
            tooltip: "Chat History",
          ),
          IconButton(
            onPressed: () {
              chatMessages.clear();

              setState(() {});
            },
            icon: const Icon(
              Icons.cleaning_services,
              color: Colors.cyan,
            ),
            tooltip: "Clear Chat",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController, // Attach ScrollController
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final chat = chatMessages[index];
                  final isUser = chat['sender'] == 'user';
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient( colors: isUser
                            ? [Colors.blue.withOpacity(0.7), Colors.purple.withOpacity(0.7)]
                            : [Colors.black, Colors.black87.withOpacity(0.3)],),
                       // color: isUser ? Colors.white54 : Colors.white10,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white38,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        chat['message'] ?? '',
                        style: const TextStyle(color: Colors.cyanAccent, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: promptController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(child: Image.asset('asset/tech.png')),
                        ),
                        hintText: "Chat With AI..",
                        hintStyle: TextStyle(color: Colors.blue),
                        filled: true,
                        fillColor: Colors.blue[50],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        String userMessage = promptController.text.trim();
                        if (userMessage.isNotEmpty) {
                          sendData(userMessage);
                          promptController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.cyanAccent,
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
