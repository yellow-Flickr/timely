// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Worldclock extends StatefulWidget {
  const Worldclock({Key? key}) : super(key: key);

  @override
  State<Worldclock> createState() => _WorldclockState();
}

class _WorldclockState extends State<Worldclock> {
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          automaticallyImplyLeading: false,
          floating: true,
          pinned: true,
          // onStretchTrigger: () async {
          //   setState(() {
          //     expanded = !expanded;
          //   });
          // },
          // snap: true,
          elevation: 0,
          expandedHeight: height * 0.3,
          bottom: AppBar(
            primary: false,
            backgroundColor: Colors.grey.shade900,

              
            // title: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "Timely",
            //       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            //     )),
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              Icon(
                Icons.add,
                size: 35,
              ),
              Icon(
                Icons.more_vert,
                size: 35,
              ),
            ],

            // title: Text(widget.title),
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(top: height * 0.1),
            centerTitle: true, 
            title: Center(
              child: Container(
                width: width * 0.3,
                height: height * 0.05,
                child: FittedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Minutes(digits: "00"),
                          Minutes(digits: "00"),
                          Minutes(digits: "00"),
                        ],
                      ),
                      Text(
                        "Greenwich Mean Time",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
     
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(((context, index) {
          return ClockItem();
        }), childCount: 15))
      ],
    );
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
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 60),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          // margin: EdgeInsets.only(bottom: 15),
          height: height * 0.1,
          width: width * 0.22,
          // padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Center(
              child: Text(
            digits,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 60),
          )),
        ),
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
    return Container(
      // width: width * 0.26,
      margin: EdgeInsets.symmetric(vertical: height * 0.015),
      height: height * 0.12,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: ShapeDecoration(
        color: Colors.grey.shade800.withOpacity(0.4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), side: BorderSide.none),
      ),
      child: Center(
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Text(
                    "Local time zone",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 10),
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
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Returns clock numbers to appear as double digits eg. 00, 01, 33, 44.
String doubleDigits(int number) {
  return number.toString().length == 1 ? "0$number" : number.toString();
}
