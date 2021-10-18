import 'package:flutter/material.dart';

class RoundedRectangularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String buttonName;

  const RoundedRectangularButton(
      {Key? key,
      required this.onPressed,
      required this.color,
      required this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonName,
          ),
        ),
      ),
    );
  }
}
