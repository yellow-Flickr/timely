// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:timely/components.dart';

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
              Icon(
                Icons.add,
                size: 25,
              ),
              Icon(
                Icons.more_vert,
                size: 25,
              ),
            ],
            // onStretchTrigger: () async {
            //   setState(() {
            //     expanded = !expanded;
            //   });
            //   log('message');
            // },
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(height * .12),
              child: Container(
                child: Center(
                  child: FittedBox(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TimeDigits(digits: 0.toString().padLeft(2, '0')),
                            DigitSeperator(seperator: ':'),
                            TimeDigits(digits: 0.toString().padLeft(2, '0')),
                            DigitSeperator(seperator: ':'),
                            TimeDigits(digits: 0.toString().padLeft(2, '0')),
                          ],
                        ),
                        Text(
                          "Greenwich Mean Time",
                          style: TextStyle(
                              fontSize: 13,
                              color: theme.primaryColorLight.withOpacity(0.6)),
                        ),
                        SizedBox(
                          height: height * .015,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: width * .03, vertical: height * .01),
          itemBuilder: ((context, index) {
            return ClockItem();
          }),
          itemCount: 15,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: height * .01,
          ),
        ));
  }
}
