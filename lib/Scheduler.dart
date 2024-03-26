// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timely/ViewModel.dart';
import 'package:timely/components.dart';
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
            IconButton(
                onPressed: () => context.pushNamed('add-schedule'),
                icon: Icon(
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
