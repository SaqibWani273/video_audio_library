import '/constants/device_constraints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  // fontFamily:GoogleFonts.openSansCondensed().fontFamily,
  textTheme:
      GoogleFonts.montserratTextTheme(ThemeData.light().textTheme.copyWith(
            bodyLarge: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 16),
            // const TextStyle(
            //   color: Colors.black,
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
            // ),
            bodyMedium: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, wordSpacing: 4.0),
            // const TextStyle(fontWeight: FontWeight.w600, wordSpacing: 4.0),
            bodySmall: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
            // const TextStyle(fontWeight: FontWeight.w600),

            //for search field in appbar
            titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
            // const TextStyle(fontWeight: FontWeight.w600),

            //for bottom nav
            labelSmall: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
            // const TextStyle(fontWeight: FontWeight.w600),
          )),
  useMaterial3: false,
  brightness: Brightness.light,
  scaffoldBackgroundColor: DeviceConstraints.whiteBackground,
  // bottomNavigationBarTheme:
  // const BottomNavigationBarThemeData(selectedItemColor: Colors.black)
);

final darkTheme = ThemeData(
  // fontFamily:GoogleFonts.openSansCondensed().fontFamily,
  textTheme:
      GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme.copyWith(
            bodyLarge: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, fontSize: 16),
            // TextStyle(
            //   color: Colors.white,
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
            // ),
            bodyMedium: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600, wordSpacing: 4.0),
            // const TextStyle(fontWeight: FontWeight.w600, wordSpacing: 4.0),
            bodySmall: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
            // const TextStyle(fontWeight: FontWeight.w600),

            //for search field in appbar
            titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
            // const TextStyle(fontWeight: FontWeight.w600),

            //for bottom nav
            labelSmall: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
            // const TextStyle(fontWeight: FontWeight.w600),
          )),
  useMaterial3: false,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DeviceConstraints.blackBackground,
);
