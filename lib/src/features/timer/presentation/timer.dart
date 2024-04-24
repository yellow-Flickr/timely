// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/components.dart';
 
 import 'package:timely/constant.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  int hour = 0, minutes = 0, sec = 0;
 
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
          Expanded(
            flex: 4,
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
            child: ListView.separated(
              itemCount: 7,
              padding: EdgeInsets.symmetric(horizontal: width * .02),
              itemBuilder: ((context, index) => TimerTickerPresets()),
              separatorBuilder: ((context, index) => SizedBox(
                    width: width * 0.05,
                  )),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
             ),
          ),
      
        ],
      ),
      bottomNavigationBar:     Padding(
        padding:   EdgeInsets.symmetric(horizontal: width * .1,vertical: height * .02),
        child: Button(
          
          width: width * .6,
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
    );
  }
}

 
 
/// Returns clock numbers to appear as double digits eg. 00, 01, 33, 44.
String doubleDigits(int number) {
  return number.toString().length == 1 ? "0$number" : number.toString();
}

/// Widget for saved and named time presets  on TimerTicker screen.
class TimerTickerPresets extends StatelessWidget {
  const TimerTickerPresets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.22,
      // height: height * 0.1,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: ThemeData.light().primaryColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "00:00:00",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "Workout Rest",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}

///WheelScrollable Time Selector Widget for Timer
class ScrollableTimeSelector extends StatelessWidget {
  final void Function(int) selectedTime;
  final int timeFigures;
  final String label;
  final TextStyle? style;
  final TextStyle? labelStyle;
  const ScrollableTimeSelector(
      {Key? key,
      required this.selectedTime,
      required this.timeFigures,
      this.style,
      required this.label,
      this.labelStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
          width: width * 0.25,
          child: Center(
              child: Text(
            label,
            style: labelStyle ?? const TextStyle(fontSize: 15),
          )),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(
              physics: const ScrollPhysics(parent: FixedExtentScrollPhysics()),
              diameterRatio: 4,
              itemExtent: 85,
              overAndUnderCenterOpacity: 0.3,
              // useMagnifier: true,
              // magnification: 1.2,
              onSelectedItemChanged: (value) {
                selectedTime(value);
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      timeFigures,
                      (index) => Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            doubleDigits(index),
                            style: style ?? const TextStyle(fontSize: 50),
                          ))))),
        ),
      ],
    );
  }
}
