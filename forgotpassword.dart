import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_set_work/login.dart';
import 'package:get_set_work/register.dart';

class ForgotPassword1 extends StatefulWidget {
  //verify id sent to new screen
  static String verify = "";
  static String verifiedPhoneNumber = '';
  const ForgotPassword1({super.key});

  @override
  State<ForgotPassword1> createState() => _ForgotPassword1State();
}

class _ForgotPassword1State extends State<ForgotPassword1> {
  TextEditingController phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 300,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'FORGOT PASSWORD',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 0, 206),
                    fontFamily: 'Quantum',
                    fontSize: 21),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextField(
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 3,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: phoneNumber,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    prefix: Text('+91'),
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
            ),
            Container(
                height: 60,
                width: 140,
                padding: EdgeInsets.fromLTRB(10, 14, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                  onPressed: () {
                    sendOtp();
                  },
                )),
          ],
        ));
  }

  sendOtp() async {
    if (phoneNumber.text.length != 10) {
      showSnackBar('Mobile Number Should Be Digit 10!');
    }

    final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
        .collection('Users')
        .where('mobile', isEqualTo: '+91${phoneNumber.text}')
        .get();
    final int countUsers = countUsersSnap.docs.length;
    if (countUsers < 0) {
      showSnackBar('User Not Exists');
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          ForgotPassword1.verify = verificationId;
          ForgotPassword1.verifiedPhoneNumber = phoneNumber.text;
          showSnackBar('OTP has been sent.');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ForgotOtpVerify()),
          // ModalRoute.withName("/MainScreen")
          ((route) => true));
      // showSnackBar('+91' + phoneNumber.text);
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

class ForgotOtpVerify extends StatefulWidget {
  const ForgotOtpVerify({super.key});

  @override
  State<ForgotOtpVerify> createState() => _ForgotOtpVerifyState();
}

class _ForgotOtpVerifyState extends State<ForgotOtpVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                  width: 300,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'OTP VERIFY',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 0, 206),
                    fontFamily: 'Quantum',
                    fontSize: 40),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 25,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  controller: otp,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                    ),
                    labelText: 'Enter OTP',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 165, 165, 165),
                        fontFamily: 'Times New Roman',
                        fontSize: 18,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w600),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Color.fromARGB(255, 14, 0, 206)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
            ),
            Container(
                height: 60,
                width: 140,
                padding: EdgeInsets.fromLTRB(10, 14, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Verify',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                  onPressed: () {
                    verifyPhone();
                  },
                )),
          ],
        ));
  }

  verifyPhone() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          //RegisterMobile class has variable that value define in above class function and passed verify id.
          verificationId: ForgotPassword1.verify,
          smsCode: otp.text);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      showSnackBar('Phone Number Verified');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordSet()),
          // ModalRoute.withName("/MainScreen")
          ((route) => false));
    } catch (e) {
      showSnackBar('Wrong OTP.');
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

class ForgotPasswordSet extends StatefulWidget {
  const ForgotPasswordSet({super.key});

  @override
  State<ForgotPasswordSet> createState() => _ForgotPasswordSetState();
}

class _ForgotPasswordSetState extends State<ForgotPasswordSet> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 170,
                    width: 400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  'SET NEW PASSWORD',
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 0, 206),
                      fontFamily: 'Quantum',
                      fontSize: 21),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
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
                  height: 100,
                  width: 220,
                  padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child: ElevatedButton(
                    child: Text(
                      'Update Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                    onPressed: () {
                      updatePassword();
                    },
                  )),
            ],
          ),
        ));
  }

  Future updatePassword() async {
    var pass1 = password.text;
    var pass2 = confirmPassword.text;

    if (pass1.length < 8) {
      showSnackBar('Password Length Must Be 8');
    } else if (pass1 != pass2) {
      showSnackBar('Password Not Match');
    } else {
      // print(ForgotPassword1.verifiedPhoneNumber);
      final QuerySnapshot getUserDetails = await FirebaseFirestore.instance
          .collection('Users')
          .where('mobile',
              isEqualTo: '+91${ForgotPassword1.verifiedPhoneNumber}')
          .get();
      var getId = getUserDetails.docs.first.id;
      // print(getId);
      final collection =
          FirebaseFirestore.instance.collection('Users').doc(getId);
      final json = {'password': pass1};
      await collection.update(json);

      showSnackBar('Password Updated');

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          // ModalRoute.withName("/MainScreen")
          ((route) => false));
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
