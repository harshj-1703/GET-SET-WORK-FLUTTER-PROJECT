import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'navbar.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

List<String> workBasis = <String>[
  'Hourly Charges',
  'Daily Charges',
  'Monthly Charges',
  'Yearly Charges'
];
var buttonName = 'Add Work';
String dropdownValue = workBasis.first;

class AddJob extends StatefulWidget {
  const AddJob({super.key});

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController money = TextEditingController();
  TextEditingController work = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  String audioPath = "music/1.mp3";
  String noAudioPath = "music/2.mp3";

  @override
  void initState() {
    // getValues();
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
          'GET SET WORK',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 25, 116),
            fontSize: 24,
            fontFamily: 'Quantum',
            letterSpacing: 1,
          ),
        ), //title of scaffold
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
              child: Text(
                'ADD WORK',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 0, 206),
                    fontFamily: 'Quantum',
                    fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  controller: companyName,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Company Name',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Times New Roman',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  controller: work,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Work',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Times New Roman',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  controller: address,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Work Address',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Times New Roman',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    'Charges Type : ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 8, 71),
                        fontSize: 16,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    items:
                        workBasis.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 7,
                  controller: money,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Expected Given Salary',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Times New Roman',
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
            ),
            Container(
                height: 80,
                width: 250,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    buttonName,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                  onPressed: () {
                    addWork();
                  },
                )),
            Container(
                height: 50,
                width: 180,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Remove Work',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 2, 2)),
                  onPressed: () {
                    removeWork();
                  },
                )),
          ],
        ),
      ),
    );
  }

  addWork() async {
    if (dropdownValue.isEmpty ||
        companyName.text.isEmpty ||
        work.text.isEmpty ||
        money.text.isEmpty) {
      await audioPlayer.play(AssetSource(noAudioPath));
      showSnackBar('Please Fill All Fields');
    } else {
      final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
          .collection('works')
          .where('userId', isEqualTo: UserDashboard.userId)
          .get();
      final int countUsers = countUsersSnap.docs.length;

      if (countUsers == 0) {
        final addUserWorkingProfile =
            FirebaseFirestore.instance.collection('works').doc();
        final json = {
          'userCall': UserDashboard.userMobile,
          'userProfile': UserDashboard.userPhoto,
          'userId': UserDashboard.userId,
          'Company Name': companyName.text.toUpperCase(),
          'Work': work.text.toUpperCase(),
          'Work Address': address.text,
          'Work Charges Type': dropdownValue,
          'Expected Given Salary': money.text,
          'createdAt': DateTime.now()
        };
        // print(json);
        await addUserWorkingProfile.set(json);

        await audioPlayer.play(AssetSource(audioPath));
        showSnackBar('Work Added');
      } else {
        final updateId = countUsersSnap.docs.first.id;
        final updateUserWorkingProfile =
            FirebaseFirestore.instance.collection('works').doc(updateId);
        final json = {
          'Company Name': companyName.text.toUpperCase(),
          'Work': work.text.toUpperCase(),
          'Work Address': address.text,
          'Work Charges Type': dropdownValue,
          'Expected Given Salary': money.text,
          'createdAt': DateTime.now()
        };
        await updateUserWorkingProfile.update(json);

        await audioPlayer.play(AssetSource(audioPath));
        showSnackBar('Work Profile Updated');
      }
    }
  }

  removeWork() async {
    final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
        .collection('works')
        .where('userId', isEqualTo: UserDashboard.userId)
        .get();
    final int countUsers = countUsersSnap.docs.length;
    // print(countUsers);
    if (countUsers == 0) {
      showSnackBar('Please Add Work First');
    } else {
      final String getId = countUsersSnap.docs.first.id;
      await FirebaseFirestore.instance.collection('works').doc(getId).delete();

      await audioPlayer.play(AssetSource(noAudioPath));
      showSnackBar('Work Removed Successfully');
    }
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
}
