// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Color primaryColor = Colors.amber;
// Color darkColor = const Color.fromARGB(255, 12, 12, 12);

class Themes {
/* light theme settings */
  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.blueGrey,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 237, 218, 255),
          titleTextStyle: TextStyle(color: Colors.black54),
          toolbarTextStyle: TextStyle(color: Colors.black54),
          iconTheme: IconThemeData(color: Colors.black54),
          textTheme: TextTheme(
              bodyMedium: TextStyle(color: Colors.black54),
              bodySmall: TextStyle(color: Colors.black54),
              bodyLarge: TextStyle(color: Colors.black54))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 237, 218, 255),
          // selectedIconTheme: IconThemeData(color: Colors.purple),
          // unselectedIconTheme: IconThemeData(color: Colors.black54),
          unselectedItemColor: Colors.black54,
          selectedItemColor: Colors.purple,
          selectedLabelStyle: TextStyle(color: Colors.purple),
          unselectedLabelStyle: TextStyle(color: Colors.black54)),
      primaryColor: Color.fromARGB(255, 237, 218, 255),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: CircleBorder(
          side: BorderSide(color: Colors.purple, width: 1.5),
        ),
        backgroundColor: Color.fromARGB(255, 237, 218, 255),
      ),
      primaryColorDark: Colors.purple,
      primaryColorLight: Color.fromARGB(255, 25, 24, 26),
      brightness: Brightness.light,
      cardColor: const Color.fromARGB(255, 237, 218, 255),
      textTheme: const TextTheme(
          bodyMedium:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.black54, fontSize: 20),
          bodySmall: TextStyle(color: Colors.black54)),
      dividerColor: Colors.white12,
      scaffoldBackgroundColor: Colors.white);

  /* Dark theme settings */
  static ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.blueGrey,
      appBarTheme: const AppBarTheme(
        textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 25, 24, 26),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: CircleBorder(
          side: BorderSide(color: Colors.amber, width: 1.5),
        ),
        backgroundColor: Color.fromARGB(255, 25, 24, 26),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 25, 24, 26),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
      ),
      primaryColor: const Color.fromARGB(255, 25, 24, 26),
      primaryColorDark: Colors.amber,
      primaryColorLight: Colors.white,
      brightness: Brightness.dark,
      cardColor: const Color.fromARGB(255, 12, 12, 12),
      textTheme: const TextTheme(
          bodyMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 20)),
      dividerColor: Colors.black12,
      scaffoldBackgroundColor: const Color.fromARGB(255, 12, 12, 12));
}

final double width =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
final double height =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

// extension DateOnlyCompare on DateTime {
//   bool isTomorrow(DateTime day) {
//     // DateTime.now().add(Duration(days: 1)) == day.day;

//     if (DateTime.now().day + 1 == day.day) {
//       return true;
//     } else if (DateTime.now().day > day.day &&
//         DateTime.now().month + 1 == day.month) {
//       return true;
//     } else if (DateTime.now().day > day.day &&
//         DateTime.now().month > day.month &&
//         DateTime.now().year + 1 == day.year) {
//       return true;
//     }
//     return false;
//   }
// }

class TimelyStates with ChangeNotifier {
  final List<Duration> _laps = [];

  List<Duration> get laps => _laps;

  void addLap(Duration lap) {
    _laps.add(lap);
    notifyListeners();
  }
}
