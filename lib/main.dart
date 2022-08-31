// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timely/Stopwatch.dart';
import 'package:timely/Timer.dart';
import 'package:timely/Worldclock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
int _currentIndex =0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
    
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Timely",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                )),
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey.shade900,
    
            // iconSize: 16,
            // selectedFontSize: 10,
            // unselectedFontSize: 8,
            currentIndex: _currentIndex,
            onTap: (index)
            {
              setState(() {
                 _currentIndex = index;
              });
            },
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(label: "Timer", icon: Icon(Icons.timer)),
              BottomNavigationBarItem(
                  label: "Stopwatch", icon: Icon(Icons.timer_10_select_sharp)),
              BottomNavigationBarItem(
                  label: "World Clock", icon: Icon(Icons.public)),
              BottomNavigationBarItem(
                  label: "Scheduler", icon: Icon(Icons.event_note)),
            ],
            elevation: 0,
          ),
          body:
             (_currentIndex == 0)? Timer() :(_currentIndex == 1)? StopWatch(): Worldclock()
             
             ),
    );
    //   ],
    // ));
  }
}
