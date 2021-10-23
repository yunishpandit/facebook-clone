import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/screen/createposts.dart';
import 'package:facebook/screen/utiles/comment.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/postoptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Altprofile extends StatefulWidget {
  final String useruid;

  const Altprofile({Key? key, required this.useruid}) : super(key: key);

  @override
  _AltprofileState createState() => _AltprofileState();
}

class _AltprofileState extends State<Altprofile> {
  final double coverhight = 160;
  navigatordetails(DocumentSnapshot post) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Comment(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    final top = coverhight - 70;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.useruid)
                  .snapshots(),
              builder: (_, snapshots) {
                if (snapshots.hasData) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: coverhight,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                              
                              Positioned(
                                top: top,
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(130),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: ClipOval(
                                      child: snapshots.data!.get("userimage") !=
                                              null
                                          ? CachedNetworkImage(
                                              imageUrl: snapshots.data!
                                                  .get("userimage"),
                                              height: 130,
                                              width: 130,
                                            )
                                          : Image.asset(
                                              "img/images.png",
                                              height: 130,
                                              width: 130,
                                            ),
                                    ),
                                  ),
                                  
                                ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Center(
                            child: Text(
                              snapshots.data!.get("username"),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 110,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(
                                      Icons.message_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Message",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 115,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(
                                      Icons.person_add_sharp,
                                    ),
                                    Text(
                                      "Friend",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 25,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(Icons.more_horiz_outlined),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Friends",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("See all"))
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          const Center(
                            child: Text(
                              "No friends",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 4,
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: const [
                                Icon(Icons.photo),
                                Text("Photos",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 4,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          const Text("Posts",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(color: Colors.black)),
                                child: ClipOval(
                                  child: snapshots.data!.get("userimage") !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              snapshots.data!.get("userimage"),
                                          height: 40,
                                          width: 40,
                                        )
                                      : Image.asset(
                                          "img/images.png",
                                          height: 40,
                                          width: 40,
                                        ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreatePost()));
                                },
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                      child: Text("Post a status update",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15))),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.photo))
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        final data = docs[i].data();
                                        return data["useruid"] == widget.useruid
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              width: 50,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black)),
                                                              child: ClipOval(
                                                                child: data["userimage"] !=
                                                                        null
                                                                    ? CachedNetworkImage(
                                                                        imageUrl:
                                                                            data["userimage"],
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "img/images.png",
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    data[
                                                                        "username"],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  const Text(
                                                                      "1h",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Positioned(
                                                          right: 0,
                                                          top: 0,
                                                          child: IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(Icons
                                                                  .more_horiz_rounded)),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      data["posttext"],
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    data["postimage"] == null
                                                        ? const SizedBox(
                                                            height: 0,
                                                            width: 0,
                                                          )
                                                        : CachedNetworkImage(
                                                            progressIndicatorBuilder:
                                                                (context, url,
                                                                        downloadProgress) =>
                                                                    Center(
                                                              child: CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                  value: downloadProgress
                                                                      .progress),
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                            imageUrl: data[
                                                                "postimage"],
                                                            fit: BoxFit.cover,
                                                          ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Center(
                                                            child: Row(
                                                              children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Provider.of<PostOptions>(context, listen: false).addlikes(
                                                                          context,
                                                                          data[
                                                                              "posttext"],
                                                                          Provider.of<Authinication>(context, listen: false)
                                                                              .getuseruid!);
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .thumb_up_alt_outlined)),
                                                                StreamBuilder<
                                                                        QuerySnapshot<
                                                                            Map<String,
                                                                                dynamic>>>(
                                                                    stream: FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "posts")
                                                                        .doc(data[
                                                                            "posttext"])
                                                                        .collection(
                                                                            "likes")
                                                                        .snapshots(),
                                                                    builder: (_,
                                                                        snapshots) {
                                                                      if (snapshots
                                                                          .hasData) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 2.0),
                                                                          child: Text(
                                                                              snapshots.data!.docs.length.toString(),
                                                                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
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
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    navigatordetails(
                                                                        docs[
                                                                            i]);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .mode_comment_outlined)),
                                                              StreamBuilder<
                                                                      QuerySnapshot<
                                                                          Map<String,
                                                                              dynamic>>>(
                                                                  stream: FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "posts")
                                                                      .doc(data[
                                                                          "posttext"])
                                                                      .collection(
                                                                          "comment")
                                                                      .snapshots(),
                                                                  builder: (_,
                                                                      snapshots) {
                                                                    if (snapshots
                                                                        .hasData) {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 2.0),
                                                                        child: Text(
                                                                            snapshots.data!.docs.length
                                                                                .toString(),
                                                                            style:
                                                                                const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
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
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: const Icon(
                                                              Icons.share),
                                                        )
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                      thickness: 4,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(
                                                width: 0,
                                                height: 0,
                                              );
                                      });
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
