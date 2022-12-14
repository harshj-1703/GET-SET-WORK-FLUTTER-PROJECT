// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_set_work/alljobsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'navbar.dart';

class UserDashboard extends StatefulWidget {
  static String userId = '';
  static String userPhoto = '';
  static String userName = '';
  static String userMobile = '';
  static String userEmail = '';
  static String userPassword = '';
  static String userState = '';
  static String userCity = '';
  static String userCountry = '';
  // static String createdAt = '';

  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    checkInternet();
    getUserDetails();

    super.initState();
  }

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      Future<void> _showMyDialog() async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('No Internet Connection'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Please Connect To The Internet!'),
                    // Text('Would you like to approve of this message?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },
        );
      }

      _showMyDialog();
    }
  }

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
          'ALL JOBS',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 25, 116),
            fontSize: 24,
            fontFamily: 'Quantum',
            letterSpacing: 1,
          ),
        ), //title of scaffold
        backgroundColor: Colors.amber,
      ),
      body: Scrollbar(
        child: StreamBuilder<List<AllJobs>>(
            stream: readWorks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                final users = snapshot.data!;

                return ListView(
                  children: users.map(buildUser).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  getUserDetails() async {
    var pref = await SharedPreferences.getInstance();
    final String? userGetId = pref.getString('userId');
    //get user by id
    var docSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userGetId)
        .get();
    Map<String, dynamic>? data = docSnapshot.data();

    setState(() {
      UserDashboard.userId = userGetId!;
      UserDashboard.userName = data?['name'];
      UserDashboard.userMobile = data?['mobile'];
      UserDashboard.userPhoto = data?['profilePhoto'];
      UserDashboard.userEmail = data?['email'];
      UserDashboard.userPassword = data?['password'];
      UserDashboard.userState = data?['state'];
      UserDashboard.userCity = data?['city'];
      UserDashboard.userCountry = data?['country'];
      // UserDashboard.createdAt = data?['createdAt'].toString();
    });
  }

  Stream<List<AllJobs>> readWorks() => FirebaseFirestore.instance
      .collection('works')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AllJobs.fromJson(doc.data())).toList());

  Widget buildUser(AllJobs job) => Container(
        padding: EdgeInsets.all(8),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Color.fromARGB(0, 219, 0, 0),
              child: CircleAvatar(
                radius: 100,
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    imageUrl: job.userProfile,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            title: Text(
              job.comapnyName,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 129),
                  fontFamily: 'Times New Roman',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1),
            ),
            subtitle: Column(
              children: [
                Divider(
                  color: Colors.greenAccent,
                ),
                Text(
                  'Work: ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 17, 0, 0),
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1),
                ),
                Text(
                  "${job.work}",
                  style: TextStyle(
                      color: Color.fromARGB(255, 173, 75, 0),
                      fontFamily: 'Times New Roman',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
                Divider(
                  color: Colors.greenAccent,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${job.dailyCharges} ~~> ${job.givenSalary}???",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontFamily: 'Times New Roman',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1),
                  ),
                ),
                Divider(
                  color: Colors.greenAccent,
                ),
                Text(
                  'Address : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 17, 0, 0),
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1),
                ),
                Text(
                  '${job.workAddress}',
                  style: TextStyle(
                      color: Color.fromARGB(255, 243, 13, 170),
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                )
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                _launchCaller(String call) async {
                  var url = "tel:$call";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                _launchCaller(job.userCall);
              },
              icon: Icon(
                Icons.call,
                color: Color.fromARGB(255, 4, 255, 0),
                size: 35,
              ),
            ),
            // onTap: () {
            //   print('hj');
            // },
            tileColor: Color.fromARGB(255, 255, 254, 202),
          ),
        ),
      );
}
