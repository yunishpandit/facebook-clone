import 'package:facebook/screen/loginpage/loginhelper.dart';
import 'package:facebook/screen/splashscreen.dart';
import 'package:facebook/screen/tabs/profilehelper.dart';
import 'package:facebook/services/authinication.dart';
import 'package:facebook/services/firebaseoperation.dart';
import 'package:facebook/services/postoptions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => PostOptions()),
        ChangeNotifierProvider(create: (_) => LoginHelper()),
        ChangeNotifierProvider(create: (_) => Authinication()),
        ChangeNotifierProvider(create: (_) => FirebaseOperation()),
        ChangeNotifierProvider(create: (_) => Profilehelper())
      ],
    );
  }
}
