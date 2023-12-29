import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_audio_library/view/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // fontFamily:GoogleFonts.openSansCondensed().fontFamily,
          textTheme: GoogleFonts.openSansCondensedTextTheme(
              ThemeData.light().textTheme.copyWith(
                  bodyLarge: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  bodyMedium: TextStyle(fontWeight: FontWeight.w600))),
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white),
      home: HomePage(),
    );
  }
}
