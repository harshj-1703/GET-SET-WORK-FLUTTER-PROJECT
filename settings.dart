// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get_set_work/addworkingprofile.dart';
import 'navbar.dart';

// List<String> languages = <String>['English', 'Gujarati', 'Hindi'];

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // String dropdownLan = languages.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        //appbar for show scaffold title
        iconTheme:
            IconThemeData(color: Color.fromARGB(255, 0, 25, 116), size: 25),
        centerTitle: true,
        title: Text(
          'SETTINGS',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 25, 116),
            fontSize: 24,
            fontFamily: 'Quantum',
            letterSpacing: 1,
          ),
        ), //title of scaffold
        backgroundColor: Colors.amber,
      ),
      // body: Container(
      //   height: double.infinity,
      //   width: double.infinity,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              //   child: Text(
              //     'Select Language : ',
              //     style: TextStyle(
              //         color: Color.fromARGB(255, 0, 8, 71),
              //         fontSize: 21,
              //         fontFamily: 'Times New Roman',
              //         fontWeight: FontWeight.w600),
              //   ),
              // ),
              //       Container(
              //         width: 150,
              //         padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              //         child: DropdownButton<String>(
              //           isExpanded: true,
              //           value: dropdownLan,
              //           items:
              //               languages.map<DropdownMenuItem<String>>((String value) {
              //             return DropdownMenuItem<String>(
              //               value: value,
              //               child: Center(
              //                   child: Text(
              //                 value,
              //                 style: TextStyle(fontSize: 18, letterSpacing: 1.2),
              //                 textAlign: TextAlign.center,
              //               )),
              //             );
              //           }).toList(),
              //           onChanged: (String? value) {
              //             // This is called when the user selects an item.
              //             setState(() {
              //               dropdownLan = value!;
              //             });
              //           },
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
