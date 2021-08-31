import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studentsinfo/auth/authentication_services.dart';
import 'package:studentsinfo/widgets/rounded_rect_button_widget.dart';
import 'package:studentsinfo/widgets/user_image_picker.dart';
import 'package:studentsinfo/widgets/gender_widget.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  File? _userImage;
  String? _name;
  String? _dob;
  String? _fathersName;
  String? _mothersName;
  String? _contactNumber;
  String? _address;
  String? _studentClass;
  String? _email;
  String? _password;
  String? _gender;

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      Provider.of<AuthenticationServices>(context, listen: false).signUp(
        address: _address,
        contactNumber: _contactNumber,
        dob: _dob,
        email: _email,
        fathersName: _fathersName,
        mothersName: _mothersName,
        gender: _gender,
        name: _name,
        password: _password,
        studentClass: _studentClass,
        userimage: _userImage,
      );
    } else {
      return Get.snackbar("No Image Selected", "Please Select a Photo",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Theme.of(context).errorColor);
    }
    Get.back();
  }

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _pickedGender(String? gender) {
    _gender = gender;
  }

  String? _classSelected;
  final List<String> _classList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //image picker

              UserImagePicker(imagePickFunction: _pickedImage),
              const SizedBox(height: 5),
              TextFormField(
                onSaved: (value) {
                  _name = value;
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be Empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 5),

              //dob

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InputDatePickerFormField(
                  errorFormatText: 'Invalid Date',
                  fieldLabelText: 'Enter Date Of Birth',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2015),
                  onDateSaved: (value) {
                    _dob = DateFormat('yyyy-MM-dd').format(value);
                  },
                ),
              ),
              const SizedBox(height: 5),

              // Gender

              GenderWidget(pickedGenderFunction: _pickedGender),

              const SizedBox(height: 5),

              // fathers name

              TextFormField(
                onSaved: (value) {
                  _fathersName = value;
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be Empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Father\'s Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 5),

              //mothers name

              TextFormField(
                  onSaved: (value) {
                    _mothersName = value;
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be Empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Mother\'s Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  keyboardType: TextInputType.name),
              const SizedBox(height: 5),

              //contact number

              TextFormField(
                onSaved: (value) {
                  _contactNumber = value;
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null ||
                      value.length > 10 ||
                      value.isEmpty ||
                      value.length < 7) {
                    return 'Invalid number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 5),

              // Class

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Class:'),
                    const SizedBox(width: 60),
                    Expanded(
                      child: DropdownButtonFormField(
                        onSaved: (value) {
                          // saves selceted class value
                          _studentClass = value.toString();
                        },
                        hint: const Text('Choose Class'),
                        icon: const Icon(Icons.arrow_drop_down),
                        alignment: Alignment.centerRight,
                        value: _classSelected,
                        onChanged: (newValue) {
                          setState(() {
                            // displays selceted class on the screen
                            _classSelected = newValue.toString();
                          });
                        },
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        items: _classList.map((classValue) {
                          return DropdownMenuItem(
                            value: classValue,
                            child: Text(classValue),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),

              // Address

              TextFormField(
                onSaved: (value) {
                  _address = value;
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address cannot be Empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 5),

              // Email

              TextFormField(
                onSaved: (value) {
                  _email = value;
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null ||
                      !value.contains('@') ||
                      value.isEmpty ||
                      !value.contains('.')) {
                    return 'please enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),

              // password

              TextFormField(
                controller: passwordController,
                onSaved: (value) {
                  _password = value;
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter a password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 5),

              // retype password

              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: confirmPasswordController,
                onSaved: (value) {
                  _password = value;
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      passwordController.text !=
                          confirmPasswordController.text) {
                    return 'please retype correct password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 5),

              //signup button

              RoundedRectButtonWidget(
                  buttonName: 'SignUp', buttonFunction: _submitForm),
            ],
          ),
        ),
      ),
    );
  }
}
