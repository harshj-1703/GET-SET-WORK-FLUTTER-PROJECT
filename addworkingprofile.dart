import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/dashboard.dart';
import 'navbar.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

List<String> workBasis = <String>[
  'Hourly Charges',
  'Daily Charges',
  'Monthly Charges',
  'Yearly Charges'
];

List<String> genderType = <String>[
  'MALE',
  'FEMALE',
  'OTHER',
];

class AddWorkingProfile extends StatefulWidget {
  const AddWorkingProfile({super.key});

  @override
  State<AddWorkingProfile> createState() => _AddWorkingProfileState();
}

// String defaultWorkType = '';
// String defaultMoney = '';
// String defaultDateInput = '';
String dropdownValue = workBasis.first;
String dropdownValueGender = genderType.first;
var buttonName = 'Add Profile';

// getValues() async {
//   final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
//       .collection('workingProfiles')
//       .where('userId', isEqualTo: UserDashboard.userId)
//       .get();
//   final int countUsers = countUsersSnap.docs.length;
//   // print(countUsers);
//   if (countUsers != 0) {
//     final userDetailsGet = await FirebaseFirestore.instance
//         .collection('workingProfiles')
//         .where('userId', isEqualTo: UserDashboard.userId)
//         .get();
//     Map<String, dynamic>? data = userDetailsGet.docs.first.data();

//     defaultWorkType = data['workType'];
//     defaultDateInput = data['DateOfBirth'];
//     defaultMoney = data['MoneyNeeded'];
//     //worktypeget
//     if (data['workChargesType'] == 'Hourly Charges') {
//       dropdownValue = workBasis[0];
//     } else if (data['workChargesType'] == 'Monthly Charges') {
//       dropdownValue = workBasis[2];
//     } else if (data['workChargesType'] == 'Daily Charges') {
//       dropdownValue = workBasis[1];
//     } else {
//       dropdownValue = workBasis[3];
//     }
//     //genderget
//     if (data['Gender'] == 'FEMALE') {
//       dropdownValueGender = genderType[1];
//     } else if (data['Gender'] == 'OTHER') {
//       dropdownValueGender = genderType[2];
//     } else {
//       dropdownValueGender = genderType[0];
//     }
//     buttonName = 'Update Profile';
//   }
// }

class _AddWorkingProfileState extends State<AddWorkingProfile> {
  AudioPlayer audioPlayer = AudioPlayer();
  String audioPath = "music/1.mp3";
  String noAudioPath = "music/2.mp3";
  @override
  void initState() {
    // getValues();
    super.initState();
  }

  TextEditingController workType = TextEditingController();
  TextEditingController money = TextEditingController();
  TextEditingController dateInput = TextEditingController();

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
            fontSize: 25,
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
              padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
              child: Text(
                'ADD WORKING PROFILE',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 0, 206),
                    fontFamily: 'Quantum',
                    fontSize: 22),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  controller: workType,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Work Type',
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
                    labelText: 'Money Needed',
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
              child: Text(
                'Date Of Birth : ',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 8, 71),
                    fontSize: 16,
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                height: MediaQuery.of(context).size.width / 5,
                child: Center(
                    child: TextField(
                  controller: dateInput,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    'Gender : ',
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
                    value: dropdownValueGender,
                    items: genderType
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValueGender = value!;
                      });
                    },
                  ),
                ),
              ],
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
                    addWorkingProfile();
                  },
                )),
            Container(
                height: 70,
                width: 250,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Remove Working Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 2, 2)),
                  onPressed: () {
                    removeWorkingProfile();
                  },
                )),
          ],
        ),
      ),
    );
  }

  addWorkingProfile() async {
    if (dropdownValue.isEmpty ||
        dropdownValueGender.isEmpty ||
        workType.text.isEmpty ||
        money.text.isEmpty ||
        dateInput.text.isEmpty) {
      await audioPlayer.play(AssetSource(noAudioPath));
      showSnackBar('Please Fill All Fields');
    } else {
      final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
          .collection('workingProfiles')
          .where('userId', isEqualTo: UserDashboard.userId)
          .get();
      final int countUsers = countUsersSnap.docs.length;

      if (countUsers == 0) {
        final addUserWorkingProfile =
            FirebaseFirestore.instance.collection('workingProfiles').doc();
        final json = {
          'userProfile': UserDashboard.userPhoto,
          'userName': UserDashboard.userName,
          'userMobile': UserDashboard.userMobile,
          'workType': workType.text.toUpperCase(),
          'workChargesType': dropdownValue,
          'MoneyNeeded': money.text,
          'DateOfBirth': dateInput.text,
          'Gender': dropdownValueGender,
          'userId': UserDashboard.userId,
          'createdAt': DateTime.now()
        };
        await addUserWorkingProfile.set(json);
        await audioPlayer.play(AssetSource(audioPath));
        showSnackBar('User Working Profile Added');
      } else {
        final updateId = countUsersSnap.docs.first.id;
        final updateUserWorkingProfile = FirebaseFirestore.instance
            .collection('workingProfiles')
            .doc(updateId);
        final json = {
          'workType': workType.text.toUpperCase(),
          'workChargesType': dropdownValue,
          'MoneyNeeded': money.text,
          'DateOfBirth': dateInput.text,
          'Gender': dropdownValueGender,
          'userId': UserDashboard.userId,
          'createdAt': DateTime.now()
        };
        await updateUserWorkingProfile.update(json);
        await audioPlayer.play(AssetSource(audioPath));
        showSnackBar('User Working Profile Updated');
      }
    }
  }

  removeWorkingProfile() async {
    final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
        .collection('workingProfiles')
        .where('userId', isEqualTo: UserDashboard.userId)
        .get();
    final int countUsers = countUsersSnap.docs.length;
    // print(countUsers);
    if (countUsers == 0) {
      showSnackBar('Please Add Working Profile First');
    } else {
      final String getId = countUsersSnap.docs.first.id;
      await FirebaseFirestore.instance
          .collection('workingProfiles')
          .doc(getId)
          .delete();
      await audioPlayer.play(AssetSource(noAudioPath));
      showSnackBar('Working Profile Removed Successfully');
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
