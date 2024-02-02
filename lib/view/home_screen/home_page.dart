import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:NUHA/view/biography/biography_screen.dart';
import 'package:flutter/rendering.dart';
import '/constants/device_constraints.dart';
import '../audio_screen.dart';
import 'widgets/videos_list_widget.dart';

import '../common_widgets/appbar.dart';
import 'widgets/categories_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentNavBarIndex = 0;
  var currentBottomNavBarIndex = 0;

  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    print("message.......");

    // Listen to scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // Scroll direction is up, show app bar
        if (!_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = true;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // Scroll direction is down, hide app bar
        if (_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = false;
          });
        }
      }
    });
  }

  final List<Widget> mainBodyWidgets = <Widget>[
    const VideosListWidget(),
    const CategoriesWidget(),
    const Center(
      child: Text("Recommended Videos will appear here soon !"),
    ), //recommended videos
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData mode = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    DeviceConstraints.deviceHeight = deviceSize.height;
    return Scaffold(
      extendBody: true,
      appBar: currentBottomNavBarIndex == 0
          ? _isAppBarVisible
              ? const AppBarWidget(page: "homePage")
              : null
          : null,
      body: currentBottomNavBarIndex == 0
          ? Column(children: [
              //topNavbar
              SizedBox(
                height: DeviceConstraints.topNavBarHeight,
                child: Row(
                  children: topNavItems
                      .map(
                        (e) => Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              setState(() {
                                currentNavBarIndex = topNavItems.indexOf(e);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  Icon(e.icon),
                                  Text(e.title),
                                  if (currentNavBarIndex ==
                                      topNavItems.indexOf(e))
                                    Container(
                                      height: 4,
                                      width: 24,
                                      margin: const EdgeInsets.only(top: 5.0),
                                      decoration: BoxDecoration(
                                        color:
                                            mode.brightness == Brightness.light
                                                ? Colors.black
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: DeviceConstraints.heightMargin,
              ),
              Expanded(child: mainBodyWidgets[currentNavBarIndex]),
            ])
          : currentBottomNavBarIndex == 1
              ? const AudioScreen()
              : const BiographyScreen(),
      bottomNavigationBar: NavigationBar(
        height: DeviceConstraints.bottomNavBarHeight,
        selectedIndex: currentBottomNavBarIndex,
        onDestinationSelected: (int index) {
          log("index = $index");
          if (index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(child: Text("Coming Soon ...")),
            ));
          }
          setState(() {
            currentBottomNavBarIndex = index;
          });
        },
        destinations: bottomNavItems
            .map((e) =>
                NavigationDestination(icon: Icon(e.icon), label: e.title))
            .toList(),
      ),
    );
  }
}

class NavBar {
  String title;
  IconData icon;
  NavBar({required this.title, required this.icon});
}

final List<NavBar> topNavItems = <NavBar>[
  NavBar(title: 'ALL', icon: Icons.video_settings),
  NavBar(title: 'Categories', icon: Icons.category),
  NavBar(title: 'Recommended', icon: Icons.lightbulb_outlined),
];
final List<NavBar> bottomNavItems = <NavBar>[
  NavBar(title: 'VIDEOS', icon: Icons.video_settings),
  NavBar(title: 'AUDIOS', icon: Icons.audio_file_outlined),
  NavBar(title: 'BIOGRAPHY', icon: Icons.person),
];
