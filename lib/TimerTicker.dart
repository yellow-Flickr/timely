// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timely/Stopwatch.dart';

class TimerTicker extends StatefulWidget {
  const TimerTicker({Key? key}) : super(key: key);

  @override
  State<TimerTicker> createState() => _TimerTickerState();
}

class _TimerTickerState extends State<TimerTicker>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _count = 50;


@override
  void dispose() {
     _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
     super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
  }
  

  Future<void> animate() async {
    try {
      await _animationController.forward().orCancel;
    } on TickerCanceled {
      debugPrint(" C A N C E L L E D");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Center(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.05),
              height: height * 0.45,
              width: width,
              // color: Colors.amber,
              child: FittedBox(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder:((context, child) =>  CustomPaint(
                    size: Size.fromRadius(width / 2),
                    child: Container(
                      height: width,
                      width: width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01, vertical: height * 0.005),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              "data",
                              style: TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          Container(
                            // width: width * 0.5,
                            // height: height * 0.05,
                            // padding: EdgeInsets.only(bottom: height * 0.1),
                            // foregroundDecoration: BoxDecoration(
                            //     color: Colors.grey.shade900.withOpacity(0.5)),
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
                                      color:
                                          Colors.grey.shade400.withOpacity(0.5)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    foregroundPainter:
                        DrawTicker(stroke: width * 0.035, percent: _count),
                  )),
                ),
              )),
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
    ;
  }
}

// class CountDown extends StatefulWidget {
//   const CountDown({Key? key}) : super(key: key);

//   @override
//   State<CountDown> createState() => _CountDownState();
// }

// class _CountDownState extends State<CountDown> {
//   int _count = 50;

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Column(
//       children: [
//         Center(
//           child: Container(
//               margin: EdgeInsets.symmetric(vertical: height * 0.05),
//               height: height * 0.45,
//               width: width,
//               // color: Colors.amber,
//               child: FittedBox(
//                 child: CustomPaint(
//                   size: Size.fromRadius(width / 2),
//                   child: Container(
//                     height: width,
//                     width: width,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.01, vertical: height * 0.005),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           child: Text(
//                             "data",
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 30),
//                           ),
//                         ),
//                         Container(
//                           // width: width * 0.5,
//                           // height: height * 0.05,
//                           // padding: EdgeInsets.only(bottom: height * 0.1),
//                           // foregroundDecoration: BoxDecoration(
//                           //     color: Colors.grey.shade900.withOpacity(0.5)),
//                           child: FittedBox(
//                             fit: BoxFit.scaleDown,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Minutes(
//                                   digits: "00",
//                                 ),
//                                 DigitSeperator(seperator: ":"),
//                                 Seconds(
//                                   digits: "00",
//                                 ),
//                                 DigitSeperator(seperator: "."),
//                                 Seconds(
//                                   digits: "00",
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.notifications,
//                                 size: 20,
//                                 color: Colors.grey.shade400.withOpacity(0.5),
//                               ),
//                               Text(
//                                 "00:00",
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.grey.shade400
//                                         .withOpacity(0.5)),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   foregroundPainter:
//                       DrawTicker(stroke: width * 0.035, percent: _count),
//                 ),
//               )),
//         ),
//         Flexible(
//           fit: FlexFit.loose,
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   alignment: Alignment.bottomLeft,
//                   padding: EdgeInsets.only(
//                       left: width * 0.05, bottom: height * 0.05),
//                   child: Container(
//                     width: width * 0.3,
//                     height: height * 0.065,
//                     decoration: ShapeDecoration(
//                         color: ThemeData.light().disabledColor,
//                         shape: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(100),
//                             gapPadding: 0)),
//                     child: TextButton(
//                         onPressed: () {},
//                         child: Center(
//                           child: Text(
//                             "Lap",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Colors.white),
//                           ),
//                         )),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.bottomRight,
//                   padding: EdgeInsets.only(
//                       right: width * 0.05, bottom: height * 0.05),
//                   child: Container(
//                     width: width * 0.3,
//                     height: height * 0.065,
//                     decoration: ShapeDecoration(
//                         color: ThemeData.light().primaryColor,
//                         shape: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(100),
//                             gapPadding: 0)),
//                     child: TextButton(
//                         onPressed:  (){},
//                         child: Center(
//                           child: Text(
//                             "Start",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Colors.white),
//                           ),
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class DrawTicker extends CustomPainter {
  double stroke;
  int percent;

  DrawTicker({required this.stroke, required this.percent});
  @override
  void paint(Canvas canvas, Size size) {
    Paint tickerTrack = Paint()
      ..color = Colors.grey[500]!.withOpacity(.8)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke / 6;

    Paint ticker = Paint()
      ..color = ThemeData.light().primaryColor
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
