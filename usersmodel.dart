import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AllUsers {
  // String id;
  final String name;
  final String mobile;
  final String email;
  final String userProfile;
  final String userType;
  final String city;

  AllUsers({
    // this.id = '',
    required this.name,
    required this.mobile,
    required this.email,
    required this.userProfile,
    required this.userType,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobile': mobile,
        'email': email,
        'profilePhoto': userProfile,
        'userType': userType,
        'city': city,
      };

  static AllUsers fromJson(Map<String, dynamic> json) => AllUsers(
        name: json['name'],
        mobile: json['mobile'],
        email: json['email'],
        userType: json['userType'],
        userProfile: json['profilePhoto'],
        city: json['city'] +
            ',' +
            json['state'] +
            ',' +
            (json['country']).toString().substring(0, 5),
      );
}
