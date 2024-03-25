// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/ViewModel.dart';
import 'package:timely/models/scheduleModel.dart';

class Scheduler extends StatefulWidget {
  const Scheduler({Key? key}) : super(key: key);

  @override
  State<Scheduler> createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  ViewModel app = ViewModel();
  @override
  void initState() {
    app = ViewModel();
    super.initState();
  }

  @override
  void dispose() {
    app.starter.dispose();
    app.timing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     context.pushNamed('add-schedule');
        //   },
        //   child: Icon(
        //     Icons.add_alert_outlined,
        //     color: theme.primaryColorDark,
        //   ),
        // ),
        appBar: AppBar(
          title: Text(
            "Scheduler",
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
actions: [
  IconButton(onPressed:() =>             context.pushNamed('add-schedule')
, icon: Icon(
            Icons.add_alert_outlined,
            // color: theme.primaryColorDark,
          ))
],

        ),
        body: ListView.separated(
          itemCount: 20,
          padding: EdgeInsets.symmetric(
              horizontal: width * .03, vertical: height * .01),
          itemBuilder: (context, index) => ScheduleItem(),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: height * .01,
          ),
        ));
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
      onTap: () =>     context.goNamed('schedule-detail', 
                      extra:
                          testSchedule),
      child: Container(
        // width: width * 0.26,
        // height: height * 0.1,
        padding:
            EdgeInsets.symmetric(vertical: height * .01, horizontal: width * .02),
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
                  ), Text(
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
