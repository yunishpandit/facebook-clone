import 'dart:io';

import 'package:facebook/screen/search.dart';
import 'package:facebook/screen/tabs/home.dart';
import 'package:facebook/screen/tabs/message.dart';
import 'package:facebook/screen/tabs/profile.dart';
import 'package:facebook/screen/tabs/video.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/firebaseoperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    Provider.of<FirebaseOperation>(context, listen: false)
        .initUserdata(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 1,
            title: const Text(
              "facebook",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.blue,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.blue,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.message),
                ),
                Tab(
                  icon: Icon(Icons.notifications),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Searchpage()));
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(300, 70, 0.0, 0.0),
                        items: [
                          PopupMenuItem(
                              child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                Text("Are you sure to logout?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Provider.of<Authinication>(
                                                            context,
                                                            listen: false)
                                                        .logout(context);
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No"))
                                            ],
                                          );
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "SignOut",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.logout)
                                    ],
                                  ))),
                          PopupMenuItem(
                              child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                Text("Are you sure to exit?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    exit(0);
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No"))
                                            ],
                                          );
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Exit"),
                                      Icon(Icons.exit_to_app)
                                    ],
                                  )))
                        ]);
                  },
                  icon: const Icon(Icons.menu)),
            ],
          ),
          body: const TabBarView(
            children: [Home(), Profile(), Message(), Video()],
          )),
    );
  }
}
