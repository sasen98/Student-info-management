import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:studentsinfo/model/user.dart' as user;

class StudentData extends ChangeNotifier {
  user.User studentDetails = user.User(
      id: '',
      image: '',
      name: '',
      dob: '',
      gender: '',
      studentClass: '',
      contactNumber: '',
      fathersName: '',
      mothersName: '',
      address: '',
      percentage: '',
      daysPresent: '',
      daysAbsent: '',
      totalDays: '',
      fee: '',
      role: '');
  Future<user.User> getStudentDetails(String uId) async {
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
      notifyListeners();
    }).catchError((error) {
      print(error.toString());
    });
    print(studentDetails.name);
    return studentDetails;
  }

  user.User getStudent() {
    print(studentDetails.name);
    return studentDetails;
  }

  Future<void> updateStudentInfo(String uId, String totalSchoolDays,
      String daysAbsent, String percentage, String fees) async {
    int daysPresent = int.parse(totalSchoolDays) - int.parse(daysAbsent);
    await FirebaseFirestore.instance.collection('user').doc(uId).update({
      'daysPresent': daysPresent.toString(),
      'daysAbsent': daysAbsent,
      'totalDays': totalSchoolDays,
      'fee': fees,
      'percentage': percentage,
    });
  }
}
