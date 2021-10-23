import 'package:facebook/screen/loginpage/forgetpassword.dart';
import 'package:facebook/screen/loginpage/loginhelper.dart';
import 'package:facebook/screen/loginpage/signin/sigin.dart';
import 'package:facebook/services/authinication.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "facebook",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 40,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Provider.of<LoginHelper>(context, listen: false).welcome(context),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                    hintText: "Enter your email", border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: passwordcontroller,
                obscureText: isvisible,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        icon: isvisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    hintText: "Enter your password",
                    border: const OutlineInputBorder()),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Forgetpassword()));
                },
                child: const Text("Forget password?")),
            MaterialButton(
                child: const Text("Login"),
                color: Colors.blue,
                onPressed: () async {
                  Provider.of<Authinication>(context, listen: false)
                      .loginaccount(context, emailcontroller.text,
                          passwordcontroller.text)
                      .whenComplete(() {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.black, msg: "Login sucessfull");
                  });
                }),
            const Divider(
              color: Colors.black,
              thickness: 0.3,
            ),
            MaterialButton(
                child: const Text("create a account"),
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SiginPage()));
                })
          ],
        ),
      ),
    );
  }
}
