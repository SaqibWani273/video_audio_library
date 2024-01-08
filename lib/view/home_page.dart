import 'package:flutter/material.dart';
import 'package:video_audio_library/constants/other_const.dart';
import '/constants/device_constraints.dart';
import '/view/audio_homepage.dart';
import 'widgets/all_videos_widget.dart';

import 'widgets/appbar.dart';
import 'widgets/categories_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentNavBarIndex = 0;
  var currentBottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    DeviceConstraints.deviceHeight = deviceSize.height;
    return Scaffold(
      extendBody: true,
      appBar: currentBottomNavBarIndex == 0
          ? AppBarWidget(deviceSize: deviceSize)
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
                                      margin: EdgeInsets.only(top: 16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
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
          : AudioHomePage(),
      bottomNavigationBar: NavigationBar(
        height: DeviceConstraints.bottomNavBarHeight,
        selectedIndex: currentBottomNavBarIndex,
        onDestinationSelected: (int index) {
          if (index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

final List<Widget> mainBodyWidgets = <Widget>[
  AllVideosWidget(videosList: videosList),
  CategoriesWidget(),
  AllVideosWidget(videosList: videosList),
];

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
];
