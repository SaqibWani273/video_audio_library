import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  // fontFamily:GoogleFonts.openSansCondensed().fontFamily,
  textTheme: GoogleFonts.openSansCondensedTextTheme(
      ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium:
                const TextStyle(fontWeight: FontWeight.w600, wordSpacing: 4.0),
            bodySmall: const TextStyle(fontWeight: FontWeight.w600),

            //for search field in appbar
            titleMedium: const TextStyle(fontWeight: FontWeight.w600),

            //for bottom nav
            labelSmall: const TextStyle(fontWeight: FontWeight.w600),
          )),
  useMaterial3: false,
  // brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 153, 157, 159),
);

final darkTheme = ThemeData(
  // fontFamily:GoogleFonts.openSansCondensed().fontFamily,
  textTheme: GoogleFonts.openSansCondensedTextTheme(
      ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium:
                const TextStyle(fontWeight: FontWeight.w600, wordSpacing: 4.0),
            bodySmall: const TextStyle(fontWeight: FontWeight.w600),

            //for search field in appbar
            titleMedium: const TextStyle(fontWeight: FontWeight.w600),

            //for bottom nav
            labelSmall: const TextStyle(fontWeight: FontWeight.w600),
          )),
  useMaterial3: false,
  brightness: Brightness.dark,
  // scaffoldBackgroundColor: const Color.fromARGB(255, 209, 213, 215),
);
