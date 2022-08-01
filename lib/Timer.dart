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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hours(),
            Container(
              height: height * 0.25,
              // width: width * 0.25,
              child: Center(
                  child: Text(
                ":",
                style: TextStyle(fontSize: 80, color: Colors.white),
              )),
            ),
            Minutes(),
            Container(
              height: height * 0.25,
              // width: width * 0.25,
              child: Center(
                  child: Text(
                ":",
                style: TextStyle(fontSize: 80, color: Colors.white),
              )),
            ),
            Seconds(),
          ],
        ),
        Expanded(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              itemExtent: width * 0.25,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsetsDirectional.all(8),
              children: [
                Presets(),
                Presets(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Container(
              width: width * 0.3,
              height: height * 0.1,
               child: ElevatedButton(
                  onPressed: () {}, child: Center(child: Text("Start"))),
            ),
          ),
        ),
      ],
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
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(clipBehavior: Clip.antiAliasWithSaveLayer,
              physics: ScrollPhysics(parent: FixedExtentScrollPhysics()),
              diameterRatio: 4,
              itemExtent: 85,
              overAndUnderCenterOpacity: 0.5,
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      60,
                      (index) => Container(
                              child: Center(
                                  child: Text(
                            doubleDigits(index),
                            style: TextStyle(color: Colors.white, fontSize: 80),
                          )))))),
        ),
      ],
    );
  }
}

class Hours extends StatelessWidget {
  Hours({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();
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
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(
              physics: ScrollPhysics(parent: FixedExtentScrollPhysics()),
              diameterRatio: 4,
              itemExtent: 85,
              overAndUnderCenterOpacity: 0.5,
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      100,
                      (index) => Container(
                              child: Center(
                                  child: Text(
                            doubleDigits(index),
                            style: TextStyle(color: Colors.white, fontSize: 80),
                          )))))),
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
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(
              physics: ScrollPhysics(parent: FixedExtentScrollPhysics()),
              diameterRatio: 4,
              itemExtent: 85,
              overAndUnderCenterOpacity: 0.5,
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      60,
                      (index) => Container(
                              child: Center(
                                  child: Text(
                            doubleDigits(index),
                            style: TextStyle(color: Colors.white, fontSize: 80),
                          )))))),
        ),
      ],
    );
  }
}

class Presets extends StatelessWidget {
  const Presets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.25,
      height: height * 0.15,
      padding: EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: Colors.grey.shade500, shape: BoxShape.circle),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Secondsfdgfrdgrg",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Container(
              child: Text(
                "00:00:00",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String doubleDigits(int number) {
  return number.toString().length == 1 ? "0$number" : number.toString();
}
