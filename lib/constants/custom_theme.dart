import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final customTheme = ThemeData(
  // fontFamily:GoogleFonts.openSansCondensed().fontFamily,
  textTheme: GoogleFonts.openSansCondensedTextTheme(
      ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
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
  scaffoldBackgroundColor: Colors.white,
);
