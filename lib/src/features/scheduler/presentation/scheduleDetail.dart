// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timely/components.dart';
import 'package:timely/constant.dart';
import 'package:timely/src/features/scheduler/domain/scheduleModel.dart'
    as model;

class ScheduleDetail extends StatefulWidget {
  final model.ScheduleModel schedule;
  final bool newschedule;
  const ScheduleDetail(
      {Key? key, required this.schedule, this.newschedule = false})
      : super(key: key);

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {
  Duration repeat = Duration(minutes: 30);
  Duration repeatTill = Duration(hours: 19);
  model.Priority priority = model.Priority.Low;
  TimeOfDay time = DateTime.now().hour > 19
      ? TimeOfDay.fromDateTime(
          DateTime.utc(0).add(Duration(hours: 23, minutes: 59)))
      : TimeOfDay.fromDateTime(
          DateTime.utc(0).add(Duration(hours: 19, minutes: 0)));
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();
  WidgetStatesController button2Controller = WidgetStatesController();
  WidgetStatesController button1Controller = WidgetStatesController();

  bool edit = false;

  @override
  void initState() {
    title.text = widget.schedule.title;
    notes.text = widget.schedule.notes;
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      setState(() {
        if (widget.newschedule) {
          button2Controller.update(WidgetState.disabled, true);
        }
      });
    });
  }

  @override
  void dispose() {
    title.dispose();
    notes.dispose();
    button1Controller.dispose();
    button2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            widget.newschedule ? "New Schedule" : "Schedule Detail",
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          actions: [
            Visibility(
              visible: !edit && !widget.newschedule,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    edit = !edit;
                    button1Controller.update(WidgetState.disabled, true);
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Text(
                      'Edit',
                      style: theme.textTheme.labelLarge
                          ?.copyWith(color: Colors.amber.shade700),
                    )
                    // Visibility(
                    //   child: Button(
                    //       width:   .15,
                    //       color: widget.schedule.active ? Colors.amber.shade700:null  ,
                    //       height: .038,
                    //       onPressed: () {},
                    //       label: widget.schedule.active ? 'Edit' : ''),
                    // ),
                    ),
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: width * .03,
          ),
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height * .02,
            ),
            ListTile(
              onTap: () async {
                await showModalBottomSheet<Duration>(
                  context: context,
                  showDragHandle: true,
                  builder: (context) {
                    // Using Wrap makes the bottom sheet height the height of the content.
                    // Otherwise, the height will be half the height of the screen.
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            time = TimeOfDay.fromDateTime(DateTime.utc(
                              0,
                            ).add(Duration(minutes: 30)));
                            repeat = Duration(
                                hours: time.hour, minutes: time.minute);
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.forward_30),
                          title: Text('30 minutes',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontSize: 10)),
                        ),
                        ListTile(
                          onTap: () {
                            time = TimeOfDay.fromDateTime(DateTime.utc(
                              0,
                            ).add(Duration(hours: 1)));
                            repeat = Duration(
                                hours: time.hour, minutes: time.minute);
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.filter_1),
                          title: Text('1 hour',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontSize: 10)),
                        ),
                        ListTile(
                          onTap: () {
                            time = TimeOfDay.fromDateTime(DateTime.utc(
                              0,
                            ).add(Duration(hours: 2)));
                            repeat = Duration(
                                hours: time.hour, minutes: time.minute);
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.filter_2),
                          title: Text('2 hours',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontSize: 10)),
                        ),
                        ListTile(
                          onTap: () async {
                            time = await showTimePicker(
                                  context: context,
                                  initialEntryMode: TimePickerEntryMode.input,
                                  initialTime: TimeOfDay.fromDateTime(
                                      DateTime.utc(0).add(
                                          Duration(hours: 1, minutes: 30))),
                                  builder: (context, child) => MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!),
                                ) ??
                                TimeOfDay.fromDateTime(DateTime.utc(0)
                                    .add(Duration(hours: 0, minutes: 0)));

                            log(time.toString());
                            repeat = Duration(
                                hours: time.hour, minutes: time.minute);
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.more_time_rounded),
                          title: Text('Custom Duration',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontSize: 10)),
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  setState(() {
                    repeat;
                  });
                });
                // {
                //   time = await showTimePicker(
                //         context: context,
                //         initialEntryMode: TimePickerEntryMode.input,
                //         initialTime: TimeOfDay.fromDateTime(
                //             DateTime.now().add(Duration(hours: 1))),
                //         builder: (context, child) => MediaQuery(
                //             data: MediaQuery.of(context)
                //                 .copyWith(alwaysUse24HourFormat: true),
                //             child: child!),
                //       ) ??
                //       TimeOfDay.fromDateTime(
                //           DateTime.now().add(Duration(hours: 1)));
                // } // TimeOfDay(
                //     hour: TimeOfDay.now().hour + 1,
                //     minute: TimeOfDay.now().minute);
                // log((DateTime.now().add(Duration(days: 1)).day == day.day)
                //     .toString());
                // log(DateTime.now().add(Duration(days: 1)).day.toString());
                // log(day.day.toString());
                // setState(() {});
              },
              enabled: widget.newschedule || edit,
              leading: Icon(Icons.event_repeat_outlined),
              dense: true,
              title: Text(
                'Alert Every',
                style: theme.textTheme.labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
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
                    Text((repeat.inHours != 0
                            ? repeat.inHours.toString().padLeft(2, '0') + 'hr'
                            : '') +
                        ' ' +
                        (repeat.inMinutes % Duration.minutesPerHour)
                            .toString()
                            .padLeft(2, '0') +
                        'min'),
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
              tileColor: theme.cardColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: height * .01,
            ),
            ListTile(
              onTap: () async {
                (showTimePicker(
                  context: context,
                  initialEntryMode: TimePickerEntryMode.input,
                  initialTime: TimeOfDay.fromDateTime(
                      DateTime.utc(0).add(Duration(hours: 19, minutes: 00))),
                  builder: (context, child) => MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!),
                ).then((onValue) {
                  if (onValue == null) {
                    return;
                  }

                  time = onValue;
                  if (Duration(
                              hours: TimeOfDay.now().hour,
                              minutes: TimeOfDay.now().minute)
                          .compareTo(Duration(
                              hours: onValue.hour, minutes: onValue.minute)) >
                      0) {
                     time = revert();
                  }
                  setState(() {
                    repeatTill =
                        Duration(hours: time.hour, minutes: time.minute);
                  });
                }));

                // await showModalBottomSheet<Duration>(
                //   context: context,
                //   showDragHandle: true,
                //   builder: (context) {
                //     // Using Wrap makes the bottom sheet height the height of the content.
                //     // Otherwise, the height will be half the height of the screen.
                //     return Wrap(
                //       children: [
                //         ListTile(
                //           onTap: () {
                //             time = TimeOfDay.fromDateTime(DateTime.utc(
                //               0,
                //             ).add(Duration(minutes: 30)));
                //             repeat = Duration(
                //                 hours: time.hour, minutes: time.minute);
                //             Navigator.pop(context);
                //           },
                //           leading: Icon(Icons.forward_30),
                //           title: Text('30 minutes',
                //               style: theme.textTheme.labelSmall
                //                   ?.copyWith(fontSize: 10)),
                //         ),
                //         ListTile(
                //           onTap: () {
                //             time = TimeOfDay.fromDateTime(DateTime.utc(
                //               0,
                //             ).add(Duration(hours: 1)));
                //             repeat = Duration(
                //                 hours: time.hour, minutes: time.minute);
                //             Navigator.pop(context);
                //           },
                //           leading: Icon(Icons.filter_1),
                //           title: Text('1 hour',
                //               style: theme.textTheme.labelSmall
                //                   ?.copyWith(fontSize: 10)),
                //         ),
                //         ListTile(
                //           onTap: () {
                //             time = TimeOfDay.fromDateTime(DateTime.utc(
                //               0,
                //             ).add(Duration(hours: 2)));
                //             repeat = Duration(
                //                 hours: time.hour, minutes: time.minute);
                //             Navigator.pop(context);
                //           },
                //           leading: Icon(Icons.filter_2),
                //           title: Text('2 hours',
                //               style: theme.textTheme.labelSmall
                //                   ?.copyWith(fontSize: 10)),
                //         ),
                //         ListTile(
                //           onTap: () async {
                //             time = await showTimePicker(
                //                   context: context,
                //                   initialEntryMode: TimePickerEntryMode.input,
                //                   initialTime: TimeOfDay.fromDateTime(
                //                       DateTime.utc(0).add(
                //                           Duration(hours: 1, minutes: 30))),
                //                   builder: (context, child) => MediaQuery(
                //                       data: MediaQuery.of(context).copyWith(
                //                           alwaysUse24HourFormat: true),
                //                       child: child!),
                //                 ) ??
                //                 TimeOfDay.fromDateTime(DateTime.utc(0)
                //                     .add(Duration(hours: 0, minutes: 0)));

                //             log(time.toString());
                //             repeat = Duration(
                //                 hours: time.hour, minutes: time.minute);
                //             Navigator.pop(context);
                //           },
                //           leading: Icon(Icons.more_time_rounded),
                //           title: Text('Custom Duration',
                //               style: theme.textTheme.labelSmall
                //                   ?.copyWith(fontSize: 10)),
                //         ),
                //       ],
                //     );
                //   },
                // ).then((value) {
                //   setState(() {
                //     repeat;
                //   });
                // });
                // {
                //   time = await showTimePicker(
                //         context: context,
                //         initialEntryMode: TimePickerEntryMode.input,
                //         initialTime: TimeOfDay.fromDateTime(
                //             DateTime.now().add(Duration(hours: 1))),
                //         builder: (context, child) => MediaQuery(
                //             data: MediaQuery.of(context)
                //                 .copyWith(alwaysUse24HourFormat: true),
                //             child: child!),
                //       ) ??
                //       TimeOfDay.fromDateTime(
                //           DateTime.now().add(Duration(hours: 1)));
                // } // TimeOfDay(
                //     hour: TimeOfDay.now().hour + 1,
                //     minute: TimeOfDay.now().minute);
                // log((DateTime.now().add(Duration(days: 1)).day == day.day)
                //     .toString());
                // log(DateTime.now().add(Duration(days: 1)).day.toString());
                // log(day.day.toString());
                // setState(() {});
              },
              enabled: widget.newschedule || edit,
              leading: Icon(Icons.event_repeat_outlined),
              dense: true,
              title: Text(
                'Alert Untill',
                style: theme.textTheme.labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
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
                    Text(DateFormat.Hm().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            repeatTill.inMilliseconds))),
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
              tileColor: theme.cardColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: height * .01,
            ),
            ListTile(
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (context) {
                    // Using Wrap makes the bottom sheet height the height of the content.
                    // Otherwise, the height will be half the height of the screen.
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            priority = model.Priority.High;
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.circle,
                            color: Colors.red,
                          ),
                          title: Text('High Priority',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontSize: 10)),
                        ),
                        ListTile(
                          onTap: () {
                            priority = model.Priority.Medium;
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.circle,
                            color: Colors.amber,
                          ),
                          title: Text('Medium Priority',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontSize: 10)),
                        ),
                        ListTile(
                          onTap: () {
                            priority = model.Priority.Low;
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.circle,
                            color: Colors.teal,
                          ),
                          title: Text('Low Priority',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontSize: 10)),
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  setState(() {});
                });
              },
              enabled: widget.newschedule || edit,
              leading: Icon(Icons.low_priority),
              dense: true,
              title: Text(
                'Priority',
                style: theme.textTheme.labelSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * .015, horizontal: width * .04),
                decoration: ShapeDecoration(
                    // color: theme.primaryColor.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${priority.name} Priority'),
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
              tileColor: theme.cardColor,
              shape: RoundedRectangleBorder(
                  // side: BorderSide(color: theme.primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
            ),

            Divider(),
            SizedBox(
              height: height * .01,
            ),
            TextField(
              maxLines: 1,
              style: theme.textTheme.bodySmall,
              controller: title,
              readOnly: !(widget.newschedule || edit),
              decoration: InputDecoration(
                  fillColor: theme.highlightColor,
                  isDense: true,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.title_rounded,
                    color: Colors.grey,
                  ),
                  hintText: 'Schedule Title',
                  counterText: '',
                  border: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(
              height: height * .025,
            ),
            TextField(
              // maxLength: 30,
              // style: TextStyle(),
              readOnly: !(widget.newschedule || edit),
              maxLines: 12, maxLength: 500,
              controller: notes,
              style: theme.textTheme.bodySmall,
              decoration: InputDecoration(
                isCollapsed: true,
                fillColor: theme.highlightColor,
                filled: true,
                prefixIcon: Icon(
                  Icons.note_alt,
                  color: Colors.grey,
                ),
                hintText: 'Schedule Notes',
                counterText: '',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),

            // SizedBox(
            //   height: height * .01,
            // ),
            // ListTile(
            //   onTap: () async {
            //     day = await showDatePicker(
            //             context: context,
            //             initialDate: DateTime.now(),
            //             firstDate: DateTime.now(),
            //             lastDate: DateTime(DateTime.now().year + 1,
            //                 DateTime.now().month)) ??
            //         DateTime.now();
            //     // log((DateTime.now().add(Duration(days: 1)).day == day.day)
            //     //     .toString());
            //     // log(DateTime.now().add(Duration(days: 1)).day.toString());
            //     // log(day.day.toString());
            //     setState(() {});
            //   },
            //   leading: Icon(Icons.calendar_month),
            //   dense: true,
            //   title: Text(
            //     'Date',
            //     style: theme.textTheme.labelSmall
            //         ?.copyWith(fontWeight: FontWeight.bold),
            //   ),
            //   trailing: Container(
            //     padding: EdgeInsets.symmetric(
            //         vertical: height * .015, horizontal: width * .06),
            //     decoration: ShapeDecoration(
            //         color: theme.primaryColor.withOpacity(0.4),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10))),
            //     child: Text(
            //         DateTime.now().add(Duration(days: 1)).day == day.day
            //             ? 'TOMORROW'
            //             : day.difference(DateTime.now()).inDays == 0
            //                 ? 'TODAY'
            //                 : DateFormat.yMMMMEEEEd().format(day)),
            //   ),
            //   tileColor: theme.cardColor,
            //   shape: RoundedRectangleBorder(
            //       // side: BorderSide(color: theme.primaryColor, width: 1.5),
            //       borderRadius: BorderRadius.circular(10)),
            // ),
            // SizedBox(
            //   height: height * .01,
            // ),
            // ListTile(
            //   onTap: () async {
            //     time = await showTimePicker(
            //           context: context,
            //           initialTime: TimeOfDay.fromDateTime(
            //               DateTime.now().add(Duration(hours: 1))),
            //         ) ??
            //         TimeOfDay.fromDateTime(
            //             DateTime.now().add(Duration(hours: 1)));
            //     // TimeOfDay(
            //     //     hour: TimeOfDay.now().hour + 1,
            //     //     minute: TimeOfDay.now().minute);
            //     // log((DateTime.now().add(Duration(days: 1)).day == day.day)
            //     //     .toString());
            //     // log(DateTime.now().add(Duration(days: 1)).day.toString());
            //     // log(day.day.toString());
            //     setState(() {});
            //   },
            //   leading: Icon(Icons.timer_sharp),
            //   dense: true,
            //   title: Text(
            //     'Time',
            //     style: theme.textTheme.labelSmall
            //         ?.copyWith(fontWeight: FontWeight.bold),
            //   ),
            //   trailing: Container(
            //     padding: EdgeInsets.symmetric(
            //         vertical: height * .015, horizontal: width * .06),
            //     decoration: ShapeDecoration(
            //         color: theme.cardColor,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10))),
            //     child: Text(time.hour.toString().padLeft(2, '0') +
            //         ':' +
            //         time.minute.toString().padLeft(2, '0')),
            //   ),
            //   tileColor: theme.cardColor,
            //   shape: RoundedRectangleBorder(
            //       // side: BorderSide(color: theme.primaryColor, width: 1.5),
            //       borderRadius: BorderRadius.circular(5)),
            // ),

            SizedBox(
              height: height * .1,
            ),

            Column(
              children: [
                Visibility(
                  visible: !widget.newschedule,
                  replacement: Button(
                      width: .9,
                      color: Colors.teal,
                      height: .05,
                      onPressed: () {
                        context.pushReplacementNamed('schedule-detail', extra: {
                          'schedule': model.testSchedule.first,
                          'new-schedule': false
                        });
                      },
                      label: 'Save'),
                  child: Button(
                      width: .9,
                      statesController: button1Controller,
                      color: widget.schedule.active
                          ? theme.primaryColorLight
                          : theme.primaryColorDark,
                      height: .05,
                      onPressed: () {},
                      label:
                          widget.schedule.active ? 'Deactivate' : 'Activate'),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Button(
                    width: .9,
                    color: !edit ? theme.colorScheme.error : Colors.amber,
                    height: .05,
                    statesController: button2Controller,
                    onPressed: () {
                      if (edit) {
                        setState(() {
                          edit = false;
                          button1Controller.update(WidgetState.disabled, false);
                        });
                      }
                    },
                    label: !edit ? 'Delete' : 'Update'),
              ],
            ),
          ],
        ));
  }

  revert() {
    return DateTime.now().hour > 19
        ? TimeOfDay.fromDateTime(
            DateTime.utc(0).add(Duration(hours: 23, minutes: 59)))
        : TimeOfDay.fromDateTime(
            DateTime.utc(0).add(Duration(hours: 19, minutes: 0)));
  }
}
