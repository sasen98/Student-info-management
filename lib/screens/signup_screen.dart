import 'package:flutter/material.dart';
import 'package:studentsinfo/widgets/signup_form_widget.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Signup',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        automaticallyImplyLeading: true,
        leading: BackButton(
          onPressed: () {
            Get.off(LoginScreen());
          },
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: const SignUpFormWidget(),
    );
  }
}
