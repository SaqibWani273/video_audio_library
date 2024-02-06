import 'package:flutter/material.dart';

class DeviceConstraints {
  static double? deviceHeight;

  static double appBarHeight = kToolbarHeight + appBarPadding;
  static double topNavBarHeight = 65;
  static double heightMargin = 16;
  static double bottomNavBarHeight = 60;
  static double mainBodyHeight = deviceHeight! -
      appBarHeight -
      topNavBarHeight -
      heightMargin -
      bottomNavBarHeight;

  static Color blackBackground = const Color.fromARGB(200, 0, 0, 0);
  static Color whiteBackground = const Color.fromARGB(200, 245, 245, 245);

  static Color darkHeader = const Color.fromARGB(200, 30, 30, 30);
  static Color lightHeader = const Color.fromARGB(200, 220, 220, 220);

  static Color darkText = const Color.fromARGB(255, 255, 255, 255);
  static Color lightText = const Color.fromARGB(255, 0, 0, 0);
}

const double appBarPadding = 24.0;
