import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_library/repository/data_repo.dart';
import 'package:video_audio_library/utils/search_video.dart';
import 'package:video_audio_library/view/common_widgets/search_results.dart';
import 'package:video_audio_library/view/home_screen/home_page.dart';
import 'package:video_audio_library/view_model/data_bloc/data_bloc_bloc.dart';
import '../../constants/device_constraints.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Size deviceSize;
  AppBarWidget({super.key, required this.deviceSize});
  final _searchController = TextEditingController();
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
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(
          vertical: kIsWeb ? 4.0 : 24.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomePage();
            })),
            child: Image.asset(
              'assets/images/demo_icon_video_library.png',
              height: 40,
              width: 80,
            ),
          ),
          //search box
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: deviceWidth > 600 ? deviceWidth * 0.2 : 8.0,
              ),

              //round corners
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                //   color: Colors.grey,
              ),

              child: Card(
                color: Colors.grey.shade50,
                elevation: 4.0,
                shadowColor: Colors.black26,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: _searchController,
                    onFieldSubmitted: (value) {
                      searchVideos(value.trim(), context);
                    },
                    decoration: InputDecoration(
                      hintText: "Search videos",
                      suffixIcon: InkWell(
                          onTap: () {
                            searchVideos(
                                _searchController.text.trim(), context);
                          },
                          child: Icon(Icons.search)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceConstraints.appBarHeight);
}
