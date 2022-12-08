import 'package:cloud_firestore/cloud_firestore.dart';

class AllJobs {
  // String id;
  final String comapnyName;
  final String givenSalary;
  final String work;
  final String workAddress;
  final String dailyCharges;
  final String userId;
  final String userProfile;
  final String userCall;

  AllJobs({
    // this.id = '',
    required this.comapnyName,
    required this.givenSalary,
    required this.work,
    required this.workAddress,
    required this.dailyCharges,
    required this.userId,
    required this.userProfile,
    required this.userCall,
  });

  Map<String, dynamic> toJson() => {
        'Company Name': comapnyName,
        'Expected Given Salary': givenSalary,
        'Work': work,
        'Work Address': workAddress,
        'Work Charges Type': dailyCharges,
        'userId': userId,
        'userProfile': userProfile,
        'userCall': userCall
      };

  static AllJobs fromJson(Map<String, dynamic> json) => AllJobs(
      comapnyName: json['Company Name'],
      givenSalary: json['Expected Given Salary'],
      work: json['Work'],
      workAddress: json['Work Address'],
      dailyCharges: json['Work Charges Type'],
      userId: json['userId'],
      userProfile: json['userProfile'],
      userCall: json['userCall']);
}
