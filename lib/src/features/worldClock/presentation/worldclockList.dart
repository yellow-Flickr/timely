// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timely/src/features/worldClock/presentation/worldClockController.dart';
import 'package:timezone/timezone.dart' as tz;

class WorldClockList extends StatefulWidget {
  const WorldClockList({Key? key}) : super(key: key);

  @override
  State<WorldClockList> createState() => _WorldClockListState();
}

class _WorldClockListState extends State<WorldClockList> {
  @override
  void initState() {
    // var locations = tz.timeZoneDatabase.locations;
    // print(tz.TZDateTime.now(tz.getLocation(zone)));

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
            "World Clock List",
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  // color: theme.primaryColorDark,
                ))
          ],
        ),
        body: ListView.separated(
          itemCount: tz.timeZoneDatabase.locations.keys
              .toList()
              .where((value) =>
                  !context.read<WorldClockStates>().timezones.contains(value))
              .toList()
              .length,
          padding: EdgeInsets.symmetric(
              horizontal: width * .03, vertical: height * .01),
          itemBuilder: (context, index) => WorldClockListItem(
            zone: tz.timeZoneDatabase.locations.keys
                .toList()
                .where((value) =>
                    !context.read<WorldClockStates>().timezones.contains(value))
                .toList()[index],
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: height * .01,
          ),
        ));
  }
}

/// Widget for saved and named time presets  on Worldclock screen.
class WorldClockListItem extends StatelessWidget {
  final String zone;
  const WorldClockListItem({Key? key, required this.zone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);
    final time = tz.TZDateTime.now(tz.getLocation(zone));
    return GestureDetector(
      onTap: () {
        if (context.read<WorldClockStates>().timezones.contains(zone)) {
          return;
        }
        context.read<WorldClockStates>().addTimezone(zone);
        context.pop();
      },
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
                        Icons.language,
                        // color: Colors.redAccent,
                        size: 10,
                      ),
                      SizedBox(
                        width: width * .01,
                      ),
                      Text(
                        zone.replaceAll('_', ' '),
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
                        Icons.access_time_rounded,
                        // color: Colors.redAccent,
                        size: 10,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "GMT " +
                            ((time.timeZoneOffset.inHours.isNegative
                                    ? ""
                                    : "+") +
                                (time.timeZoneOffset.inHours
                                    .toString()
                                    .padLeft(2, '0'))) +
                            'HRS ' +
                            DateFormat('mm').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    time.timeZoneOffset.inMilliseconds)) +
                            "mins",
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
              child: Container(
                child: Text(
                  DateFormat.Hm().format(time),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
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
