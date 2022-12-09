// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/alljobsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'navbar.dart';

class UserDashboard extends StatefulWidget {
  static String userId = '';
  static String userPhoto = '';
  static String userName = '';
  static String userMobile = '';
  // static String createdAt = '';

  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
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
              backgroundImage: NetworkImage(
                job.userProfile,
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
                    "${job.dailyCharges} ~~> ${job.givenSalary}₹",
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
