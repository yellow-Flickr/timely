import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color? color;
  final void Function()? onPressed;
  final String label;
  final double borderRadius;
  final double width;
  final double height;
  final WidgetStatesController? statesController;
  final TextStyle? style;
  const Button({
    Key? key,
    this.color,
    required this.onPressed,
    required this.label,
    this.borderRadius = 5,
    this.width = 0.2,
    this.height = 0.065,
    this.style,
    this.statesController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: TextButton(
          statesController: statesController,
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return (color ?? ThemeData.dark().disabledColor)
                      .withOpacity(.6);
                }
                return color ?? ThemeData.dark().disabledColor;
              }),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ))),
          onPressed: onPressed,
          child: Center(
            child: Text(
              label,
              style: style ??
                  theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white),
            ),
          )),
    );
  }
}

/// Punctuation seperating time digits
class DigitSeperator extends StatelessWidget {
  final String seperator;
  final bool wheelSelector;
  final TextStyle? style;
  const DigitSeperator(
      {Key? key,
      required this.seperator,
      this.wheelSelector = false,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Container(
      padding: wheelSelector ? EdgeInsets.only(top: height * 0.1) : null,
      margin: wheelSelector ? const EdgeInsets.only(top: 10) : null,
      height: wheelSelector ? height * 0.4 : null,
      // width: wheelSelector ? width * 0.25 : null,
      child: Center(
          child: Text(
        seperator,
        style: style ??
            const TextStyle(
              textBaseline: TextBaseline.ideographic,
              fontSize: 50,
              fontWeight: FontWeight.w400,
            ),
      )),
    );
  }
}

class TimeDigits extends StatelessWidget {
  final String digits;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  const TimeDigits({
    Key? key,
    required this.digits,
    this.style,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: padding ??
              EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .01),
          height: height ?? (MediaQuery.of(context).size.width * .12),
          width: width ?? (MediaQuery.of(context).size.height * .23),
          child: Text(
            digits,
            style: style,
          ),
        ),
      ],
    );
  }
}
