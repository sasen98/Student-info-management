import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> logIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
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
        'image url': url,
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
      return e.message;
    }
  }
}
