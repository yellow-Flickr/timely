import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/models/scheduleModel.dart';

class Button extends StatelessWidget {
  Color? color = ThemeData.dark().disabledColor;
  final void Function()? onPressed;
  final String label;
  Button({
    Key? key,
    this.color,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.3,
      height: height * 0.065,
      decoration: ShapeDecoration(
          color: color,
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100),
              gapPadding: 0)),
      child: TextButton(
          onPressed: onPressed,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          )),
    );
  }
}

/// Punctuation seperating time digits
class DigitSeperator extends StatelessWidget {
  final String seperator;
  final bool wheelSelector;
  const DigitSeperator(
      {Key? key, required this.seperator, this.wheelSelector = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: wheelSelector ? EdgeInsets.only(top: height * 0.1) : null,
      margin: wheelSelector ? EdgeInsets.only(top: 10) : null,
      height: wheelSelector ? height * 0.4 : null,
      // width: wheelSelector ? width * 0.25 : null,
      child: Center(
          child: Text(
        seperator,
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w400,
        ),
      )),
    );
  }
}

class Seconds extends StatelessWidget {
  final String digits;
  final TextStyle? style;

  final double? width;
  final double? height;
  const Seconds(
      {Key? key, required this.digits, this.style, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // margin: EdgeInsets.only(bottom: 15),
          height: height ?? (MediaQuery.of(context).size.width * .12),
          width: width ?? (MediaQuery.of(context).size.height * .23),
          child: Center(
              // alignment: Alignment.bottomCenter,
              child: Text(
            digits,
            style: style,
          )),
        ),
      ],
    );
  }
}

class Minutes extends StatelessWidget {
  final String digits;
  const Minutes({Key? key, required this.digits}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        Center(
            child: Text(
          digits,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 50,
              color: theme.primaryColorLight.withOpacity(.9)),
        )),
      ],
    );
  }
}

/// Widget for saved and named time presets  on Worldclock screen.
class ClockItem extends StatelessWidget {
  const ClockItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return Container(
      // width: width * 0.26,
      height: height * 0.10,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: ShapeDecoration(
        color: theme.primaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Accra",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Text(
                  "Local time zone",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
          Container(
            child: Text(
              "00:00",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          )
        ],
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

/// Widget for saved and named time presets  on Stop_Watch screen.
class StopWatchPresets extends StatelessWidget {
  const StopWatchPresets({Key? key}) : super(key: key);

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

/// Widget for saved Schedules.
class ScheduleItem extends StatelessWidget {
  const ScheduleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.goNamed('schedule-detail', extra: testSchedule),
      child: Container(
        // width: width * 0.26,
        // height: height * 0.1,
        padding: EdgeInsets.symmetric(
            vertical: height * .01, horizontal: width * .02),
        decoration: ShapeDecoration(
          color: theme.primaryColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pomodoro Workout",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle_notifications_outlined,
                        color: Colors.redAccent,
                        size: 14,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "High Priority",
                        textAlign: TextAlign.left,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "Hourly",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Repeat",
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 8),
                  ),
                ],
              ),
            )
          ],
        ),
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
  ScrollableTimeSelector(
      {Key? key,
      required this.selectedTime,
      required this.timeFigures,
      this.style,
      required this.label,
      this.labelStyle})
      : super(key: key);
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
            label,
            style: labelStyle ?? TextStyle(fontSize: 15),
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
                selectedTime(value);
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                  children: List.generate(
                      timeFigures,
                      (index) => Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            doubleDigits(index),
                            style: style ?? TextStyle(fontSize: 50),
                          ))))),
        ),
      ],
    );
  }
}
