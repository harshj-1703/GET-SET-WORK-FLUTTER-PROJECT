// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/addjob.dart';
import 'package:get_set_work/addworkingprofile.dart';
import 'package:get_set_work/allworkers.dart';
import 'package:get_set_work/dashboard.dart';
import 'package:get_set_work/editprofile.dart';
import 'package:get_set_work/settings.dart';
import 'package:get_set_work/settingsAdmin.dart';
import 'package:get_set_work/updateprofilephoto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

class NavBar extends StatelessWidget {
  AudioPlayer audioPlayer = AudioPlayer();
  String audioPath = "music/1.mp3";
  String noAudioPath = "music/2.mp3";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(
                UserDashboard.userName,
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 25, 127),
                    fontSize: 20,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                UserDashboard.userMobile,
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 25, 127),
                    fontSize: 17,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              ),
              otherAccountsPictures: [
                IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                          // ModalRoute.withName("/MainScreen")
                          ((route) => route.isFirst));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 25,
                      color: Colors.black,
                    ))
              ],
              currentAccountPicture: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProfilePhoto()),
                      // ModalRoute.withName("/MainScreen")
                      ((route) => route.isFirst));
                },
                icon: CircleAvatar(
                  radius: 200,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: UserDashboard.userPhoto,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.amber,
                //   image: DecorationImage(
                //       fit: BoxFit.fill,
                //       image: AssetImage('assets/images/logo.png')),
                // ),
              )),
          ListTile(
            leading: Icon(
              Icons.add_card,
              color: Colors.pinkAccent,
            ),
            title: Text('Need Worker'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddJob(),
                  ),
                  (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_outlined,
              color: Colors.pinkAccent,
            ),
            title: Text('Add Working Profile'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddWorkingProfile(),
                  ),
                  (route) => route.isFirst);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.pinkAccent,
            ),
            title: Text('All Workers'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllWorkers(),
                  ),
                  (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.work_outline,
              color: Colors.pinkAccent,
            ),
            title: Text('All Jobs'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDashboard(),
                  ),
                  (route) => route.isFirst);
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(
          //     Icons.favorite,
          //     color: Colors.pinkAccent,
          //   ),
          //   title: Text('Favorites'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.share,
          //     color: Colors.blue,
          //   ),
          //   title: Text('Share'),
          //   onTap: () => null,
          // ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Colors.green,
            ),
            title: Text('Follow'),
            onTap: () async {
              var url = 'https://www.instagram.com/harshj_173/';
              if (await canLaunch(url)) {
                await launch(
                  url,
                  universalLinksOnly: true,
                );
              } else {
                throw 'There was a problem to open the url: $url';
              }
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text('Settings'),
            onTap: () {
              if (LoginScreen.UserType == '1') {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsAdmin(),
                    ),
                    (route) => route.isFirst);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                    (route) => route.isFirst);
              }
            },
          ),
          Divider(),
          ListTile(
            title: Text('LogOut'),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            onTap: () {
              LogOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  // ModalRoute.withName("/MainScreen")
                  ((route) => false));
            },
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              'Developed By',
              style: TextStyle(
                  color: Colors.amber, fontFamily: 'Quantum', fontSize: 15),
            ),
          ),
          Padding(
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
      ),
    );
  }

  LogOut() async {
    var pref = await SharedPreferences.getInstance();
    await audioPlayer.play(AssetSource(noAudioPath));
    pref.setBool('userSet', false);
  }
}
