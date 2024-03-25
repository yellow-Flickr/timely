import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade100,
        primaryContainer: Colors.grey.shade200,
        primary: const Color(0xFFB6E1FF),
        secondary: const Color(0xFF75A1D9), // icons
        inversePrimary: const Color(0xFF336699) // buttons and actions keys
        ),
        highlightColor: Colors.grey.shade200,
    // c
    // buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF336699)),
    checkboxTheme:   CheckboxThemeData(
      fillColor:   MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF336699);
        }
        return Colors.transparent;
      }),
        side: BorderSide(color: Color(0xFF336699), width: 2,
        )),
    radioTheme: RadioThemeData(
      fillColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        // if (states.contains(MaterialState.selected)) {
        //   return Color(0xFF480674);
        // }
        return const Color(0xFF336699);
      }),
    ),
    switchTheme: SwitchThemeData(
      trackColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF336699);
        }
        return Colors.grey.shade300;
      }),
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }
        return Colors.grey;
      }),
      trackOutlineColor: MaterialStateProperty.all<Color>(Colors.transparent),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white60,
      indicatorColor: Color(0xFF336699),
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF336699),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat'),
    ),
    textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[800],
        displayColor: Colors.black,
        fontFamily: 'Montserrat'));




