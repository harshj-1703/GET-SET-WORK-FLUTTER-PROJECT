import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_set_work/dashboard.dart';
import 'package:get_set_work/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    nevigateToMain();
    super.initState();
  }

  nevigateToMain() async {
    await Future.delayed(Duration(milliseconds: 2500), () {});
    var pref = await SharedPreferences.getInstance();
    final bool? userSet = pref.getBool('userSet');
    if (userSet == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UserDashboard()),
          // ModalRoute.withName("/MainScreen")
          ((route) => false));
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          // ModalRoute.withName("/MainScreen")
          ((route) => false));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Image.asset('assets/images/logo.png'),
            ),
            const Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                'Developed By',
                style: TextStyle(
                    color: Colors.amber, fontFamily: 'Quantum', fontSize: 15),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'HARSH JOLAPARA',
                style: TextStyle(
                    color: Color.fromARGB(255, 5, 1, 255),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quantum'),
              ),
            ),
          ],
        ));
  }
}
