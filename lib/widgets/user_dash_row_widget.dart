import 'package:flutter/material.dart';

class UserDashRowWidget extends StatelessWidget {
  const UserDashRowWidget({Key? key, required this.label, required this.value})
      : super(key: key);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
