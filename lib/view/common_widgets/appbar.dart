import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:NUHA/utils/search_video.dart';
import 'package:NUHA/view/common_widgets/search_results.dart';
import 'package:NUHA/view/home_screen/home_page.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/device_constraints.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  // final Size deviceSize;
  final String page;
  const AppBarWidget({super.key, required this.page});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(DeviceConstraints.appBarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final _searchController = TextEditingController();
  bool isIconPressed = false;

  void searchVideos(String val, BuildContext context) {
    if (val.isNotEmpty) {
      final filteredVideos = Utils().searchVideo(val, context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SearchResults(
          searchResults: filteredVideos,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      // height: DeviceConstraints.appBarHeight,
      // alignment: Alignment.bottomCenter,
      // color: const Color.fromARGB(255, 157, 153, 153),
      width: deviceWidth,
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
      //  const EdgeInsets.symmetric(
      //     vertical: kIsWeb ? 4.0 : 24.0, horizontal: 16.0),
      decoration: const BoxDecoration(
          // color: Colors.amber,
          border:
              Border(bottom: BorderSide(width: 3.0, style: BorderStyle.solid))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            // highlightColor: Colors.white,
            onTap: () => {
              if (Navigator.canPop(context) && widget.page != "homePage")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }))
                }
            },
            child: Image.asset(
              'assets/images/demo_icon_video_library.png',
              height: 50,
              width: 80,
            ),
          ),
          const Spacer(),
          deviceWidth > 500.0
              ? const Text(
                  "NOOR UL HASAN ACADEMY",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Text(""),
          const Spacer(),
          //search box
          Container(
              padding: const EdgeInsets.only(right: 10.0),
              child: Animate(
                effects: !isIconPressed
                    ? null
                    : [
                        SlideEffect(
                            end: const Offset(1.5, 0.0),
                            duration: 400.ms,
                            curve: Curves.easeIn),
                        FadeEffect(
                            delay: 400.ms, begin: 1.0, end: 0.0, duration: 0.ms)
                      ],
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        isIconPressed = !isIconPressed;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30.0,
                    )),
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active),
          ),

          if (isIconPressed)
            FutureBuilder(
                future: Future.delayed(400.ms),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState != ConnectionState.done) {
                    return const SizedBox();
                  }
                  return Expanded(
                    child: Container(
                      height: 48.0,
                      width: deviceWidth * 0.4,
                      margin: EdgeInsets.symmetric(
                        horizontal: deviceWidth > 600 ? deviceWidth * 0.2 : 8.0,
                      ),
                      alignment: Alignment.center,
                      // round corners
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56.0),
                        color: Colors.black.withOpacity(0.5),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          controller: _searchController,
                          onFieldSubmitted: (value) {
                            searchVideos(value.trim(), context);
                          },
                          decoration: InputDecoration(
                            hintText: "Search videos",
                            hintStyle: const TextStyle(color: Colors.white),
                            suffixIcon: InkWell(
                                onTap: () {
                                  searchVideos(
                                      _searchController.text.trim(), context);
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
                            // round corners

                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ).animate()
                      ..scaleX(curve: Curves.easeOut, duration: 1500.ms)
                          .slideX(begin: 0.5),
                  );
                }),
        ],
      ),
    );
  }
}
