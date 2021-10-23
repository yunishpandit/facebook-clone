import 'package:facebook/services/firebaseoperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginHelper with ChangeNotifier {
  welcome(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset("img/welcome.json"),
    );
  }

  textfield(
      BuildContext context, TextEditingController controller, String name) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(hintText: name, border: const OutlineInputBorder()),
      ),
    );
  }

  bottombar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
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
                        ? const FlutterLogo()
                        : ClipOval(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.file(
                              Provider.of<FirebaseOperation>(context,
                                      listen: false)
                                  .getimage!,
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                            ),
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                        color: Colors.blue,
                        child: const Text("Reselect image"),
                        onPressed: () {}),
                    MaterialButton(
                        color: Colors.blue,
                        child: const Text("Next"),
                        onPressed: () {
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .uploadimage()
                              .whenComplete(() {
                            Navigator.pop(context);
                          });
                        })
                  ],
                )
              ],
            ),
          );
        });
  }
}
