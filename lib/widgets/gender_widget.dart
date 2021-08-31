import 'package:flutter/material.dart';

class GenderWidget extends StatefulWidget {
  final void Function(String? gender) pickedGenderFunction;
  const GenderWidget({Key? key, required this.pickedGenderFunction})
      : super(key: key);

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  String? _gender;
  void _getGender() {
    widget.pickedGenderFunction(_gender);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gender'),
          RadioListTile(
              activeColor: Theme.of(context).colorScheme.primary,
              title: const Text('Male'),
              value: 'Male',
              groupValue: _gender,
              onChanged: (val) {
                setState(() {
                  _gender = val.toString();
                });
                _getGender();
              }),
          RadioListTile(
              activeColor: Theme.of(context).colorScheme.primary,
              title: const Text('Female'),
              value: 'Female',
              groupValue: _gender,
              onChanged: (val) {
                setState(() {
                  _gender = val.toString();
                });
                _getGender();
              }),
        ],
      ),
    );
  }
}
