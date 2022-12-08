import 'package:cloud_firestore/cloud_firestore.dart';

class AllWorkersDetails {
  // String id;
  final String dob;
  final String gender;
  final String money;
  final String workType;
  final String dailyCharges;
  final String userId;
  final String userProfile;
  final String userCall;
  final String userName;

  AllWorkersDetails({
    required this.dob,
    required this.gender,
    required this.money,
    required this.userName,
    required this.workType,
    required this.dailyCharges,
    required this.userId,
    required this.userProfile,
    required this.userCall,
  });

  Map<String, dynamic> toJson() => {
        'DateOfBirth': dob,
        'Gender': gender,
        'MoneyNeeded': money,
        'userId': userId,
        'userMobile': userCall,
        'userName': userName,
        'userProfile': userProfile,
        'workChargesType': dailyCharges,
        'workType': workType,
      };

  static AllWorkersDetails fromJson(Map<String, dynamic> json) =>
      AllWorkersDetails(
          dob: json['DateOfBirth'],
          gender: json['Gender'],
          money: json['MoneyNeeded'],
          userName: json['userName'],
          workType: json['workType'],
          dailyCharges: json['workChargesType'],
          userId: json['userId'],
          userProfile: json['userProfile'],
          userCall: json['userMobile']);
}
