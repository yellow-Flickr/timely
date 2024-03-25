// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timely/Components.dart';

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
                            Minutes(digits: "00"),
                            DigitSeperator(seperator: ':'),
                            Minutes(digits: "00"),
                            DigitSeperator(seperator: ':'),
                            Minutes(digits: "00"),
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
          padding: EdgeInsets.symmetric(horizontal: width *.03, vertical: height * .01),
            itemBuilder: ((context, index) {
              return ClockItem();
            }),
            itemCount: 15, separatorBuilder: (BuildContext context, int index)=>SizedBox(height: height *.01,),));
  }
}

class Seconds extends StatelessWidget {
  final String digits;

  const Seconds({Key? key, required this.digits}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          // margin: EdgeInsets.only(bottom: 15),
          height: height * 0.1,
          width: width * 0.22,
          child: Center(
              // alignment: Alignment.bottomCenter,
              child: Text(
            digits,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 60),
          )),
        ),
      ],
    );
  }
}

class Minutes extends StatelessWidget {
  final String digits;
  const Minutes({Key? key, required this.digits}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        Center(
            child: Text(
          digits,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 50,
              color: theme.primaryColorLight.withOpacity(.9)),
        )),
      ],
    );
  }
}

/// Widget for saved and named time presets  on Worldclock screen.
class ClockItem extends StatelessWidget {
  const ClockItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return Container(
      // width: width * 0.26,
       height: height * 0.10,
      padding: EdgeInsets.symmetric(  horizontal: 15),
      decoration: ShapeDecoration(
        color: theme.primaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),  ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Accra",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Text(
                  "Local time zone",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
          Container(
            child: Text(
              "00:00",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Returns clock numbers to appear as double digits eg. 00, 01, 33, 44.
String doubleDigits(int number) {
  return number.toString().length == 1 ? "0$number" : number.toString();
}
