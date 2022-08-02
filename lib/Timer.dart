// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return 
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hours(),
              ColonSeperator(),
              Minutes(),
              ColonSeperator(),
              Seconds(),
              CircularProgressIndicator()
            ],
          ),
        ),
        // Expanded(child: SizedBox(width: width * 0.05,)),
       
        Expanded(
          child: Center(
            child: Container(
              width: width * 0.3,
              height: height * 0.08,
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
        ),
      ],
    );
  }
}

class Setup_Screen extends StatelessWidget {
  const Setup_Screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hours(),
              ColonSeperator(),
              Minutes(),
              ColonSeperator(),
              Seconds(),
            ],
          ),
        ),
        // Expanded(child: SizedBox(width: width * 0.05,)),
        Expanded(
          child: Center(
            child: ListView.separated(
              itemCount: 7,
              itemBuilder: ((context, index) => Presets()),
              separatorBuilder: ((context, index) => SizedBox(
                    width: width * 0.05,
                  )),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsetsDirectional.all(10),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: width * 0.3,
              height: height * 0.08,
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
        ),
      ],
    );
  }
}

/// Colon seperating time digits
class ColonSeperator extends StatelessWidget {
  const ColonSeperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: height * 0.12),
      margin: EdgeInsets.only(top: 10),
      height: height * 0.4,
      // width: width * 0.25,
      child: Center(
          child: Text(
        ":",
        style: TextStyle(
            fontSize: 50, fontWeight: FontWeight.w400, color: Colors.white),
      )),
    );
  }
}

class Seconds extends StatelessWidget {
  Seconds({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.05),
          width: width * 0.25,
          child: Center(
              child: Text(
            "Seconds",
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              physics: ScrollPhysics(parent: FixedExtentScrollPhysics()),
              diameterRatio: 4,
              itemExtent: 85,
              overAndUnderCenterOpacity: 0.3,
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      60,
                      (index) => Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            doubleDigits(index),
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ))))),
        ),
      ],
    );
  }
}

class Hours extends StatelessWidget {
  Hours({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.05),
          width: width * 0.25,
          child: Center(
              child: Text(
            "Hours",
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(
              physics: ScrollPhysics(parent: FixedExtentScrollPhysics()),
              diameterRatio: 4,
              itemExtent: 85,
              overAndUnderCenterOpacity: 0.3,
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      100,
                      (index) => Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            doubleDigits(index),
                            style: TextStyle(
                                color: Colors.white,
                               /*  fontWeight: FontWeight.w500, */
                                fontSize: 50),
                          ))))),
        ),
      ],
    );
  }
}

class Minutes extends StatelessWidget {
  Minutes({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.05),
          width: width * 0.25,
          child: Center(
              child: Text(
            "Minutes",
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(
              physics: ScrollPhysics(parent: FixedExtentScrollPhysics()),
              diameterRatio: 4,
              itemExtent: 85,
              overAndUnderCenterOpacity: 0.3,
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      60,
                      (index) => Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            doubleDigits(index),
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ))))),
        ),
      ],
    );
  }
}

/// Widget for saved and named time presets  on Timer screen.
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
