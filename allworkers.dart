import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/allworkersmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'navbar.dart';

class AllWorkers extends StatefulWidget {
  const AllWorkers({super.key});

  @override
  State<AllWorkers> createState() => _AllWorkersState();
}

class _AllWorkersState extends State<AllWorkers> {
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
          'ALL WORKERS',
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
        child: StreamBuilder<List<AllWorkersDetails>>(
            stream: readWorkers(),
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

  Stream<List<AllWorkersDetails>> readWorkers() => FirebaseFirestore.instance
      .collection('workingProfiles')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AllWorkersDetails.fromJson(doc.data()))
          .toList());

  Widget buildUser(AllWorkersDetails worker) => Container(
        padding: EdgeInsets.all(8),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              child: CircleAvatar(
                radius: 100,
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    imageUrl: worker.userProfile,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            title: Text(
              worker.userName,
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
                  "${worker.workType}",
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
                    "${worker.dailyCharges} ~~> ${worker.money}₹",
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
                Row(
                  children: [
                    Text(
                      'Gender : ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 0, 0),
                          fontFamily: 'Times New Roman',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1),
                    ),
                    Text(
                      '${worker.gender}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 243, 13, 170),
                          fontFamily: 'Times New Roman',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.greenAccent,
                ),
                Row(
                  children: [
                    Text(
                      'DOB : ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 17, 0, 0),
                          fontFamily: 'Times New Roman',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1),
                    ),
                    Text(
                      '${worker.dob}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 243, 13, 170),
                          fontFamily: 'Times New Roman',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ],
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

                _launchCaller(worker.userCall);
              },
              icon: Icon(
                Icons.call,
                color: Color.fromARGB(255, 4, 255, 0),
                size: 35,
              ),
            ),
            onTap: () {
              print('hj');
            },
            tileColor: Color.fromARGB(255, 255, 254, 202),
          ),
        ),
      );
}
