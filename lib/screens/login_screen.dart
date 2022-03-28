import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentsinfo/auth/authentication_services.dart';
import 'package:studentsinfo/screens/admin_dashboard_screen.dart';
import 'package:studentsinfo/screens/user_dashboard_screen.dart';

import 'package:studentsinfo/widgets/rounded_rect_button_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  String? email;
  String? password;
  void _checkUserRole() {
    Provider.of<AuthenticationServices>(context, listen: false)
        .getCurrentUserInfo()
        .then((_) {
      var role = Provider.of<AuthenticationServices>(context, listen: false)
          .currentUser!
          .role;
      print(role);
      if (role == 'user') {
        Get.to(() => UserDashboardScreen());
      } else if (role == 'admin') {
        Get.to(() => AdminDashboardScreen());
      } else {
        print("errorMessage");
      }
    });
  }

  Future<void> _login() async {
    if (_loginKey.currentState!.validate()) {
      _loginKey.currentState!.save();

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((_) {
        _checkUserRole();
      }).catchError((error) {
        if (error.code == "invalid-email") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Email does not exists!!!"),
                  actions: <Widget>[
                    new TextButton(
                        child: new Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                );
              });
        }
        if (error.code == "wrong-password") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Password Incorrect!!!"),
                  actions: <Widget>[
                    new TextButton(
                        child: new Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                );
              });
        }
        if (error.code == "user-not-found") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("User Not Registered"),
                  actions: <Widget>[
                    new TextButton(
                        child: new Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                );
              });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Login',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
          child: Column(
            children: [
              Text(
                'GREEN KANTIPUR HIGHER SECONDARY SCHOOL',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _loginKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email Cannot Be Empty';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Example@example.com',
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          onSaved: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password Cannot Be Empty';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RoundedRectButtonWidget(
                            buttonName: 'Login', buttonFunction: _login),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/signup');
                          },
                          child: const Text('SignUp Instead?'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
