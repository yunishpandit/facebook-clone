import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/screen/Altprofile/altprofile.dart';
import 'package:facebook/screen/createposts.dart';
import 'package:facebook/screen/fullscreen.dart';
import 'package:facebook/screen/utiles/comment.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/postoptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  navigatordetails(DocumentSnapshot post) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Comment(post: post)));
  }

  navigatorfullscreen(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Fullscreen(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black)),
                      child:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(Provider.of<Authinication>(context,
                                    listen: false)
                                .getuseruid)
                            .snapshots(),
                        builder: (_, snapshots) {
                          if (snapshots.hasData) {
                            return InkWell(
                              onTap: () {},
                              child: ClipOval(
                                child: snapshots.data!.get("userimage") != null
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            snapshots.data!.get("userimage"),
                                        height: 50,
                                        width: 50,
                                      )
                                    : Image.asset(
                                        "img/images.png",
                                        height: 50,
                                        width: 50,
                                      ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreatePost()));
                    },
                    child: const Text(
                      "What's on your mind",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreatePost()));
                      },
                      icon: const Icon(Icons.photo))
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                  width: 100,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.app_registration_rounded,
                        color: Colors.blue,
                      ),
                      Text(
                        "Text",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 20,
                    width: 110,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.video_call,
                          color: Colors.red,
                        ),
                        Text("video",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 100,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.pink,
                      ),
                      Text("Location",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))
                    ],
                  ),
                )
              ],
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    final docs = snapshots.data!.docs;

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: docs.length,
                        physics: const NeverScrollableScrollPhysics(),
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
                                            Provider.of<Authinication>(context,
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
                                      padding: const EdgeInsets.only(left: 8.0),
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
                                      padding: const EdgeInsets.only(left: 8.0),
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
                                      padding: const EdgeInsets.only(top: 8.0),
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
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                          errorWidget: (context, url, error) =>
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
                                              stream: FirebaseFirestore.instance
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
                                                              FontWeight.w500)),
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
                    return const Center();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
