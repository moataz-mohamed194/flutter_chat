import 'package:flutter/material.dart';

class TextButtonWeight extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final double buttonSize;
  final FontWeight weightButton;
  final Color textStyleColor;
  const TextButtonWeight({
    this.onTap,
    this.textStyleColor,
    this.buttonText,
    this.buttonSize,
    this.weightButton,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "$buttonText",
        style: TextStyle(
            color: textStyleColor,
            fontSize: buttonSize,
            fontWeight: weightButton),
      ),
    );
  }
}
