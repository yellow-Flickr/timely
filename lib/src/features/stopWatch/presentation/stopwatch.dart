// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:timely/components.dart';
import 'package:timely/src/features/stopWatch/presentation/stopwatchController.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<StopWatch>
    with SingleTickerProviderStateMixin {
  Duration overall = Duration.zero;
  Duration lap = Duration.zero;
  late Ticker animationTicker;
  final Stopwatch lapTimer = Stopwatch();
  final Stopwatch overallTimer = Stopwatch();

  StreamController<StopWatch> stopwatchController =
      StreamController<StopWatch>();

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StopWatchStates>().clearLaps();

      animationTicker = createTicker((elapsed) {
        setState(() {});
      });
    });
    // animationTicker.
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(height * .16),
          child: Column(
            children: [
              Consumer<StopWatchStates>(
                builder: (BuildContext context, value, Widget? child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 5),
                      child: TimeDigits(
                        width: width * .17,
                        height: height * .10,
                        digits: (overallTimer.elapsed.inMinutes.ceil())
                            .toString()
                            .padLeft(2, '0'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                        ),
                        key: ValueKey<int>(
                            overallTimer.elapsed.inMinutes.ceil()),
                      ),
                    ),
                    DigitSeperator(seperator: ":"),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 2),
                      child: TimeDigits(
                        width: width * .17,
                        height: height * .10,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 50,
                        ),
                        digits: (overallTimer.elapsed.inSeconds.ceil() %
                                Duration.secondsPerMinute)
                            .toString()
                            .padLeft(2, '0'),
                        key: ValueKey<int>(
                            overallTimer.elapsed.inSeconds.ceil() %
                                Duration.secondsPerMinute),
                      ),
                    ),
                    DigitSeperator(seperator: "."),
                    AnimatedSwitcher(
                      duration: Duration(microseconds: 1),
                      child: TimeDigits(
                        width: width * .2,
                        height: height * .10,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                        ),
                        digits: (overallTimer.elapsed.inMilliseconds.ceil() %
                                Duration.millisecondsPerSecond)
                            .toString()
                            .padLeft(3, '0'),
                        key: ValueKey<int>(
                            overallTimer.elapsed.inMilliseconds.ceil() %
                                Duration.millisecondsPerSecond),
                      ),
                    ),
                  ],
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.baseline,
                //   textBaseline: TextBaseline.ideographic,
                //   children: [
                //     AnimatedSwitcher(
                //       duration: Duration(milliseconds: 5),
                //       child: TimeDigits(
                //         width: width * .17,
                //         height: height * .10,
                //         digits: (overallTimer.elapsed.inMinutes.ceil())
                //             .toString()
                //             .padLeft(2, '0'),
                //         style: theme.textTheme.bodyMedium?.copyWith(
                //           fontWeight: FontWeight.w600,
                //           fontSize: 50,
                //         ),
                //         key: ValueKey<int>(overallTimer.elapsed.inMinutes.ceil()),
                //       ),
                //     ),
                //     DigitSeperator(seperator: ":"),
                //     AnimatedSwitcher(
                //       duration: Duration(milliseconds: 2),
                //       child: TimeDigits(
                //         width: width * .17,
                //         height: height * .10,
                //         style: theme.textTheme.bodyMedium?.copyWith(
                //           fontWeight: FontWeight.w600,
                //           fontSize: 50,
                //         ),
                //         digits: (overallTimer.elapsed.inSeconds.ceil() %
                //                 Duration.secondsPerMinute)
                //             .toString()
                //             .padLeft(2, '0'),
                //         key: ValueKey<int>(overallTimer.elapsed.inSeconds.ceil() %
                //             Duration.secondsPerMinute),
                //       ),
                //     ),
                //     DigitSeperator(seperator: "."),
                //     AnimatedSwitcher(
                //       duration: Duration(microseconds: 1),
                //       child: TimeDigits(
                //         width: width * .2,
                //         height: height * .10,
                //         style: theme.textTheme.bodyMedium?.copyWith(
                //           fontWeight: FontWeight.w600,
                //           fontSize: 40,
                //         ),
                //         digits: (overallTimer.elapsed.inMilliseconds.ceil() %
                //                 Duration.millisecondsPerSecond)
                //             .toString()
                //             .padLeft(3, '0'),
                //         key: ValueKey<int>(
                //             overallTimer.elapsed.inMilliseconds.ceil() %
                //                 Duration.millisecondsPerSecond),
                //       ),
                //     ),
                //   ],
                // ),
              ),

              ///Lap timer
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
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      TimeDigits(
                        width: width * .14,
                        height: height * .10,
                        digits: (lapTimer.elapsed.inMinutes.ceil())
                            .toString()
                            .padLeft(2, '0'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                        ),
                      ),
                      DigitSeperator(seperator: ":"),
                      TimeDigits(
                        width: width * .14,
                        height: height * .10,
                        digits: (lapTimer.elapsed.inSeconds.ceil() %
                                Duration.secondsPerMinute)
                            .toString()
                            .padLeft(2, '0'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                        ),
                      ),
                      DigitSeperator(seperator: "."),
                      TimeDigits(
                        width: width * .2,
                        height: height * .10,
                        digits: (lapTimer.elapsed.inMilliseconds.ceil() %
                                Duration.millisecondsPerSecond)
                            .toString()
                            .padLeft(3, '0'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.06, vertical: height * 0.01),
        child: Container(
          // height: height * 0.45,
          // padding: EdgeInsets.only(
          //     /* left: width * 0.05, right: width * 0.05, */ top:
          //         height * 0.01),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Lap",
                            style: theme.textTheme.labelSmall
                                ?.copyWith(fontWeight: FontWeight.w600)
                            // TextStyle(
                            //     color: theme.primaryColorLight
                            //         .withOpacity(.7),
                            //     fontWeight: FontWeight.w500,
                            //     fontSize: 14)
                            ),
                        Text("Lap Times",
                            style: theme.textTheme.labelSmall
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        Text("Overall time",
                            style: theme.textTheme.labelSmall
                                ?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Divider(
                    endIndent: width * 0.03,
                    height: 0,
                    indent: width * 0.03,
                    thickness: 1,
                    color: theme.primaryColorLight.withOpacity(.7),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  // reverse: true,
                  children: List.generate(
                      context.watch<StopWatchStates>().laps.length,
                      (index) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.018),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((index + 1).toString().padLeft(2,'0'),
                                    style: theme.textTheme.bodySmall),
                                Text(
                                    lapOutputFormat(context
                                        .watch<StopWatchStates>()
                                        .laps[index]
                                        .$1),
                                    style: theme.textTheme.bodySmall),
                                Text(
                                    lapOutputFormat(context
                                        .watch<StopWatchStates>()
                                        .laps[index]
                                        .$2),
                                    style: theme.textTheme.bodySmall),
                              ],
                            ),
                          )).reversed.toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * .1, vertical: height * .02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              onPressed: () {
                if (overallTimer.isRunning) {
                  context
                      .read<StopWatchStates>()
                      .addLap((lapTimer.elapsed, overallTimer.elapsed));
                  lapTimer.reset();
                } else {
                  setState(() {
                    overallTimer.reset();
                    lapTimer.reset();
                    context.read<StopWatchStates>().clearLaps();
                  });
                }
                // ..start();
              },
              height: .05,
              label: (overallTimer.isRunning ||
                      (overallTimer.elapsed == Duration.zero))
                  ? "Lap"
                  : "Reset",
              color: (overallTimer.isRunning ||
                      (overallTimer.elapsed == Duration.zero))
                  ? Theme.of(context).disabledColor
                  : Colors.red.shade700,
            ),
            Button(
              onPressed: () {
                setState(() {
                  if (overallTimer.isRunning) {
                    // tick.stop();
                    overallTimer.stop(/* canceled: true */);
                    lapTimer.stop();
                    animationTicker.stop();
                  } else {
                    animationTicker.start();
                    overallTimer.start();
                    lapTimer
                        // ..reset()
                        .start();
                    // tick.start();
                  }
                });
              },
              height: .05,
              color: !overallTimer.isRunning
                  ? Theme.of(context).primaryColorDark
                  : Colors.red.shade700,
              label: /* overall==Duration.zero ?  "Start" : */
                  (overallTimer.isRunning) ? 'Pause' : 'Start',
            ),
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
      padding: const EdgeInsets.all(10),
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
              child: const Text(
                "Workout Rest",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            Container(
              child: const Text(
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
