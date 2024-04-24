// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, prefer_final_fields

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/components.dart';
import 'package:timely/src/features/timer/presentation/timeTickerArc.dart';
// import 'package:timely/stopwatch.dart';

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
  int hour = 0, minutes = 0, sec = 0;
  TimeOfDay time = TimeOfDay.now();
  Stopwatch _reverseTimer = Stopwatch();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.fromDateTime(
        DateTime.now().add(Duration(seconds: widget.time)));
    hour = Duration(seconds: widget.time).inSeconds.ceil() %
        Duration.secondsPerHour;
    minutes = Duration(seconds: widget.time).inSeconds.ceil() %
        Duration.secondsPerMinute;
    sec = Duration(seconds: widget.time).inSeconds;
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.time));
    ticking = Tween<double>(begin: _count, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _animationController
      ..forward()
      ..addListener(() {
        if (_animationController.status == AnimationStatus.completed) {
          context.go("/");
          return;
        }
        // dev.log('Acknowledge! 1');
        if (_animationController.isAnimating) {
        // dev.log('Acknowledge! 2');
          _reverseTimer.start();

          setState(() {
            hour = Duration(
                    milliseconds: Duration(seconds: widget.time)
                            .inMilliseconds
                            .ceil() -
                        // (_animationController.lastElapsedDuration ?? Duration())
                        // .inMilliseconds
                        _reverseTimer.elapsedMilliseconds)
                .inHours
                .ceil();
            minutes = Duration(
                        milliseconds: Duration(seconds: widget.time)
                                .inMilliseconds
                                .ceil() -
                            // (_animationController.lastElapsedDuration ??
                            //         Duration()
                            //         )
                            //     .inMilliseconds
                            _reverseTimer.elapsedMilliseconds)
                    .inMinutes
                    .ceil() %
                Duration.minutesPerHour;
            sec = Duration(
                        milliseconds: Duration(seconds: widget.time)
                                .inMilliseconds
                                .ceil() -
                            // (_animationController.lastElapsedDuration ??
                            //         Duration())
                            //     .inMilliseconds
                            _reverseTimer.elapsedMilliseconds)
                    .inSeconds
                    .ceil() %
                Duration.secondsPerMinute;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);

    return PopScope(
      canPop: false,
      // onPopInvoked: (_) async {
      //   return  ;
      // },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                          SizedBox(height: height * .1,),


              Center(
                child: CircularPercentIndicator(
                    radius: height * .20,
                    percent: ticking.value / 100,
                    lineWidth: 10,
                    // reverse: true,
                    progressColor: (ticking.value <= (500 / widget.time))
                        ? Colors.red.shade700
                        : Colors.purple,
                    backgroundWidth: .1,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            "data",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Container(
                          // width: width * 0.5,
                          // height: height * 0.05,
                          // padding: EdgeInsets.only(bottom: height * 0.1),
                          // foregroundDecoration: BoxDecoration(
                          //     color: Colors.grey.shade900.withOpacity(0.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                              Visibility(
                                visible: hour > 0,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: [
                                    TimeDigits(
                                      width: width * .14,
                                      height: height * .10,
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40,
                                      ),
                                      digits: hour.toString().padLeft(2, '0'),
                                      // key: ValueKey<int>(hour),
                                    ),
                                    DigitSeperator(seperator: ":"),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: minutes > 0,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: [
                                    TimeDigits(
                                      width: width * .14,
                                      height: height * .10,
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40,
                                      ),
                                      digits:
                                          minutes.toString().padLeft(2, '0'),
                                      // key: ValueKey<int>(minutes),
                                    ),
                                    DigitSeperator(seperator: ":"),
                                  ],
                                ),
                              ),
                              TimeDigits(
                                width:(minutes > 0 || hour >0) ? width * .14:width * .2,
                                height: height * .10,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: (minutes > 0 || hour >0) ? 40 : 55,
                                ),
                                digits: sec.toString(),
                                // key: ValueKey<int>(sec),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications,
                                size: 20,
                                // color: theme.disabledColor,
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                time.format(context),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(height: height * .1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(
                        left: width * 0.05, bottom: height * 0.05),
                    child: Button(
                      color: theme.disabledColor,
                      label: 'Cancel',
                      onPressed: () {
                             
                        _animationController.stop();
                        context.go("/");
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
                          _animationController.stop(canceled: false);
                          _reverseTimer.stop();
                        } else {
                          _animationController.forward();
                          _reverseTimer.start();
                        }
                        setState(() {});
                      },
                      label: (_animationController.isAnimating)
                          ? "Pause"
                          : "Resume",
                      color: (_animationController.isAnimating)
                          ? Colors.red.shade700
                          : theme.primaryColorDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawTicker extends CustomPainter {
  double stroke;
  ThemeData theme;
  double percent;
  Color? tickerPaint;

  DrawTicker(
      {required this.stroke,
      required this.percent,
      required this.theme,
      this.tickerPaint});
  @override
  void paint(Canvas canvas, Size size) {
    Paint tickerTrack = Paint()
      ..color = theme.disabledColor.withOpacity(.8)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke / 50;

    Paint ticker = Paint()
      ..color = tickerPaint ?? theme.primaryColorDark
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
