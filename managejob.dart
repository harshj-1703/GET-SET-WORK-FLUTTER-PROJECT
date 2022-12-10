import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'alljobsmodel.dart';
import 'allworkersmodel.dart';
import 'navbar.dart';

class ManageJobs extends StatefulWidget {
  const ManageJobs({super.key});

  @override
  State<ManageJobs> createState() => _ManageJobsState();
}

class _ManageJobsState extends State<ManageJobs> {
  showSnackBar(String message) {
    var SnackBarVariable = SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepOrange,
        behavior: SnackBarBehavior.floating,
        width: 300,
        duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(SnackBarVariable);
  }

  AudioPlayer audioPlayer = AudioPlayer();
  String audioPath = "music/1.mp3";
  String noAudioPath = "music/2.mp3";
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
          'MANAGE JOBS',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 25, 116),
            fontSize: 19,
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
                ),
                IconButton(
                    onPressed: () async {
                      final QuerySnapshot countUsersSnap =
                          await FirebaseFirestore.instance
                              .collection('works')
                              .where('userId', isEqualTo: job.userId)
                              .get();
                      final String getId = countUsersSnap.docs.first.id;
                      await FirebaseFirestore.instance
                          .collection('works')
                          .doc(getId)
                          .delete();
                      await audioPlayer.play(AssetSource(noAudioPath));
                      showSnackBar('Worker Removed Successfully');
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      size: 30,
                      color: Colors.red,
                    ))
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
