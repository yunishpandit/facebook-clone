import 'package:facebook/screen/loginpage/loginhelper.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/firebaseoperation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({Key? key}) : super(key: key);

  @override
  _SiginPageState createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Create a new account",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      child:
                          Provider.of<FirebaseOperation>(context, listen: false)
                                      .getimage ==
                                  null
                              ? Image.asset(
                                  "img/images.png",
                                  height: 100,
                                  width: 100,
                                )
                              : ClipOval(
                                  child: Image.file(
                                    Provider.of<FirebaseOperation>(context,
                                            listen: false)
                                        .getimage!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 85,
                        child: IconButton(
                            onPressed: () {
                              Provider.of<FirebaseOperation>(context,
                                      listen: false)
                                  .pickimage()
                                  .whenComplete(() {
                                Provider.of<LoginHelper>(context, listen: false)
                                    .bottombar(context);
                              });
                            },
                            icon: const Icon(Icons.camera_alt)))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Provider.of<LoginHelper>(context, listen: false)
                .textfield(context, namecontroller, "Enter your name"),
            const SizedBox(
              height: 8,
            ),
            Provider.of<LoginHelper>(context, listen: false)
                .textfield(context, emailcontroller, "Enter your email"),
            const SizedBox(
              height: 8,
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
            const SizedBox(
              height: 8,
            ),
            MaterialButton(
                child: const Text(
                  "Sigin",
                ),
                color: Colors.blue,
                onPressed: () {
                  Provider.of<Authinication>(context, listen: false)
                      .createnewaccount(context, emailcontroller.text,
                          passwordcontroller.text)
                      .whenComplete(() {
                    Provider.of<FirebaseOperation>(context, listen: false)
                        .createUserCollection(context, {
                      'userUid':
                          Provider.of<Authinication>(context, listen: false)
                              .getuseruid,
                      'username': namecontroller.text,
                      'useremail': emailcontroller.text,
                      'userimage':
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .geturlDownload
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
