// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timely/src/features/worldClock/presentation/worldClockController.dart';
import 'package:timely/src/features/worldClock/presentation/worldclockList.dart';
import 'package:timezone/timezone.dart' as tz;

class Worldclock extends StatefulWidget {
  const Worldclock({Key? key}) : super(key: key);

  @override
  State<Worldclock> createState() => _WorldclockState();
}

class _WorldclockState extends State<Worldclock> {
  // bool expanded = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
  tz.Location? location = tz.getLocation(DateTime.now().timeZoneName);
     return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: theme.primaryColor,
            automaticallyImplyLeading: false,

            // stretch: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text('WorldClock'),

            // stretch: true,
            actions: [
              IconButton(
                onPressed: () => context.goNamed(
                  'add-worldclock',
                ),
                icon: Icon(
                  Icons.add,
                  size: 25,
                ),
              ),
            ],
            // onStretchTrigger: () async {
            //   setState(() {
            //     expanded = !expanded;
            //   });
            //   log('message');
            // },
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(height * .10),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text(
                          MaterialLocalizations.of(context).formatTimeOfDay(
                            TimeOfDay.now(),
                            alwaysUse24HourFormat: true,
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 45,
                          ),
                        )
                      ],
                    ),
                    Text(

                        "GMT " +
                            ((DateTime.now().timeZoneOffset.inHours.isNegative
                                    ? ""
                                    : "+") +
                                (DateTime.now().timeZoneOffset.inHours
                                    .toString()
                                    .padLeft(2, '0'))) +
                            'HRS ' +
                            DateFormat('mm').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    DateTime.now().timeZoneOffset.inMilliseconds)) +
                            "mins"
   // .getLocation(DateTime.now().millisecondsSinceEpoch).
//                          "GMT " +
//                             ((                      tz.local.currentTimeZone
// .timeZoneOffset.inHours.isNegative
//                                     ? ""
//                                     : "+") +
//                                 (time.timeZoneOffset.inHours
//                                     .toString()
//                                     .padLeft(2, '0'))) +
//                             'HRS ' +
//                             DateFormat('mm').format(
//                                 DateTime.fromMillisecondsSinceEpoch(
//                                     time.timeZoneOffset.inMilliseconds)) +
//                             "mins",
                        
                      // .timeZoneFromLocal(
                      //     DateTime.now().microsecondsSinceEpoch)
                      ,
                      style: TextStyle(
                          fontSize: 13,
                          color: theme.primaryColorLight.withOpacity(0.6)),
                    ),
                    SizedBox(
                      height: height * .01,
                    )
                  ],
                ),
              ),
            )),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: width * .03, vertical: height * .01),
          itemBuilder: ((context, index) {
            return WorldClockListItem(
                zone: context.read<WorldClockStates>().timezones[index]);
          }),
          itemCount: context.watch<WorldClockStates>().timezones.length,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: height * .01,
          ),
        ));
  }
}

// /// Widget for saved and named time presets  on Worldclock screen.
// class ClockItem extends StatelessWidget {
//   const ClockItem({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     var theme = Theme.of(context);

//     return Container(
//       // width: width * 0.26,
//       height: height * 0.10,
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       decoration: ShapeDecoration(
//         color: theme.primaryColor.withOpacity(0.4),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 child: const Text(
//                   "Accra",
//                   textAlign: TextAlign.left,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               Container(
//                 child: const Text(
//                   "Local time zone",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(fontSize: 10),
//                 ),
//               )
//             ],
//           ),
//           Container(
//             child: const Text(
//               "00:00",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 35,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
