import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/screen/tabs/profilehelper.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/firebaseoperation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create Post",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.6,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black)),
                      child: ClipOval(
                        child: Provider.of<FirebaseOperation>(context,
                                        listen: false)
                                    .getinituserimage !=
                                null
                            ? CachedNetworkImage(
                                imageUrl: Provider.of<FirebaseOperation>(
                                        context,
                                        listen: false)
                                    .getinituserimage!,
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
                    child: Text(
                      Provider.of<FirebaseOperation>(context, listen: false)
                          .inituserName!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: postcontroller,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder()),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Provider.of<FirebaseOperation>(context, listen: false)
                          .pickimage()
                          .whenComplete(() {
                        Provider.of<Profilehelper>(context, listen: false)
                            .postphoto(context);
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                        ),
                        Text("Photos",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Provider.of<FirebaseOperation>(context, listen: false)
                                    .getimage ==
                                null
                            ? const SizedBox(
                                width: 0,
                                height: 0,
                              )
                            : Card(
                                child: Image.file(
                                  Provider.of<FirebaseOperation>(context,
                                          listen: false)
                                      .getimage!,
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              MaterialButton(
                  minWidth: double.infinity,
                  child: const Text("Post"),
                  color: Colors.blue,
                  onPressed: () async {
                    Provider.of<FirebaseOperation>(context, listen: false)
                        .createPost(context, postcontroller.text, {
                      "useruid":
                          Provider.of<Authinication>(context, listen: false)
                              .getuseruid,
                      "username":
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .inituserName,
                      "userimage":
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .inituserimage,
                      "posttext": postcontroller.text,
                      "postimage":
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .geturlDownload,
                      "time": Timestamp.now()
                    }).whenComplete(() {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: "Post uploaded",
                      );
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
