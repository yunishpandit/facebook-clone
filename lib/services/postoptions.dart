import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/firebaseoperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PostOptions with ChangeNotifier {
  Future addlikes(BuildContext context, String postId, String userid) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userid)
        .set({
      "likes": FieldValue.increment(1),
      "userid": Provider.of<Authinication>(context, listen: false).getuseruid,
      "username":
          Provider.of<FirebaseOperation>(context, listen: false).inituserName,
      "useremail":
          Provider.of<FirebaseOperation>(context, listen: false).inituserEmail,
      "time": Timestamp.now(),
    });
  }

  Future createcomment(BuildContext context, String commentid, String comment,
      String userid) async {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(commentid)
        .collection("comment")
        .add({
      "comment": comment,
      "userid": Provider.of<Authinication>(context, listen: false).getuseruid,
      "username":
          Provider.of<FirebaseOperation>(context, listen: false).inituserName,
      "userimage":
          Provider.of<FirebaseOperation>(context, listen: false).inituserimage,
      "useremail":
          Provider.of<FirebaseOperation>(context, listen: false).inituserEmail,
      "time": Timestamp.now(),
    });
  }
}
