import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/postoptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comment extends StatefulWidget {
  final DocumentSnapshot post;

  const Comment({Key? key, required this.post}) : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController commentcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "${widget.post["username"]} post's",
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.1,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black)),
                        child: ClipOval(
                          child: widget.post["userimage"] != null
                              ? CachedNetworkImage(
                                  imageUrl: widget.post["userimage"],
                                  height: 50,
                                  width: 50,
                                )
                              : Image.asset(
                                  "img/images.png",
                                  height: 50,
                                  width: 50,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post["username"],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text("1h",
                                style: TextStyle(
                                  fontSize: 12,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  widget.post["posttext"] != null
                      ? Text(
                          widget.post["posttext"],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  widget.post["postimage"] == null
                      ? const SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageUrl: widget.post["postimage"],
                            fit: BoxFit.cover,
                          ),
                        ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Center(
                                child: IconButton(
                                    onPressed: () {
                                      Provider.of<PostOptions>(context,
                                              listen: false)
                                          .addlikes(
                                              context,
                                              widget.post["posttext"],
                                              Provider.of<Authinication>(
                                                      context,
                                                      listen: false)
                                                  .getuseruid!);
                                    },
                                    icon: const Icon(
                                        Icons.thumb_up_alt_outlined)),
                              ),
                              StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance
                                      .collection("posts")
                                      .doc(widget.post["posttext"])
                                      .collection("likes")
                                      .snapshots(),
                                  builder: (_, snapshots) {
                                    if (snapshots.hasData) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0),
                                        child: Text(
                                            snapshots.data!.docs.length
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      );
                                    } else {
                                      return const Center();
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mode_comment_outlined,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.share,
                          ),
                        )
                      ]),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .doc(widget.post["posttext"])
                          .collection("comment")
                          .snapshots(),
                      builder: (_, snapshots) {
                        if (snapshots.hasData) {
                          final docs = snapshots.data!.docs;
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: docs.length,
                              shrinkWrap: true,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                return Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: ClipOval(
                                        child: data["userimage"] != null
                                            ? CachedNetworkImage(
                                                imageUrl: data["userimage"],
                                                height: 30,
                                                width: 30,
                                              )
                                            : Image.asset(
                                                "img/images.png",
                                                height: 50,
                                                width: 50,
                                              ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data["username"],
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    data["comment"],
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            children: const [
                                              Text("1h"),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text("Like")
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return Center(
                              child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                          ));
                        }
                      }),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                  controller: commentcontroller,
                  maxLines: 1,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "write a public comment",
                      suffixIcon: IconButton(
                          onPressed: () {
                            Provider.of<PostOptions>(context, listen: false)
                                .createcomment(
                                    context,
                                    widget.post["posttext"],
                                    commentcontroller.text,
                                    Provider.of<Authinication>(context,
                                            listen: false)
                                        .getuseruid!)
                                .whenComplete(() {
                              commentcontroller.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          )))),
            ),
          ),
        ],
      ),
    );
  }
}
