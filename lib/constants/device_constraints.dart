import 'package:flutter/material.dart';

class DeviceConstraints {
  static double? deviceHeight;

  static double appBarHeight = kToolbarHeight + appBarPadding;
  static double topNavBarHeight = 80;
  static double heightMargin = 16;
  static double bottomNavBarHeight = 60;
  static double mainBodyHeight = deviceHeight! -
      appBarHeight -
      topNavBarHeight -
      heightMargin -
      bottomNavBarHeight;
}

const double appBarPadding = 24.0;
