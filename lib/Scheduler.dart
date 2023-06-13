// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/ViewModel.dart';

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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed('add-schedule');
          },
          child: Icon(
            Icons.add_alert_outlined,
            color: theme.primaryColorDark,
          ),
        ),
        appBar: AppBar(
          backgroundColor: theme.primaryColor,

          title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Scheduler",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              )),
          automaticallyImplyLeading: false,
          elevation: 0,

          // title: Text(widget.title),
        ),
        body: ListView(
          children: List.generate(20, (index) => ScheduleItem()),
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

    return Container(
      // width: width * 0.26,
      margin: EdgeInsets.symmetric(vertical: height * 0.015),
      height: height * 0.12,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: ShapeDecoration(
        color: theme.primaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), side: BorderSide.none),
      ),
      child: Center(
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
                  Container(
                    child: Text(
                      "Pomodoro Workout",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle_notifications_outlined,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "High Priority",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  "Hourly",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
