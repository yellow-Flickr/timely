// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:timely/Components.dart';
import 'package:timely/constant.dart';
import 'package:timely/main.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<StopWatch>
    with SingleTickerProviderStateMixin {
  int millisec = 0, minutes = 0, sec = 0;
  // Stopwatch tick = Stopwatch();
  // late AnimationController controller;
  late Ticker ticker;
  // late Animation<double> animating;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ticker = createTicker((elapsed) {
      setState(() {
        minutes = elapsed.inMinutes.ceil();
        sec = elapsed.inSeconds.ceil() % Duration.secondsPerMinute;
        millisec =
            elapsed.inMilliseconds.ceil() % Duration.millisecondsPerSecond;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.06, vertical: height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: height * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 5),
                    child: Minutes(
                      digits: minutes,
                      textOpacity: 1,
                      // key: ValueKey<int>(Duration(
                      //         milliseconds:
                      //             context.watch<TimelyStates>().stopWatch)
                      //     .inMinutes),
                      key: ValueKey<int>(minutes),
                    ),
                  ),
                  DigitSeperator(seperator: ":"),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 2),
                    child: Seconds(
                      digits: sec,
                      textOpacity: 1,
                      // key: ValueKey<int>(Duration(
                      //             milliseconds:
                      //                 context.watch<TimelyStates>().stopWatch)
                      //         .inSeconds %
                      //     Duration.millisecondsPerMinute),
                      key: ValueKey<int>(sec),
                    ),
                  ),
                  DigitSeperator(seperator: "."),
                  AnimatedSwitcher(
                    duration: Duration(microseconds: 1),
                    child: Milliseconds(
                      digits: millisec,
                      textOpacity: 1,
                      // key: ValueKey<int>(Duration(
                      //             milliseconds:
                      //                 context.watch<TimelyStates>().stopWatch)
                      //         .inMilliseconds %
                      //     Duration.millisecondsPerMinute),
                      key: ValueKey<int>(millisec),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.5,
              height: height * 0.05,
              // padding: EdgeInsets.only(bottom: height * 0.1),
              // foregroundDecoration:
              //     BoxDecoration(color: theme.primaryColor.withOpacity(0.5)),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Minutes(
                      digits: 0,
                      textOpacity: 0.7,
                    ),
                    DigitSeperator(seperator: ":"),
                    Seconds(
                      digits: 0,
                      textOpacity: 0.7,
                    ),
                    DigitSeperator(seperator: "."),
                    Milliseconds(
                      digits: 0,
                      textOpacity: 0.7,
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
                                      color: theme.primaryColorLight
                                          .withOpacity(.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                              Text("Lap Times",
                                  style: TextStyle(
                                      color: theme.primaryColorLight
                                          .withOpacity(.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                              Text("Overall time",
                                  style: TextStyle(
                                      color: theme.primaryColorLight
                                          .withOpacity(.7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        Divider(
                          endIndent: width * 0.05,
                          indent: width * 0.05,
                          thickness: 1,
                          color: theme.primaryColorLight.withOpacity(.7),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView(
                      reverse: true,
                      children: List.generate(
                          context.watch<TimelyStates>().laps.length,
                          (index) => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.1,
                                    vertical: height * 0.023),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(doubleDigits(index + 1),
                                        style: TextStyle(
                                            color: theme.primaryColorLight
                                                .withOpacity(.5),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                    Text(
                                        "${context.watch<TimelyStates>().laps[index].inMinutes.ceil().toString().padLeft(2, '0')}:${(context.watch<TimelyStates>().laps[index].inSeconds.ceil() % Duration.secondsPerMinute).toString().padLeft(2, '0')}.${(context.watch<TimelyStates>().laps[index].inMilliseconds.ceil() % Duration.millisecondsPerSecond).toString().padLeft(3, '0')}",
                                        style: TextStyle(
                                            color: theme.primaryColorLight
                                                .withOpacity(.6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                    Text("00:00.00",
                                        style: TextStyle(
                                            color: theme.primaryColorLight
                                                .withOpacity(.8),
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
                    Button(
                      onPressed: () {
                        context.read<TimelyStates>().addLap(Duration(
                            minutes: minutes,
                            seconds: sec,
                            milliseconds: millisec));
                      },
                      label: "Lap",
                      color: Theme.of(context).disabledColor,
                    ),
                    Button(
                      onPressed: () {
                        if (ticker.isTicking) {
                          // tick.stop();
                          ticker.stop(canceled: true);
                        } else {
                          ticker.start();
                          // tick.start();
                        }
                      },
                      color: !ticker.muted
                          ? Theme.of(context).primaryColorDark
                          : Colors.red.shade700,
                      label: !ticker.isTicking ? "Start" : 'Reset',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Seconds extends StatelessWidget {
  final int digits;
  final double textOpacity;

  const Seconds({Key? key, required this.digits, required this.textOpacity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return SizedBox(
      // margin: EdgeInsets.only(bottom: 15),
      height: height * 0.12,
      width: width * 0.23,
      child: Center(
          // alignment: Alignment.bottomCenter,
          child: Text(
        digits.toString().padLeft(2, '0'),
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 60,
            color: theme.primaryColorLight.withOpacity(textOpacity)),
      )),
    );
  }
}

class Milliseconds extends StatelessWidget {
  final int digits;
  final double textOpacity;

  const Milliseconds(
      {Key? key, required this.digits, required this.textOpacity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return SizedBox(
      // margin: EdgeInsets.only(bottom: 15),
      height: height * 0.1,
      width: width * 0.23,
      child: Center(
          // alignment: Alignment.bottomCenter,
          child: Text(
        digits.toString().padLeft(3, '0'),
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 50,
            color: theme.primaryColorLight.withOpacity(textOpacity)),
      )),
    );
  }
}

class Minutes extends StatelessWidget {
  final int digits;
  final double textOpacity;

  const Minutes({Key? key, required this.digits, required this.textOpacity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return SizedBox(
      // margin: EdgeInsets.only(bottom: 15),
      height: height * 0.1,
      width: width * 0.22,
      // padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Center(
          child: Text(
        digits.toString().padLeft(2, '0'),
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 60,
            color: theme.primaryColorLight.withOpacity(textOpacity)),
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
