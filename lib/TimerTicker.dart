// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, prefer_final_fields

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timely/Components.dart';
import 'package:timely/Stopwatch.dart';

class TimerTicker extends StatefulWidget {
  final int time;
  const TimerTicker({Key? key, required this.time}) : super(key: key);

  @override
  State<TimerTicker> createState() => _TimerTickerState();
}

class _TimerTickerState extends State<TimerTicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> ticking;
  double _count = 100;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.time));
    ticking = Tween<double>(begin: _count, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _animationController.forward();
  }

  Future<void> animate() async {
    try {
      // await _animationController.forward().orCancel;
    } on TickerCanceled {
      debugPrint(" C A N C E L L E D");
    }
  }

  Tween<double> percent = Tween<double>(begin: 100, end: 0);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ThemeData.dark().primaryColor,
        body: Column(
          children: [
            Center(heightFactor: 1.5,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.05),
                  height: height * 0.45,
                  width: width,
                  child: AnimatedBuilder(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              "data",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          Container(
                            // width: width * 0.5,
                            // height: height * 0.05,
                            // padding: EdgeInsets.only(bottom: height * 0.1),
                            // foregroundDecoration: BoxDecoration(
                            //     color: Colors.grey.shade900.withOpacity(0.5)),
                            child: FittedBox(
                              fit: BoxFit.contain,
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
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications,
                                  size: 20,
                                  color: Colors.grey.shade400.withOpacity(0.5),
                                ),
                                Text(
                                  "00:00",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade400
                                          .withOpacity(0.5)),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                    animation: ticking,
                    builder: ((context, child) => CustomPaint(
                          size: Size.fromRadius(width / 2),
                          child: Container(
                            height: width,
                            width: width,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.01,
                                vertical: height * 0.005),
                            child: child,
                          ),
                          foregroundPainter: DrawTicker(
                              stroke: width * 0.035,
                              percent: ticking.value,
                              tickerPaint:
                                  (ticking.value <= (500 / widget.time))
                                      ? Colors.red.shade700
                                      : null),
                        )),
                  )),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Center(
                heightFactor: 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                          left: width * 0.05, bottom: height * 0.05),
                      child: Button(
                        color: ThemeData.light().disabledColor,
                        label: 'Cancel',
                        onPressed: () {
                          _animationController.stop();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(
                          right: width * 0.05, bottom: height * 0.05),
                      child: Button(
                        onPressed: () {
                          if (_animationController.isAnimating) {
                            _animationController.stop(canceled: true);
                          } else {
                            _animationController.forward();
                          }
                          setState(() {});
                        },
                        label: (_animationController.isAnimating)
                            ? "Pause"
                            : "Resume",
                        color: (_animationController.isAnimating)
                            ? Colors.red.shade700
                            : Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

class DrawTicker extends CustomPainter {
  double stroke;
  double percent;
  Color? tickerPaint;

  DrawTicker({required this.stroke, required this.percent, this.tickerPaint});
  @override
  void paint(Canvas canvas, Size size) {
    Paint tickerTrack = Paint()
      ..color = Colors.grey[500]!.withOpacity(.8)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke / 6;

    Paint ticker = Paint()
      ..color = tickerPaint ?? ThemeData.light().primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, tickerTrack);

    double arcAngle = 2 * pi * (percent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, ticker);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

/// Widget for saved and named time presets  on TimerTicker screen.
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
