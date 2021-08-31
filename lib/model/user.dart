import 'dart:io';

class User {
  final String id;
  final File image;
  final String name;
  final String dob;
  final String gender;
  final String studentClass;
  final String contactNumber;
  final String fathersName;
  final String mothersName;
  final String address;
  final String percentage;
  final String daysPresent;
  final String daysAbsent;
  final String totalDays;
  final String fee;

  User({
    required this.id,
    required this.image,
    required this.name,
    required this.dob,
    required this.gender,
    required this.studentClass,
    required this.contactNumber,
    required this.fathersName,
    required this.mothersName,
    required this.address,
    required this.percentage,
    required this.daysPresent,
    required this.daysAbsent,
    required this.totalDays,
    required this.fee,
  });
}
