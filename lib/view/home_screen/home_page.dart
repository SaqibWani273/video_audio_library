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
          ? Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(200, 0, 0, 0),
                  Color.fromARGB(255, 143, 133, 133)
                ],
              )),
              child: Column(children: [
                //topNavbar
                Container(
                  decoration:
                      const BoxDecoration(color: Color.fromARGB(255, 46, 40, 40)
                          // gradient: LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          //   colors: [
                          //     Color.fromARGB(255, 31, 33, 31),
                          //     Color.fromARGB(255, 87, 91, 94)
                          //   ],
                          // ),
                          ),
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
                                    Icon(e.icon,
                                        color: const Color.fromARGB(
                                            255, 233, 232, 230)),
                                    Text(e.title,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 223, 222, 219))),
                                    if (currentNavBarIndex ==
                                        topNavItems.indexOf(e))
                                      Container(
                                        height: 4,
                                        width: 24,
                                        margin: const EdgeInsets.only(top: 5.0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 221, 218, 218),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
              ]),
            )
          : currentBottomNavBarIndex == 1
              ? const AudioScreen()
              : const BiographyScreen(),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 46, 40, 40),
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
            .map(
              (e) => NavigationDestination(
                icon: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      e.icon,
                      color: Colors.white,
                    ),
                    Text(
                      e.title,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                  // icon: Icon(
                  //   e.icon,
                  //   color: Colors.white,
                  // ),
                  // label: ''
                ),
                label: '',
              ),
            )
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
