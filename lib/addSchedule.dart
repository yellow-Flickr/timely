// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timely/constant.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  DateTime day = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,

          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Scheduler",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              )),
          automaticallyImplyLeading: false,
          elevation: 0,

          // title: Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: width * .03, right: width * .03, top: height * .02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  maxLength: 30,
                  // style: TextStyle(),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.title_rounded,
                        color: theme.primaryColorLight,
                      ),
                      hintText: 'Schedule Title',
                      counterText: '',
                      border: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide(
                              color: theme.primaryColor.withOpacity(0.4),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(15))),
                ),
                Divider(),
                TextField(
                  // maxLength: 30,
                  // style: TextStyle(),
                  maxLines: 10, maxLength: 500,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.note_alt,
                        color: theme.primaryColorLight,
                      ),
                      hintText: 'Schedule Notes',
                      counterText: '',
                      border: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide: BorderSide(
                              color: theme.primaryColor.withOpacity(0.4),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(15))),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    day = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1,
                                DateTime.now().month)) ??
                        DateTime.now();
                    // log((DateTime.now().add(Duration(days: 1)).day == day.day)
                    //     .toString());
                    // log(DateTime.now().add(Duration(days: 1)).day.toString());
                    // log(day.day.toString());
                    setState(() {});
                  },
                  leading: Icon(Icons.calendar_month),
                  dense: true,
                  title: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * .015, horizontal: width * .06),
                    decoration: ShapeDecoration(
                        color: theme.primaryColor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                        DateTime.now().add(Duration(days: 1)).day == day.day
                            ? 'TOMORROW'
                            : day.difference(DateTime.now()).inDays == 0
                                ? 'TODAY'
                                : DateFormat.yMMMMEEEEd().format(day)),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: theme.primaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              DateTime.now().add(Duration(hours: 1))),
                        ) ??
                        TimeOfDay.fromDateTime(
                            DateTime.now().add(Duration(hours: 1)));
                    // TimeOfDay(
                    //     hour: TimeOfDay.now().hour + 1,
                    //     minute: TimeOfDay.now().minute);
                    // log((DateTime.now().add(Duration(days: 1)).day == day.day)
                    //     .toString());
                    // log(DateTime.now().add(Duration(days: 1)).day.toString());
                    // log(day.day.toString());
                    setState(() {});
                  },
                  leading: Icon(Icons.timer_sharp),
                  dense: true,
                  title: Text(
                    'Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * .015, horizontal: width * .06),
                    decoration: ShapeDecoration(
                        color: theme.primaryColor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(time.hour.toString().padLeft(2, '0') +
                        ':' +
                        time.minute.toString().padLeft(2, '0')),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: theme.primaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Divider(),
                ListTile(
                  onTap: () async {},
                  leading: Icon(Icons.event_repeat_outlined),
                  dense: true,
                  title: Text(
                    'Repeat',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * .015, horizontal: width * .04),
                    decoration: ShapeDecoration(
                        color: theme.primaryColor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: theme.primaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Divider(),
                ListTile(
                  onTap: () async {},
                  leading: Icon(Icons.low_priority),
                  dense: true,
                  title: Text(
                    'Priority',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: height * .015, horizontal: width * .04),
                    decoration: ShapeDecoration(
                        color: theme.primaryColor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: theme.primaryColor, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Divider(),
              ],
            ),
          ),
        ));
  }
}
