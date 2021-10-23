import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/screen/fullscreen.dart';
import 'package:facebook/screen/utiles/comment.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/postoptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Altprofile/altprofile.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  navigatordetails(DocumentSnapshot post) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Comment(post: post)));
  }

  navigatorfullscreen(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Fullscreen(post: post)));
  }

  TextEditingController controller = TextEditingController();
  String _issearch = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 10),
              child: Card(
                elevation: 13,
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    setState(() {
                      _issearch = value;
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      suffixIcon: IconButton(
                          onPressed: () => controller.clear(),
                          icon: Icon(Icons.clear)),
                      border: InputBorder.none,
                      hintText: "Search here"),
                ),
              ),
            ),
            if (_issearch.isEmpty)
              Center(
                  child: Text(
                "Search here",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))
            else
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .orderBy("username")
                      .startAt(["$_issearch"]).endAt(
                          ["$_issearch"]).snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      final docs = snapshots.data!.docs;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: docs.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            final data = docs[i].data();
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (data["useruid"] !=
                                              Provider.of<Authinication>(
                                                      context,
                                                      listen: false)
                                                  .getuseruid) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Altprofile(
                                                            useruid: data[
                                                                "useruid"])));
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: ClipOval(
                                            child: data["userimage"] != null
                                                ? CachedNetworkImage(
                                                    imageUrl: data["userimage"],
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
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data["username"],
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
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
                                ),
                                data["posttext"] != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          data["posttext"],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                                data["postimage"] == null
                                    ? const SizedBox(
                                        height: 0,
                                        width: 0,
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: InkWell(
                                          onTap: () {
                                            navigatorfullscreen(docs[i]);
                                          },
                                          child: CachedNetworkImage(
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            imageUrl: data["postimage"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Provider.of<PostOptions>(
                                                          context,
                                                          listen: false)
                                                      .addlikes(
                                                          context,
                                                          data["posttext"],
                                                          Provider.of<Authinication>(
                                                                  context,
                                                                  listen: false)
                                                              .getuseruid!);
                                                },
                                                icon: const Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                )),
                                            StreamBuilder<
                                                    QuerySnapshot<
                                                        Map<String, dynamic>>>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("posts")
                                                    .doc(data["posttext"])
                                                    .collection("likes")
                                                    .snapshots(),
                                                builder: (_, snapshots) {
                                                  if (snapshots.hasData) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0),
                                                      child: Text(
                                                          snapshots
                                                              .data!.docs.length
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    );
                                                  } else {
                                                    return const Center();
                                                  }
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              navigatordetails(docs[i]);
                                            },
                                            icon: const Icon(
                                              Icons.mode_comment_outlined,
                                            ),
                                          ),
                                          StreamBuilder<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>(
                                              stream: FirebaseFirestore.instance
                                                  .collection("posts")
                                                  .doc(data["posttext"])
                                                  .collection("comment")
                                                  .snapshots(),
                                              builder: (_, snapshots) {
                                                if (snapshots.hasData) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: Text(
                                                        snapshots
                                                            .data!.docs.length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(
                                        Icons.share,
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 4,
                                ),
                              ],
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
          ],
        ),
      ),
    );
  }
}
