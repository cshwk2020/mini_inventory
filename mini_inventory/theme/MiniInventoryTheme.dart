
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniInventoryTheme {


  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(fontSize: 32.0, fontWeight: FontWeight.w700, color: Colors.black),
    headline1: GoogleFonts.openSans(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline2: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black),
    headline3: GoogleFonts.openSans(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),

    //

    headline6: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),

    button: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white ),


  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(fontSize: 32.0, fontWeight: FontWeight.w700, color: Colors.white),
    headline1: GoogleFonts.openSans(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline2: GoogleFonts.openSans(fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.white),
    headline3: GoogleFonts.openSans(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),

    //


    headline6: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w600,
        color: Colors.white,
        ),

    button: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600,
        color: Colors.white),


  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      accentColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.black54,


      ),

        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
          ),
        ),


        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,     //  <-- dark color
          textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
        ),

      backgroundColor: Colors.grey,

      textTheme: lightTextTheme
    );
  }

  static ThemeData dark() {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        accentColor: Colors.white,


        textSelectionColor: Colors.red,

        textSelectionTheme: const TextSelectionThemeData(

            selectionColor: Colors.yellowAccent,


        ),


        inputDecorationTheme: InputDecorationTheme(



          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
        ),

        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green,     //  <-- dark color
          textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
        ),



        textTheme: darkTextTheme
    );
  }
}