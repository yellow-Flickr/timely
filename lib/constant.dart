// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// Color primaryColor = Colors.amber;
// Color darkColor = const Color.fromARGB(255, 12, 12, 12);

class Themes {
/* light theme settings */
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
          background: Colors.white,
          // primaryContainer: Colors.grey.shade200,
          primary: const Color.fromARGB(255, 237, 218, 255),
          secondary: Colors.grey, // icons
          inversePrimary: Colors.purple // buttons and actions keys
          ),
      primarySwatch: Colors.purple,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 237, 218, 255),
        titleTextStyle: TextStyle(color: Colors.black54),
        toolbarTextStyle: TextStyle(color: Colors.black54),
        iconTheme: IconThemeData(color: Colors.black54),
        // textTheme: TextTheme(
        //     bodyMedium: TextStyle(color: Colors.black54),
        //     bodySmall: TextStyle(color: Colors.black54),
        //     bodyLarge: TextStyle(color: Colors.black54))
      ),
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
      primaryColorDark: const Color.fromRGBO(156, 39, 176, 1),
      primaryColorLight: Color.fromARGB(255, 25, 24, 26),
      cardColor: const Color.fromARGB(255, 237, 218, 255),
      textTheme: const TextTheme(
          bodyMedium:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.black54, fontSize: 20),
          bodySmall: TextStyle(color: Colors.black54)),
      dividerColor: Colors.white12,
      scaffoldBackgroundColor: Colors.white,
      switchTheme: SwitchThemeData(trackOutlineColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Color.fromARGB(255, 237, 218, 255);
        }
        return Colors.grey.shade300;
      }), thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Color.fromARGB(255, 255, 255, 255);
        }
        return Colors.grey.shade500;
      })),
      dividerTheme: DividerThemeData(color: Colors.grey.shade400));

  /* Dark theme settings */
  static ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.blueGrey,
      colorScheme: ColorScheme.dark(
          // background: Colors.white,
          // primaryContainer: Colors.grey.shade200,
          primary: Color.fromARGB(255, 51, 42, 15),
          secondary: Colors.grey, // icons
          inversePrimary: Colors.amber // buttons and actions keys
          ),
      appBarTheme: const AppBarTheme(
        // textTheme: TextTheme(
        //     bodyMedium: TextStyle(color: Colors.white),
        //     bodySmall: TextStyle(color: Colors.white),
        //     bodyLarge: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.white),
        // backgroundColor: Color.fromARGB(255, 25, 24, 26),
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
      // primaryColor: const Color.fromARGB(255, 25, 24, 26),
      primaryColor: Color.fromARGB(255, 51, 42, 15),
      primaryColorDark: Colors.amber,
      // primaryColorLight: Color(0xFF512900),
      brightness: Brightness.dark,
      // cardColor: const Color.fromARGB(255, 12, 12, 12),
      // cardColor: const Color.fromARGB(255, 12, 12, 12),
      switchTheme: SwitchThemeData(trackOutlineColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Color(0xFFFFC107);
        }
        return Color(0xFFFFC107);
      }), trackColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Color(0xFFFFC107);
        }
        return Color.fromARGB(255, 51, 42, 15);
      }), thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Color.fromARGB(255, 255, 255, 255);
        }
        return Colors.grey.shade500;
      })),
      textTheme: const TextTheme(
          bodyMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 20)),
      dividerColor: Colors.black12,
      scaffoldBackgroundColor: const Color.fromARGB(255, 12, 12, 12));
}

final double width =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
final double height =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

extension on Duration {
  DateTime get parseToDateTime =>
      DateTime.fromMicrosecondsSinceEpoch(inMicroseconds);
}
