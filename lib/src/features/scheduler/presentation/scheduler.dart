// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
 import 'package:timely/src/features/scheduler/domain/scheduleModel.dart';
 
class Scheduler extends StatefulWidget {
  const Scheduler({Key? key}) : super(key: key);

  @override
  State<Scheduler> createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
   @override
  void initState() {
     super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => context.goNamed('schedule-detail', extra: {
                      'schedule': ScheduleModel(id: 0, title: '', notes: ''),
                      'new-schedule': true
                    }),
                icon: Icon(
                  Icons.add_alert_outlined,
                  // color: theme.primaryColorDark,
                ))
          ],
        ),
        body: ListView.separated(
          itemCount: testSchedule.length,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * .01),
          itemBuilder: (context, index) => ScheduleItem(
            schedule: testSchedule[index],
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: height * .01,
          ),
        ));
  }
}



/// Widget for saved Schedules.
class ScheduleItem extends StatelessWidget {
  final ScheduleModel schedule;
  const ScheduleItem({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.goNamed('schedule-detail',
          extra: {'schedule': schedule, 'new-schedule': false}),
      child: Container(
        // width: width * 0.26,
        // height: height * 0.1,
        padding: EdgeInsets.symmetric(
            vertical: height * .005, horizontal: width * .02),
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
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Colors.redAccent,
                        size: 10,
                      ),
                      SizedBox(
                        width: width * .01,
                      ),
                      Text(
                        schedule.title,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .005,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.replay_sharp,
                        // color: Colors.redAccent,
                        size: 10,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Hourly",
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
              child: Transform.scale(
                scale: .75,
                child: Switch(
                  value: schedule.active,
                  onChanged: (value) {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}