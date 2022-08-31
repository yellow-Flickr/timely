// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';

class Stop_Watch extends StatefulWidget {
  const Stop_Watch({Key? key}) : super(key: key);

  @override
  State<Stop_Watch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stop_Watch> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: height * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Minutes(
                digits: "00",
              ),
              DigitSeperator(seperator: ":"),
              Seconds(
                digits: "00",
              ),
              DigitSeperator(seperator: "."),
              Seconds(
                digits: "00",
              ),
            ],
          ),
        ),
        Container(
          width: width * 0.5,
          height: height * 0.05,
          // padding: EdgeInsets.only(bottom: height * 0.1),
          foregroundDecoration:
              BoxDecoration(color: Colors.grey.shade900.withOpacity(0.5)),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Minutes(
                  digits: "00",
                ),
                DigitSeperator(seperator: ":"),
                Seconds(
                  digits: "00",
                ),
                DigitSeperator(seperator: "."),
                Seconds(
                  digits: "00",
                ),
              ],
            ),
          ),
        ),
        // Expanded(child: SizedBox(width: width * 0.05,)),
        Container(
          height: height * 0.45,
          padding: EdgeInsets.only(
              /* left: width * 0.05, right: width * 0.05, */ top:
                  height * 0.05),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Lap",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                          Text("Lap Times",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                          Text("Overall time",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(.7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                    Divider(
                      endIndent: width * 0.05,
                      indent: width * 0.05,
                      thickness: 1,
                      color: Colors.grey.shade600,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  reverse: true,
                  children: List.generate(
                      13,
                      (index) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.023),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(doubleDigits(index + 1),
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.5),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                Text("00:00.00",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                                Text("00:00.00",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ],
                            ),
                          )),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(
                      left: width * 0.05, bottom: height * 0.05),
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.065,
                    decoration: ShapeDecoration(
                        color: ThemeData.light().disabledColor,
                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(100),
                            gapPadding: 0)),
                    child: TextButton(
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            "Lap",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(
                      right: width * 0.05, bottom: height * 0.05),
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.065,
                    decoration: ShapeDecoration(
                        color: ThemeData.light().primaryColor,
                        shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(100),
                            gapPadding: 0)),
                    child: TextButton(
                        onPressed: () {},
                        child: Center(
                          child: Text(
                            "Start",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
            fontSize: 50, fontWeight: FontWeight.w400, color: Colors.white),
      )),
    );
  }
}

class Seconds extends StatelessWidget {
  final String digits;

  const Seconds({Key? key, required this.digits}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      // margin: EdgeInsets.only(bottom: 15),
      height: height * 0.1,
      width: width * 0.22,
      child: Center(
          // alignment: Alignment.bottomCenter,
          child: Text(
        digits,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 60),
      )),
    );
  }
}

class Minutes extends StatelessWidget {
  final String digits;
  const Minutes({Key? key, required this.digits}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      // margin: EdgeInsets.only(bottom: 15),
      height: height * 0.1,
      width: width * 0.22,
      // padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Center(
          child: Text(
        digits,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 60),
      )),
    );
  }
}

/// Widget for saved and named time presets  on Stop_Watch screen.
class Presets extends StatelessWidget {
  const Presets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.26,
      height: height * 0.20,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: ThemeData.light().primaryColor)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Workout Rest",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            Container(
              child: Text(
                "00:00:00",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Returns clock numbers to appear as double digits eg. 00, 01, 33, 44.
String doubleDigits(int number) {
  return number.toString().length == 1 ? "0$number" : number.toString();
}
