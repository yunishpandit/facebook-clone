import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  const Video({Key? key}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "No notifications",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
