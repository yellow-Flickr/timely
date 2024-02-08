// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/Components.dart';
import 'package:timely/TimerTicker.dart';
import 'package:timely/ViewModel.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int hour = 0, minutes = 0, sec = 0;
  final ViewModel app = ViewModel();

  @override
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Timely",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            )),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Icon(
            Icons.add,
            size: 25,
          ),
          Icon(
            Icons.more_vert,
            size: 25,
          ),
        ],

        // title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hours(
                  selectedHour: (p0) {
                    setState(() {
                      hour = p0;
                    });
                  },
                ),
                ColonSeperator(),
                Minutes(
                  selectedMinutes: (p0) {
                    setState(() {
                      minutes = p0;
                    });
                  },
                ),
                ColonSeperator(),
                Seconds(
                  selectedSeconds: (p0) {
                    setState(() {
                      sec = p0;
                    });
                  },
                ),
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
              child: Button(
                onPressed: () {
                  if (Duration(hours: hour, minutes: minutes, seconds: sec)
                          .inSeconds ==
                      0) {
                    return;
                  }
                  context.goNamed('ticker', 
                      extra:
                          Duration(hours: hour, minutes: minutes, seconds: sec)
                              .inSeconds);
                },
                label: 'Start',
                color: theme.primaryColorDark,
              ),
            ),
          ),
        ],
      ),
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
          fontSize: 50,
          fontWeight: FontWeight.w400,
        ),
      )),
    );
  }
}

class Seconds extends StatelessWidget {
  final void Function(int) selectedSeconds;

  Seconds({Key? key, required this.selectedSeconds}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
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
            style: TextStyle(fontSize: 15),
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
              onSelectedItemChanged: (value) {
                selectedSeconds(value);
              },
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(60, (index) {
                return Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      doubleDigits(index),
                      style: TextStyle(fontSize: 50),
                    ));
              }))),
        ),
      ],
    );
  }
}

class Hours extends StatelessWidget {
  final void Function(int) selectedHour;
  Hours({Key? key, required this.selectedHour}) : super(key: key);
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
            style: TextStyle(fontSize: 15),
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
              onSelectedItemChanged: (value) {
                selectedHour(value);
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      100,
                      (index) => Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            doubleDigits(index),
                            style: TextStyle(

                                /*  fontWeight: FontWeight.w500, */
                                fontSize: 50),
                          ))))),
        ),
      ],
    );
  }
}

class Minutes extends StatelessWidget {
  final void Function(int) selectedMinutes;

  Minutes({Key? key, required this.selectedMinutes}) : super(key: key);
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
            style: TextStyle(fontSize: 15),
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
              onSelectedItemChanged: (value) {
                selectedMinutes(value);
              },
              // useMagnifier: true,
              // magnification: 1.2,
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      60,
                      (index) => Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            doubleDigits(index),
                            style: TextStyle(fontSize: 50),
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
    var theme = Theme.of(context);

    return Container(
      width: width * 0.26,
      height: height * 0.20,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: theme.primaryColorDark)),
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
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
              child: Text(
                "00:00:00",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
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
