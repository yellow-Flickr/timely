import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Color? color = ThemeData.dark().disabledColor;
  final void Function()? onPressed;
  final String label;
  Button({
    Key? key,
    this.color,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.3,
      height: height * 0.065,
      decoration: ShapeDecoration(
          color: color,
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100),
              gapPadding: 0)),
      child: TextButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          )),
    );
  }
}
/// Punctuation seperating time digits
class DigitSeperator extends StatelessWidget {
  final String seperator;
  const DigitSeperator({Key? key, required this.seperator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      // padding: EdgeInsets.only(top: height * 0.12),
      // margin: EdgeInsets.only(top: 10),
      // height: height * 0.4,
      // width: width * 0.25,
      child: Center(
          child: Text(
        seperator,
        style: TextStyle(
            fontSize: 50, fontWeight: FontWeight.w400,),
      )),
    );
  }
}