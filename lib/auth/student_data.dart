import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:studentsinfo/model/user.dart' as user;

class StudentData extends ChangeNotifier {
  user.User? studentDetails;
  Future<void> getStudentDetails(String uId) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> docs) {
      var userInfo = docs.data();
      studentDetails = user.User(
          id: userInfo!['id'],
          image: userInfo['image_url'],
          name: userInfo['name'],
          dob: userInfo['dob'],
          gender: userInfo['gender'],
          studentClass: userInfo['studentClass'],
          contactNumber: userInfo['contactNumber'],
          fathersName: userInfo['fathersName'],
          mothersName: userInfo['mothersName'],
          address: userInfo['address'],
          percentage: userInfo['percentage'],
          daysPresent: userInfo['daysPresent'],
          daysAbsent: userInfo['daysAbsent'],
          totalDays: userInfo['totalDays'],
          fee: userInfo['fee'],
          role: userInfo['role']);
      print(studentDetails);
    }).catchError((error) {
      print(error.toString());
    });
  }

  user.User getStudent() {
    return studentDetails!;
  }
}
