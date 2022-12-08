// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterMobile extends StatefulWidget {
  //verify id sent to new screen
  static String verify = "";
  static String verifiedPhoneNumber = '';

  RegisterMobile({super.key});

  @override
  State<RegisterMobile> createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
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
                'REGISTER',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 0, 206),
                    fontFamily: 'Quantum',
                    fontSize: 40),
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
    final QuerySnapshot countUsersSnap = await FirebaseFirestore.instance
        .collection('Users')
        .where('mobile', isEqualTo: '+91${phoneNumber.text}')
        .get();
    final int countUsers = countUsersSnap.docs.length;

    if (phoneNumber.text.length != 10) {
      showSnackBar('Mobile Number Should Be Digit 10!');
    }
    if (countUsers > 0) {
      showSnackBar('User Exists');
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          RegisterMobile.verify = verificationId;
          RegisterMobile.verifiedPhoneNumber = phoneNumber.text;
          showSnackBar('OTP has been sent.');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => otpVerify()),
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

class otpVerify extends StatefulWidget {
  otpVerify({super.key});

  @override
  State<otpVerify> createState() => _otpVerifyState();
}

class _otpVerifyState extends State<otpVerify> {
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
          verificationId: RegisterMobile.verify,
          smsCode: otp.text);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      showSnackBar('Phone Number Verified');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => userDetails()),
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

class userDetails extends StatefulWidget {
  static String userId = '';
  const userDetails({super.key});

  @override
  State<userDetails> createState() => _userDetailsState();
}

class _userDetailsState extends State<userDetails> {
  late String countryValue;
  late String stateValue;
  late String cityValue;
  TextEditingController phoneNumber =
      TextEditingController(text: RegisterMobile.verifiedPhoneNumber);
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 120,
                    width: 200,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'USER DETAILS',
                  style: TextStyle(
                      color: Color.fromARGB(255, 14, 0, 206),
                      fontFamily: 'Quantum',
                      fontSize: 25),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: TextField(
                    enabled: false,
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
                  width: 140,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Times New Roman',
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                    onPressed: () {
                      saveUser();
                    },
                  )),
            ],
          ),
        ));
  }

  Future saveUser() async {
    var nameText = name.text.toUpperCase();
    var emailText = email.text;
    var passwordText = password.text;
    var confirmPasswordText = confirmPassword.text;
    if (nameText.isEmpty ||
        passwordText.isEmpty ||
        confirmPasswordText.isEmpty ||
        cityValue.isEmpty ||
        stateValue.isEmpty ||
        countryValue.isEmpty ||
        emailText.isEmpty) {
      showSnackBar('Please Fill All Details!');
    } else if (passwordText.length < 8 || passwordText.length > 15) {
      showSnackBar('Password length must be 8 to 15!');
    } else if (passwordText != confirmPasswordText) {
      showSnackBar('Password does not match!');
    } else {
      final chatsCollection =
          FirebaseFirestore.instance.collection('Users').doc();
      userDetails.userId = chatsCollection.id;
      final json = {
        'name': nameText,
        'mobile': '+91${phoneNumber.text}',
        'password': passwordText,
        'email': emailText,
        'city': cityValue,
        'state': stateValue,
        'country': countryValue,
        'userType': '0',
        'profilePhoto':
            'https://firebasestorage.googleapis.com/v0/b/getsetwork-45362.appspot.com/o/guest.png?alt=media&token=7efbf18e-5fd3-4501-b9e7-0ce8e930bd6a',
        'createdAt': DateTime.now()
      };
      await chatsCollection.set(json);
      showSnackBar('User Added');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UserProfilePhoto()),
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

class UserProfilePhoto extends StatefulWidget {
  const UserProfilePhoto({super.key});

  @override
  State<UserProfilePhoto> createState() => _UserProfilePhotoState();
}

class _UserProfilePhotoState extends State<UserProfilePhoto> {
  File? _image;
  UploadTask? uploadTask;
  var imageDownload = '';

  Future getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  Future getImageGallary() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);

      setState(() {
        this._image = imageTemporary;
      });
    } catch (e) {
      print(e);
    }
  }

  uploadImage() async {
    if (_image == null) {
      print('no image');
    } else {
      final imagename = _image!.path.split('/').last;
      final path = 'images/' + imagename;

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(_image!);
      });

      final snapshot = await uploadTask!.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        imageDownload = urlDownload;
      });

      print('Download Link : ' + urlDownload);
      setProfileImage();

      setState(() {
        uploadTask = null;
      });
    }
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 50,
          );
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                  width: 200,
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ClipOval(
                    //no need to provide border radius to make circular image
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          )
                        : Image.network(
                            'https://png.pngitem.com/pimgs/s/74-741993_customer-icon-png-customer-icon-transparent-png.png',
                            height: 200,
                            width: 200,
                          ),
                  )),
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: (() {
                    getImageCamera();
                  }),
                  icon: Icon(Icons.camera),
                  label: Text('Capture Image')),
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: (() {
                    getImageGallary();
                  }),
                  icon: Icon(Icons.photo_library),
                  label: Text('Select Image')),
            ),
            Center(
              child: ElevatedButton.icon(
                  onPressed: (() {
                    setState(() {
                      _image = null;
                    });
                  }),
                  icon: Icon(Icons.disabled_by_default),
                  label: Text('No Profile')),
            ),
            Container(
                height: 85,
                width: 200,
                padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Upload',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                  onPressed: () {
                    uploadImage();
                  },
                )),
            SizedBox(
              height: 32,
            ),
            Container(padding: EdgeInsets.all(5), child: buildProgress()),
            Container(
                height: 50,
                width: 150,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 14, 0, 206)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        // ModalRoute.withName("/MainScreen")
                        ((route) => false));
                  },
                )),
          ],
        ),
      ),
    );
  }

  setProfileImage() async {
    final chatsCollection =
        FirebaseFirestore.instance.collection('Users').doc(userDetails.userId);
    final json = {'profilePhoto': imageDownload};
    await chatsCollection.update(json);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        // ModalRoute.withName("/MainScreen")
        ((route) => false));
  }
}
