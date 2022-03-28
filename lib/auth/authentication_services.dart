import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentsinfo/model/user.dart' as user;

import '../screens/login_screen.dart';

class AuthenticationServices extends ChangeNotifier {
  user.User? currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> logIn(String? email, String? password) async {
    var errorMessage = "success";
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .catchError((error) {
        if (error.code == "invalid-email") {
          errorMessage = "Inavalid Email";
        }
        if (error.code == "wrong-password") {
          errorMessage = "Wrong Password";
        }
        if (error.code == "user-not-found") {
          errorMessage = "User Not Registered";
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      errorMessage = "Firebase Error";
    }
    return errorMessage;
  }

  Future<String?> signUp(
      {String? email,
      String? password,
      File? userimage,
      String? name,
      String? dob,
      String? gender,
      String? studentClass,
      String? contactNumber,
      String? fathersName,
      String? mothersName,
      String? address}) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(userCredential.user!.uid + '.jpg');
      await ref.putFile(userimage!);
      final url = await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('user')
          .doc(userCredential.user!.uid)
          .set({
        'id': userCredential.user!.uid,
        'image_url': url,
        'name': name!,
        'dob': dob!,
        'gender': gender!,
        'studentClass': studentClass!,
        'contactNumber': contactNumber!,
        'fathersName': fathersName!,
        'mothersName': mothersName!,
        'address': address!,
        'email': email,
        'passowrd': password,
        'percentage': '',
        'daysPresent': '',
        'daysAbsent': '',
        'totalDays': '',
        'fee': '',
        'role': 'user',
      });
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      print('Erroe on signUp');
      print(e.message);
      return e.message;
    }
  }

  Future<void> getCurrentUserInfo() async {
    String uId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> docs) {
      var userInfo = docs.data();
      currentUser = user.User(
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
  }

  Future<void> logOut(context) async {
    await _firebaseAuth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false));
    ;
  }
}
