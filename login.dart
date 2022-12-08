// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/dashboard.dart';
import 'package:get_set_work/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String LoginId = '';
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                    width: 300,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 0, 206),
                      fontFamily: 'Quantum',
                      fontSize: 40),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: TextField(
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: phoneNumber,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      prefix: Text('+91 '),
                      counterText: "",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      ),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 165, 165, 165),
                          fontFamily: 'Times New Roman',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 17, 10, 10),
                // ignore: prefer_const_constructors
                child: TextField(
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.text,
                    maxLength: 15,
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 165, 165, 165),
                          fontFamily: 'Times New Roman',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )),
              ),
              Container(
                  height: 60,
                  width: 140,
                  padding: EdgeInsets.fromLTRB(10, 14, 10, 0),
                  child: ElevatedButton(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                    onPressed: () {
                      checkCredintials();
                    },
                  )),
              Row(
                // ignore: sort_child_properties_last
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Does not have account?'),
                  TextButton(
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterMobile()),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ));
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

  checkCredintials() async {
    if (phoneNumber.text.length != 10) {
      showSnackBar('Phone Number Should Be 10 Digits!');
    } else {
      // print('+91${phoneNumber.text}');
      // final userLogin = FirebaseFirestore.instance
      //     .collection('Users')
      //     .where('mobile', isEqualTo: '+91${phoneNumber.text}');

      //count the documents
      final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
          .collection('Users')
          .where('mobile', isEqualTo: '+91${phoneNumber.text}')
          .get();
      final int countUsers = countUsersSnap.docs.length;
      // print(countUsers);

      if (countUsers > 0) {
        // final getUserDetails = await FirebaseFirestore.instance
        //     .collection('Users')
        //     .where('mobile', isEqualTo: '+91${phoneNumber.text}')
        //     .snapshots();
        if (password.text.length >= 8) {
          final QuerySnapshot getUserDetails = await FirebaseFirestore.instance
              .collection('Users')
              .where('mobile', isEqualTo: '+91${phoneNumber.text}')
              .get();
          var getPassword = getUserDetails.docs.last.get('password');
          var userId = getUserDetails.docs.last.id;
          if (password.text == getPassword) {
            LoginScreen.LoginId = userId;
            var pref = await SharedPreferences.getInstance();
            pref.setString('userId', userId);
            pref.setBool('userSet', true);
            print(LoginScreen.LoginId);
            showSnackBar('Login Successfully');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => UserDashboard()),
                // ModalRoute.withName("/MainScreen")
                ((route) => false));
          } else {
            showSnackBar('Wrong Password');
          }
        } else {
          showSnackBar('Password length must be 8.');
        }
      } else {
        showSnackBar('User Not Registered');
      }
    }
  }
}
