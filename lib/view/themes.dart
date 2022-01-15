import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkCreamColor = Colors.grey[900];
  static Color darkBluishColor = Color(0xff403b58);
  static Color lightBluishColor = Colors.blue[200];

  static ThemeData lightTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        primaryColor: darkBluishColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        canvasColor: creamColor,
        buttonTheme: ButtonThemeData(buttonColor: darkBluishColor),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: Colors.white,
        cardColor: Colors.black,
        canvasColor: darkCreamColor,
        buttonTheme: ButtonThemeData(buttonColor: lightBluishColor),
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      );
}
