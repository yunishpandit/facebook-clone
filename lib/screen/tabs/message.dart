import 'dart:ui';

import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
            child: Text(
      "This feature isn't avilable",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    )));
  }
}
