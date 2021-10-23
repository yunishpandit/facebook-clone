import 'package:facebook/screen/loginpage/loginhelper.dart';
import 'package:facebook/services/authinication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailcontorller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Change your password",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.3,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const Text(
                "Enter your email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Provider.of<LoginHelper>(context, listen: false)
                  .textfield(context, emailcontorller, "Enter your email"),
              MaterialButton(
                  child: const Text("Conform email"),
                  color: Colors.blue,
                  onPressed: () {
                    Provider.of<Authinication>(context, listen: false)
                        .forgetpassword(context, emailcontorller.text);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
