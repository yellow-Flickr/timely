// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timely/components.dart';
import 'package:timely/constant.dart';

import 'package:timely/src/features/timer/application/timerController.dart';
import 'package:timely/src/features/timer/domain/timerModel.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  Duration durationPicker = Duration.zero;
  int hour = 0, minutes = 0, sec = 0;
  late Size size;
  final List<GlobalKey> secKeys = List.generate(60, (index) => GlobalKey());
  final List<GlobalKey> minKeys = List.generate(60, (index) => GlobalKey());
  final List<GlobalKey> hourKeys = List.generate(100, (index) => GlobalKey());

  Future<bool> _dialogBuilder(BuildContext context) {
    var theme = Theme.of(context);

    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Timer Preset'),
          content: Wrap(
            children: [
              TextField(
                maxLines: 1,
                style: theme.textTheme.bodySmall,
                // controller: title,
                decoration: InputDecoration(
                    fillColor: theme.highlightColor,
                    isDense: true,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.title_rounded,
                      color: Colors.grey,
                    ),
                    hintText: 'Timer Label',
                    counterText: '',
                    border: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: height * .08,
              ),
              ListTile(
                onTap: () async {
                  await showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => Container(
                      height: 216,
                      padding: const EdgeInsets.only(top: 6.0),
                      // The bottom margin is provided to align the popup above the system
                      // navigation bar.
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      // Provide a background color for the popup.
                      color: theme.dialogBackgroundColor,
                      // Use a SafeArea widget to avoid system overlaps.
                      child: SafeArea(
                        top: false,
                        child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hms,
                          initialTimerDuration: Duration.zero,
                          // This is called when the user changes the timer's
                          // duration.
                          onTimerDurationChanged: (Duration newDuration) {
                            // setState(() => duration = newDuration);
                            durationPicker = newDuration;
                          },
                        ),
                      ),
                    ),
                  ).then((onValue) {
                    DateTime dTime = DateTime.fromMicrosecondsSinceEpoch(
                        durationPicker.inMicroseconds);
                    hour = dTime.hour;
                    minutes = dTime.minute;
                    sec = dTime.second;
                  });
                },
                leading: Icon(
                  Icons.timer_outlined,
                  color: Colors.grey,
                ),
                dense: true,
                title: Text(
                  'Duration',
                  style: theme.textTheme.labelSmall,
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * .015, horizontal: width * .04),
                  decoration: ShapeDecoration(
                      // color: theme.h.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('NONE'),
                      SizedBox(
                        width: width * .01,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 13,
                        weight: 100,
                        grade: 100,
                      )
                    ],
                  ),
                ),
                tileColor: theme.highlightColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: theme.primaryColorDark),
              ),
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: theme.primaryColorDark),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            SizedBox(
              width: width * .04,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                backgroundColor: theme.primaryColorDark,
                textStyle: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              ),
              child: Text(
                'Save',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
              ),
              onPressed: () {
                // context.read<TimerStates>().addtimer(TimerModel(
                //       id: 0,
                //       title: 'Pomodoro Workout',
                //       countDown: const Duration(minutes: 1),
                //     ));
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((onValue) => onValue ?? false);
  }

  FixedExtentScrollController hourController = FixedExtentScrollController();
  FixedExtentScrollController minuteController = FixedExtentScrollController();
  FixedExtentScrollController secondController = FixedExtentScrollController();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((callback) {
      size =
          (hourKeys[hour].currentContext?.findRenderObject() as RenderBox).size;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Timely",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            )),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await _dialogBuilder(context).then((onValue) {
                if (!onValue) {
                  return;
                }

                log('hr: $hour - min:$minutes - sec:$sec');
                // RenderBox hourRenderBox = hourKeys[hour]
                //     .currentContext
                //     ?.findRenderObject() as RenderBox;

                // RenderBox minRenderBox = minKeys[minutes]
                //     .currentContext
                //     !.findRenderObject() as RenderBox;

                // RenderBox secRenderBox = secKeys[sec]
                //     .currentContext
                //     !.findRenderObject() as RenderBox;
                hourController
                    .animateTo(hour * size.height,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear)
                    .then((onValue) {
                  minuteController
                      .animateTo(minutes * size.height,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear)
                      .then((onValue) {
                    secondController.animateTo(sec * size.height,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear);
                  });
                });

                setState(() {});
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 25,
            ),
          )

          // Icon(
          //   Icons.more_vert,
          //   size: 25,
          // ),
        ],

        // title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Hours",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Minutes",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  ":",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Seconds",
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          Expanded(
            flex:3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textBaseline: TextBaseline.alphabetic,
              children: [
                ScrollableTimeSelector(
                  controller: hourController,
                  timeKeys: hourKeys,
                  selectedTime: (p0) {
                    setState(() {
                      hour = p0;
                    });
                  },
                  label: 'Hours',
                  timeFigures: 24,
                ),
                // DigitSeperator(
                //   seperator: ':',
                //   wheelSelector: true,
                // ),
                ScrollableTimeSelector(
                  timeKeys: minKeys,
                  controller: minuteController,
                  selectedTime: (p0) {
                    setState(() {
                      minutes = p0;
                    });
                  },
                  label: 'Minutes',
                  timeFigures: 60,
                ),
                // DigitSeperator(
                //   seperator: ':',
                //   wheelSelector: true,
                // ),
                ScrollableTimeSelector(
                  timeKeys: secKeys,
                  controller: secondController,
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
            // flex: 5,
            child: ListView.separated(
              itemCount: context.watch<TimerStates>().timers.length,
              padding: EdgeInsets.symmetric(horizontal: width * .02),
              itemBuilder: ((context, index) => TimerTickerPresets(
                    timerModel: context.watch<TimerStates>().timers[index],
                  )),
              separatorBuilder: ((context, index) => SizedBox(
                    width: width * 0.03,
                  )),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * .1, vertical: height * .02),
        child: Button(
          width: width * .6,
          onPressed: () {
            if (Duration(hours: hour, minutes: minutes, seconds: sec)
                    .inSeconds ==
                0) {
              return;
            }
            context.goNamed('ticker',
                extra: Duration(hours: hour, minutes: minutes, seconds: sec)
                    .inSeconds);
          },
          label: 'Start',
          color: theme.primaryColorDark,
        ),
      ),
    );
  }
}

/// Widget for saved and named time presets  on TimerTicker screen.
class TimerTickerPresets extends StatelessWidget {
  final TimerModel timerModel;
  const TimerTickerPresets({Key? key, required this.timerModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Container(
      width: width * 0.25,
      // height: height * 0.1,
      decoration: BoxDecoration(
          // color: Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(width: 3, color: theme.primaryColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat.Hms().format(DateTime.fromMillisecondsSinceEpoch(
                timerModel.countDown.inMilliseconds)),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            timerModel.title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 9),
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
  final List<GlobalKey>? timeKeys;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final FixedExtentScrollController controller;
  ScrollableTimeSelector({
    Key? key,
    required this.selectedTime,
    required this.timeFigures,
    required this.controller,
    this.style,
    required this.label,
    this.labelStyle,
    this.timeKeys,
  }) : super(key: key);

  // FixedExtentScrollController controller = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: height * 0.02),
        //   width: width * 0.25,
        //   child: Center(
        //       child: Text(
        //     label,
        //     style: labelStyle ?? const TextStyle(fontSize: 15),
        //   )),
        // ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: height * 0.3,
          width: width * 0.25,
          child: ListWheelScrollView.useDelegate(
              physics: const ScrollPhysics(parent: FixedExtentScrollPhysics()),
              controller: controller,
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
                          key: (timeKeys != null ||
                                  ((timeKeys ?? []).isNotEmpty))
                              ? timeKeys![index]
                              : null,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            (index).toString().padLeft(2, '0'),
                            style: style ??
                                const TextStyle(
                                    fontSize: 50,
                                    textBaseline: TextBaseline.ideographic),
                          ))))),
        ),
      ],
    );
  }
}
