// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timely/constant.dart';
import 'package:timely/models/scheduleModel.dart';

class ScheduleDetail extends StatefulWidget {
  final ScheduleModel schedule;
  const ScheduleDetail({Key? key, required this.schedule}) : super(key: key);

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {
  DateTime day = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  @override
  void initState() {
    title.text = widget.schedule.title;
    notes.text = widget.schedule.notes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Schedule Detail",
          ),
          automaticallyImplyLeading: false,
          elevation: 0,

          // title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .03, vertical: height * .02),
            child: Column(
              children: [
                SizedBox(
                  height: height * .01,
                ),
                ListTile(
                  onTap: () async {},
                  leading: Icon(Icons.event_repeat_outlined),
                  dense: true,
                  title: Text(
                    'Repeat',
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
                  tileColor: theme.cardColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  height: height * .01,
                ),
                ListTile(
                  onTap: () async {},
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
                  height: height * .01,
                ),
                TextField(
                  // maxLength: 30,
                  // style: TextStyle(),
                  maxLines: 8, maxLength: 500,
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
                  height: height * .01,
                ),
              ],
            ),
          ),
        ));
  }
}
