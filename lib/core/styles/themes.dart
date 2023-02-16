import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color? creamColor = const Color(0xfff5f5f5);
  static Color? darkCreamColor = Colors.grey[900];
  static Color? darkBluishColor = const Color(0xff403b58);
  static Color? lightBluishColor = Colors.blue[200];

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        focusColor: Colors.white,
        primaryColor: darkBluishColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        canvasColor: creamColor,
        buttonTheme: ButtonThemeData(buttonColor: darkBluishColor),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        focusColor: Colors.black,
        fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: Colors.white,
        cardColor: Colors.black,
        canvasColor: darkCreamColor,
        buttonTheme: ButtonThemeData(buttonColor: lightBluishColor),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      );
}
