import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/services/authinication.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FirebaseOperation with ChangeNotifier {
  UploadTask? task;
  File? image;
  File? get getimage => image;
  String? urlDownload;
  String? get geturlDownload => urlDownload;
  String? inituserEmail;
  String? get getinituserEmail => inituserEmail;
  String? inituserName;
  String? get getinitusername => inituserName;
  String? inituserimage;
  String? get getinituserimage => inituserimage;
  Future pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagefile = File(image.path);
      this.image = imagefile;
    } catch (e) {
      print("fail to picked");
    }
  }

  Future uploadimage() async {
    Fluttertoast.showToast(
      msg: "Uploading image",
    );
    if (image == null) return;
    final filename = image!.path;
    final destination = 'image/$filename';
    task = FirebaseApi.uploadTask(destination, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    print(urlDownload);
    Fluttertoast.showToast(
      msg: "Image uploaded",
    );
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<Authinication>(context, listen: false).getuseruid)
        .set(data);
  }

  Future initUserdata(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of<Authinication>(context, listen: false).getuseruid)
        .get()
        .then((doc) {
      inituserName = doc.data()!["username"];
      inituserEmail = doc.data()!["useremail"];
      inituserimage = doc.data()!["userimage"];
      print(inituserName);
      print(inituserEmail);
      print(inituserimage);
      notifyListeners();
    });
  }

  Future createPost(BuildContext context, String postid, dynamic data) async {
    return FirebaseFirestore.instance.collection("posts").doc(postid).set(data);
  }
}

class FirebaseApi {
  static UploadTask? uploadTask(String destination, File image) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(image);
    } on Exception catch (e) {
      return null;
    }
  }
}
