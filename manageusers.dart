import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/usersmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'allworkersmodel.dart';
import 'navbar.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  showSnackBar(String message) {
    var SnackBarVariable = SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepOrange,
        behavior: SnackBarBehavior.floating,
        width: 300,
        duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(SnackBarVariable);
  }

  showSnackBar1(String message) {
    var SnackBarVariable = SnackBar(
        content: Text(message),
        backgroundColor: Color.fromARGB(146, 0, 255, 30),
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
          'MANAGE USERS',
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
        child: StreamBuilder<List<AllUsers>>(
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

  Stream<List<AllUsers>> readWorks() => FirebaseFirestore.instance
      .collection('Users')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => AllUsers.fromJson(doc.data())).toList());

  Widget buildUser(AllUsers user) => Container(
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
                    imageUrl: user.userProfile,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            title: Text(
              user.name,
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
                  'Mobile : ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 17, 0, 0),
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1),
                ),
                Text(
                  '${user.mobile}',
                  style: TextStyle(
                      color: Color.fromARGB(255, 243, 13, 170),
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
                Divider(
                  color: Colors.greenAccent,
                ),
                Text(
                  'Email: ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 17, 0, 0),
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1),
                ),
                Text(
                  "${user.email}",
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
                  '${user.city}',
                  style: TextStyle(
                      color: Color.fromARGB(255, 243, 13, 170),
                      fontFamily: 'Times New Roman',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                )
              ],
            ),
            trailing: user.userType == '1'
                ? IconButton(
                    onPressed: () {
                      showSnackBar1('User Is Admin!');
                    },
                    icon: Icon(
                      Icons.admin_panel_settings,
                      color: Colors.greenAccent,
                      size: 32,
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      final QuerySnapshot countUsersSnap =
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .where('mobile', isEqualTo: user.mobile)
                              .get();
                      final String getId = countUsersSnap.docs.first.id;
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(getId)
                          .delete();
                      await audioPlayer.play(AssetSource(noAudioPath));
                      showSnackBar('User Removed Successfully');
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      size: 30,
                      color: Colors.red,
                    )),
          ),
        ),
      );
}
