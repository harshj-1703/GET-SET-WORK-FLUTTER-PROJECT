import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/dashboard.dart';
import 'package:get_set_work/register.dart';
import 'package:get_set_work/updateprofilephoto.dart';
import 'navbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

String countryValue = UserDashboard.userCountry;
String stateValue = UserDashboard.userState;
String cityValue = UserDashboard.userCity;

class _EditProfileState extends State<EditProfile> {
  TextEditingController name =
      TextEditingController(text: UserDashboard.userName);
  TextEditingController password =
      TextEditingController(text: UserDashboard.userPassword);
  TextEditingController confirmPassword =
      TextEditingController(text: UserDashboard.userPassword);
  TextEditingController email =
      TextEditingController(text: UserDashboard.userEmail);
  @override
  void initState() {
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
            // Center(
            //   child: Padding(
            //     padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            //     child: Image.asset(
            //       'assets/images/logo.png',
            //       height: 120,
            //       width: 200,
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'EDIT PROFILE',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 0, 206),
                    fontFamily: 'Quantum',
                    fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextField(
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  controller: name,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Full Name',
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
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  controller: email,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Email',
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
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  controller: password,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Password',
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
              padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  controller: confirmPassword,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Confirm Password',
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
              padding: EdgeInsets.fromLTRB(12, 5, 12, 0),
              child: SelectState(
                // style: TextStyle(color: Colors.red),
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                },
              ),
            ),
            Container(
                height: 50,
                width: 180,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                  onPressed: () {
                    update();
                  },
                )),
            Container(
                height: 65,
                width: 220,
                padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Change Profile Photo',
                    style: TextStyle(
                        color: Color.fromARGB(255, 9, 2, 80),
                        fontFamily: 'Times New Roman',
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 242, 0)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfilePhoto()),
                        // ModalRoute.withName("/MainScreen")
                        ((route) => route.isFirst));
                  },
                )),
          ],
        ),
      ),
    );
  }

  update() async {
    if (name.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      showSnackBar('Please Fill All Fields');
    } else if (password.text.length < 8 || confirmPassword.text.length < 8) {
      showSnackBar('Password Length Must Be 8');
    } else if (password.text != confirmPassword.text) {
      showSnackBar('Password Does Not Match');
    } else {
      final QuerySnapshot workingProfiles = await FirebaseFirestore.instance
          .collection('workingProfiles')
          .where('userId', isEqualTo: UserDashboard.userId)
          .get();
      final int countProfiles = workingProfiles.docs.length;

      //if profile available then update in both collection
      if (countProfiles != 0) {
        final String workingProfileId = workingProfiles.docs.first.id;
        var docSnapshot = FirebaseFirestore.instance
            .collection('workingProfiles')
            .doc(workingProfileId);
        final json = {'userName': name.text};
        await docSnapshot.update(json);

        var updateQuery = FirebaseFirestore.instance
            .collection('Users')
            .doc(UserDashboard.userId);
        final json1 = {
          'name': name.text,
          'email': email.text,
          'password': password.text,
          'country': countryValue,
          'state': stateValue,
          'city': cityValue,
        };
        await updateQuery.update(json1);

        setState(() {
          UserDashboard.userEmail = email.text;
          UserDashboard.userName = name.text;
          UserDashboard.userPassword = password.text;
          UserDashboard.userCountry = countryValue;
          UserDashboard.userState = stateValue;
          UserDashboard.userCity = cityValue;
        });

        showSnackBar('User Profile Updated');
      }

      //update in only userProfile
      else {
        var updateQuery = FirebaseFirestore.instance
            .collection('Users')
            .doc(UserDashboard.userId);
        final json1 = {
          'name': name.text,
          'email': email.text,
          'password': password.text,
          'country': countryValue,
          'state': stateValue,
          'city': cityValue,
        };
        await updateQuery.update(json1);

        setState(() {
          UserDashboard.userEmail = email.text;
          UserDashboard.userName = name.text;
          UserDashboard.userPassword = password.text;
          UserDashboard.userCountry = countryValue;
          UserDashboard.userState = stateValue;
          UserDashboard.userCity = cityValue;
        });

        showSnackBar('User Profile Updated');
      }
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
