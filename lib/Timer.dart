// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/components.dart';
import 'package:timely/ViewModel.dart';
import 'package:timely/constant.dart';

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
