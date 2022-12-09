import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_set_work/dashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'navbar.dart';

class UpdateProfilePhoto extends StatefulWidget {
  const UpdateProfilePhoto({super.key});

  @override
  State<UpdateProfilePhoto> createState() => _UpdateProfilePhotoState();
}

class _UpdateProfilePhotoState extends State<UpdateProfilePhoto> {
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

  showSnackBar(String message) {
    var SnackBarVariable = SnackBar(
        content: Text(message),
        backgroundColor: Colors.deepOrange,
        behavior: SnackBarBehavior.floating,
        width: 300,
        duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(SnackBarVariable);
  }

  uploadImage() async {
    if (_image == null) {
      // setProfileImageNull();
      showSnackBar('Please Select Profile Photo');
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
                'EDIT PHOTO',
                style: TextStyle(
                    color: Color.fromARGB(255, 14, 0, 206),
                    fontFamily: 'Quantum',
                    fontSize: 25),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
                  child: ClipOval(
                    //no need to provide border radius to make circular image
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          )
                        : CircleAvatar(
                            radius: 100,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: UserDashboard.userPhoto,
                                height: 200,
                                width: 200,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
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
                  label: Text('Remove Selected')),
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
          ],
        ),
      ),
    );
  }

  setProfileImage() async {
    final chatsCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(UserDashboard.userId);
    final json = {'profilePhoto': imageDownload};
    await chatsCollection.update(json);
    //working profile
    final QuerySnapshot workingProfiles = await FirebaseFirestore.instance
        .collection('workingProfiles')
        .where('userId', isEqualTo: UserDashboard.userId)
        .get();
    final int countWorkingProfiles = workingProfiles.docs.length;
    // print(countWorkingProfiles);

    if (countWorkingProfiles != 0) {
      final String workingProfileId = workingProfiles.docs.first.id;
      var docSnapshot = FirebaseFirestore.instance
          .collection('workingProfiles')
          .doc(workingProfileId);
      final json = {'userProfile': imageDownload};
      await docSnapshot.update(json);
    }

    //job profile
    final QuerySnapshot jobProfiles = await FirebaseFirestore.instance
        .collection('works')
        .where('userId', isEqualTo: UserDashboard.userId)
        .get();
    final int countJobProfiles = jobProfiles.docs.length;
    // print(countJobProfiles);
    if (countJobProfiles != 0) {
      final String jobProfileId = jobProfiles.docs.first.id;
      var docSnapshot =
          FirebaseFirestore.instance.collection('works').doc(jobProfileId);
      final json = {'userProfile': imageDownload};
      await docSnapshot.update(json);
    }
    setState(() {
      UserDashboard.userPhoto = imageDownload;
    });
    showSnackBar('Profile Image Updated');
  }
}
