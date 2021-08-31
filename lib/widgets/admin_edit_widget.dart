import 'package:flutter/material.dart';
import './rounded_rect_button_widget.dart';

class AdminEditWidget extends StatelessWidget {
  AdminEditWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  late String? totalSchoolDays;
  late String? daysAbsent;
  late String? daysPresent;
  late String? result;
  late String? fees;
  void _upDate() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
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
              buttonName: 'Update', buttonFunction: _upDate),
        ],
      ),
    );
  }
}
