import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:NUHA/view/biography/biography_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();
  }

  // final List<Widget> mainBodyWidgets = <Widget>[
  //   const VideosListWidget(),
  //   const CategoriesWidget(),
  //   const Center(
  //     child: Text("Recommended Videos will appear here soon !"),
  //   ), //recommended videos
  // ];

  @override
  Widget build(BuildContext context) {
    ThemeData mode = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: const TabBarView(
              children: [VideosListWidget(), AudioScreen(), BiographyScreen()]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: mode.brightness == Brightness.dark
                  ? DeviceConstraints.darkHeader
                  : DeviceConstraints.lightHeader,
            ),
            height: DeviceConstraints.bottomNavBarHeight,
            child: TabBar(
                tabs: const [
                  Tab(
                    icon: Icon(Icons.video_settings),
                    text: "VIDEO",
                  ),
                  Tab(
                    icon: Icon(Icons.audio_file_outlined),
                    text: "AUDIO",
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                    text: "BIOGRAPHY",
                  )
                ],
                labelStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: mode.brightness == Brightness.dark
                        ? DeviceConstraints.darkText
                        : DeviceConstraints.lightText)),
          ),
        ),
      ),
    );
  }
}

// class NavBar {
//   String title;
//   IconData icon;
//   NavBar({required this.title, required this.icon});
// }

// final List<NavBar> topNavItems = <NavBar>[
//   NavBar(title: 'ALL', icon: Icons.video_settings),
//   NavBar(title: 'Categories', icon: Icons.category),
//   NavBar(title: 'Recommended', icon: Icons.lightbulb_outlined),
// ];
// final List<NavBar> bottomNavItems = <NavBar>[
//   NavBar(title: 'VIDEOS', icon: Icons.video_settings),
//   NavBar(title: 'AUDIOS', icon: Icons.audio_file_outlined),
//   NavBar(title: 'BIOGRAPHY', icon: Icons.person),
// ];





          // currentBottomNavBarIndex == 0
          //     ? const VideosListWidget()
          // NestedScrollView(
          //     floatHeaderSlivers: true,
          //     headerSliverBuilder: (context, innerBoxIsScrolled) => [
          //           SliverAppBar(
          //             backgroundColor: mode.scaffoldBackgroundColor,
          //             iconTheme: mode.iconTheme,
          //             pinned: true,
          //             floating: true,
          //             title: const AppBarWidget(page: "homePage"),
          //             bottom: TabBar(
          //                 labelStyle: TextStyle(
          //                     color: mode.brightness == Brightness.light
          //                         ? Colors.black
          //                         : Colors.white,
          //                     fontSize: 11,
          //                     fontWeight: FontWeight.bold),
          //                 tabs: const [
          //                   Tab(
          //                     icon: Icon(Icons.video_settings),
          //                     text: "ALL",
          //                   ),
          //                   Tab(
          //                     icon: Icon(Icons.category),
          //                     text: "CATEGORIES",
          //                   ),
          //                   Tab(
          //                     icon: Icon(Icons.lightbulb_outlined),
          //                     text: "RECOMMENDED",
          //                   ),
          //                 ]),
          //           )
          //         ],
          //     body: TabBarView(children: [
          //       mainBodyWidgets[0],
          //       mainBodyWidgets[1],
          //       mainBodyWidgets[2]
          //     ]))
          // : currentBottomNavBarIndex == 1
          //     ? const AudioScreen()
          // NestedScrollView(
          //     floatHeaderSlivers: true,
          //     headerSliverBuilder: (context, innerBoxIsScrolled) => [
          //           const SliverAppBar(
          //             title: Text("Audio Screen App Bar"),
          //           )
          //         ],
          //     body: const TabBarView(children: [AudioScreen()]))
          // : const BiographyScreen(),
          // NestedScrollView(
          //     headerSliverBuilder: (context, innerBoxIsScrolled) => [
          //           const SliverAppBar(
          //             title: Text("Biography Screen App Bar"),
          //           )
          //         ],
          //     body: const TabBarView(children: [BiographyScreen()])),


// BottomNavigationBar(
//   onTap: (index) {
//     setState(() {
//       currentBottomNavBarIndex = index;
//     });
//   },
//   items: const [
//     BottomNavigationBarItem(
//         icon: Icon(Icons.video_settings), label: 'VIDEO'),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.audio_file_outlined), label: 'AUDIO'),
//     BottomNavigationBarItem(
//         icon: Icon(Icons.person), label: 'BIOGRAPHY'),
//   ],
//   unselectedLabelStyle: TextStyle(
//       color: mode.brightness == Brightness.light
//           ? Colors.black
//           : Colors.white,
//       fontSize: 11,
//       fontWeight: FontWeight.bold),
//   selectedLabelStyle: TextStyle(
//       color: mode.brightness == Brightness.light
//           ? Colors.black
//           : Colors.white,
//       fontSize: 13,
//       fontWeight: FontWeight.bold),
// )


          // BottomNavigationBar(
          //   onTap: (index) {
          //     setState(() {
          //       currentBottomNavBarIndex = index;
          //     });
          //   },
          //   items: const [
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.video_settings), label: 'VIDEO'),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.audio_file_outlined), label: 'AUDIO'),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.person), label: 'BIOGRAPHY'),
          //   ],
          // unselectedLabelStyle: TextStyle(
          //     color: mode.brightness == Brightness.light
          //         ? Colors.black
          //         : Colors.white,
          //     fontSize: 11,
          //     fontWeight: FontWeight.bold),
          // selectedLabelStyle: TextStyle(
          //     color: mode.brightness == Brightness.light
          //         ? Colors.black
          //         : Colors.white,
          //     fontSize: 13,
          //     fontWeight: FontWeight.bold),
          // ),
          // NavigationBar(
          //   height: DeviceConstraints.bottomNavBarHeight,
          //   selectedIndex: currentBottomNavBarIndex,
          //   onDestinationSelected: (int index) {
          //     log("index = $index");
          //     if (index == 1) {
          //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //         content: Center(child: Text("Coming Soon ...")),
          //       ));
          //     }
          //     setState(() {
          //       currentBottomNavBarIndex = index;
          //     });
          //   },
          //   destinations: bottomNavItems
          //       .map((e) =>
          //           NavigationDestination(icon: Icon(e.icon), label: e.title))
          //       .toList(),
          // ),