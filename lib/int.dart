import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';


bool connectedToInternet = false;
showCustomDialog(String title, String content, BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title != ""
            ? Text(
          title,
          style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
        )
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Text(
          content,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        elevation: 10,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  )),
            ],
          )
        ],
      );
    },
  );
}
class NetworkCheck {
  StreamSubscription<InternetStatus>? internetConnectionCheck;

  initializeInternetStatus(BuildContext context) {
    internetConnectionCheck = InternetConnection().onStatusChange.listen(
          (event) {
        switch (event) {
          case InternetStatus.connected:
            connectedToInternet = true;
            break;
          case InternetStatus.disconnected:
            connectedToInternet = false;
            if (context.mounted) {
              showCustomDialog(
                  "Network Error", "Please check Internet connection!", context);
            }
            break;
          default:
            connectedToInternet = false;
            break;
        }
      },
    );
  }

  cancelSubscription() {
    internetConnectionCheck?.cancel();
  }
}