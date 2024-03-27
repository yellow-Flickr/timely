// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/components.dart';
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
                ScrollableTimeSelector(
                  selectedTime: (p0) {
                    setState(() {
                      hour = p0;
                    });
                  },
                  label: 'Hours',
                  timeFigures: 100,
                ),
                DigitSeperator(seperator: ':',wheelSelector: true,),
                ScrollableTimeSelector(
                  selectedTime: (p0) {
                    setState(() {
                      minutes = p0;
                    });
                  },
                  label: 'Minutes',
                  timeFigures: 60,
                ),
                DigitSeperator(seperator: ':',wheelSelector: true,),
                ScrollableTimeSelector(
                  selectedTime: (p0) {
                    setState(() {
                      sec = p0;
                    });
                  },
                  label: 'Seconds',
                  timeFigures: 60,
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
