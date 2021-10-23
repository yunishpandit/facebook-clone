import 'package:facebook/services/firebaseoperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profilehelper with ChangeNotifier {
  postphoto(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
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
