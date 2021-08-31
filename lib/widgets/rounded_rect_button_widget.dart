import 'package:flutter/material.dart';

class RoundedRectButtonWidget extends StatelessWidget {
  final String buttonName;
  final void Function() buttonFunction;
  const RoundedRectButtonWidget(
      {Key? key, required this.buttonName, required this.buttonFunction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonFunction,
      child: Container(
        child: Center(
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        height: 50,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
