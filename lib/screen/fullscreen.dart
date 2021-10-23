import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fullscreen extends StatefulWidget {
  final DocumentSnapshot post;

  const Fullscreen({Key? key, required this.post}) : super(key: key);

  @override
  _FullscreenState createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2, value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: widget.post["postimage"],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
