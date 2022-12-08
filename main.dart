import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; //importing packages in flutter
import 'package:get_set_work/dashboard.dart';
import 'package:get_set_work/login.dart';
import 'package:get_set_work/register.dart';
import 'package:get_set_work/startscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
    title:
        'GET SET WORK', //app name shown from package name and for main title this is.
    theme: ThemeData(primarySwatch: Colors.cyan),
  )); //for run a code here class MyApp for run
}

//shortcut for stateless is stl
class MyApp extends StatelessWidget {
  //stateless widget class
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartScreen(); //return to statefullwidget of MyScreen class
  }
}

//shortcut for stateless is stf
class MyScreen extends StatefulWidget {
  MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold
      appBar: AppBar(
        //appbar for show scaffold title
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Color.fromARGB(255, 4, 245, 245), size: 32),
        title: Text(
          'GET SET WORK',
          style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'Times New Roman',
              fontWeight: FontWeight.bold),
        ), //title of scaffold
        backgroundColor: Color.fromARGB(255, 29, 69, 214),
      ),
      body: Column(
        children: [],
      ),
    );
  }

  showSnackBar(String message) {
    var SnackBarVariable = SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepOrange,
        behavior: SnackBarBehavior.floating,
        width: 300,
        duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(SnackBarVariable);
  }
}
