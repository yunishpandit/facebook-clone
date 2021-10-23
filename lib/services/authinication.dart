import 'package:facebook/screen/homepage.dart';
import 'package:facebook/screen/loginpage/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authinication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String? userUid;
  String? get getuseruid => userUid;

  Future loginaccount(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      userUid = user!.uid;

      print(userUid);
      notifyListeners();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);
    }
  }

  Future createnewaccount(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      userUid = user!.uid;

      print(userUid);
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future forgetpassword(BuildContext context, String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future logout(BuildContext context) async {
    try {
      await firebaseAuth.signOut().whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      });
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
