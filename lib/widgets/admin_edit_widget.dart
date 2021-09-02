import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:studentsinfo/auth/authentication_services.dart';
import 'package:studentsinfo/auth/student_data.dart';
import './rounded_rect_button_widget.dart';

class AdminEditWidget extends StatelessWidget {
  final String? uId;
  AdminEditWidget({@required this.uId});

  final _formKey = GlobalKey<FormState>();
  String? totalSchoolDays;
  String? daysAbsent;
  String? daysPresent;
  String? result;
  String? fees;
  void _upDate(BuildContext context) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      Provider.of<StudentData>(context, listen: false)
          .updateStudentInfo(
              uId!, totalSchoolDays!, daysAbsent!, result!, fees!)
          .then((_) {
        Get.snackbar('Success!', 'Student Details Updated',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Theme.of(context).colorScheme.primary,
            colorText: Theme.of(context).colorScheme.secondary);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //attendence

          TextFormField(
            onSaved: (value) {
              totalSchoolDays = value;
            },
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Total School Days cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Enter Total School Days',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 5),
          TextFormField(
            onSaved: (value) {
              daysAbsent = value;
            },
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Absent Days cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Enter Absent Days',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 5),

          //result

          TextFormField(
            onSaved: (value) {
              result = value;
            },
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Percentage cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Enter Percentage',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 5),
          //Fees

          TextFormField(
            onSaved: (value) {
              fees = value;
            },
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Fees cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Enter Due Fees',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 5),

          RoundedRectButtonWidget(
              buttonName: 'Update',
              buttonFunction: () {
                _upDate(context);
              }),
        ],
      ),
    );
  }
}
