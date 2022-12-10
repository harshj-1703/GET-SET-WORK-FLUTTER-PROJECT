// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get_set_work/addjob.dart';
import 'package:get_set_work/managejob.dart';
import 'package:get_set_work/manageusers.dart';
import 'package:get_set_work/manageworkers.dart';
import 'navbar.dart';

// List<String> languages = <String>['English', 'Gujarati', 'Hindi'];

class SettingsAdmin extends StatefulWidget {
  const SettingsAdmin({super.key});

  @override
  State<SettingsAdmin> createState() => _SettingsAdminState1();
}

class _SettingsAdminState1 extends State<SettingsAdmin> {
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
          'SETTINGS ADMIN',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 25, 116),
            fontSize: 18,
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
              Container(
                color: Colors.orange,
                height: 80,
                alignment: Alignment.center,
                child: ListTile(
                  leading: Icon(
                    Icons.add_card,
                    color: Colors.pinkAccent,
                    size: 35,
                  ),
                  title: Text(
                    'MANAGE JOBS',
                    style: TextStyle(
                        fontSize: 21,
                        letterSpacing: 2,
                        fontFamily: 'Times New Roman'),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageJobs(),
                        ),
                        (route) => true);
                  },
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.center,
                child: ListTile(
                  leading: Icon(
                    Icons.emoji_people,
                    color: Colors.pinkAccent,
                    size: 35,
                  ),
                  title: Text(
                    'MANAGE WORKERS',
                    style: TextStyle(
                        fontSize: 21,
                        letterSpacing: 2,
                        fontFamily: 'Times New Roman'),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageWorkers(),
                        ),
                        (route) => true);
                  },
                ),
              ),
              Container(
                color: Colors.greenAccent,
                height: 80,
                alignment: Alignment.center,
                child: ListTile(
                  leading: Icon(
                    Icons.people,
                    color: Colors.pinkAccent,
                    size: 35,
                  ),
                  title: Text(
                    'MANAGE USERS',
                    style: TextStyle(
                        fontSize: 21,
                        letterSpacing: 2,
                        fontFamily: 'Times New Roman'),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageUsers(),
                        ),
                        (route) => true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
