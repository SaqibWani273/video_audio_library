import 'package:NUHA/constants/device_constraints.dart';
import 'package:NUHA/model/video_data_model.dart';
import 'package:flutter/material.dart';
import 'package:NUHA/model/category.dart';
import 'package:NUHA/view/common_widgets/network_image_loader.dart';
import '../../../model/playlist.dart';
import '../../video_player_screen/video_player_screen.dart';
import 'category_header.dart';

import 'videos_list_widget.dart';
import '../../common_widgets/appbar.dart';

class CategoriesDetail extends StatelessWidget {
  final Category category;
  CategoriesDetail({
    super.key,
    required this.category,
  });
  late List<VideoDataModel>? defaultVideosList;
  @override
  Widget build(BuildContext context) {
    ThemeData mode = Theme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    // final playLists = context.read<DataRepo>().playLists;

    return Scaffold(
      appBar: const AppBarWidget(page: "categoryDetails"),
      body: Row(children: [
        if (deviceWidth > 800)
          //playlist tilte and image and other options like youtube has
          Expanded(
            child: CategoryHeader(
                playListImgUrl: category.imgUrl, // playListImgUrl,
                playListName: category.nameInEnglish, //playListName,
                playListNameInArabic: category.nameInArabic),
          ),
        Expanded(
          child: ListView(primary: true, children: [
            //playlist tilte and image and other options like youtube has
            if (deviceWidth < 800)
              CategoryHeader(
                  playListImgUrl: category.imgUrl,
                  playListName: category.nameInEnglish,
                  playListNameInArabic: category.nameInArabic),
            if (category.playLists == null || category.playLists!.isEmpty)
              const Center(child: Text("No Playlists Added  Yet ")),
            if (category.playLists != null && category.playLists!.isNotEmpty)
              ...category.playLists!.map((PlayList playList) {
                if (playList.nameInEnglish == 'Default') {
                  defaultVideosList = playList.videos;
                  return const SizedBox.shrink();
                }
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            body: playList.videos == null ||
                                    playList.videos!.isEmpty
                                ? const Center(
                                    child: Text("No Videos Added  Yet "))
                                : MyBlockBuilder(
                                    videosList: playList.videos,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Stack(children: [
                            //image
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: NetworkImageLoader(
                                    height: 150,
                                    imageUrl:
                                        playList.imageUrl ?? category.imgUrl,
                                  )),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              // height: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16.0),
                                      bottomRight: Radius.circular(16.0)),
                                  color: Colors.grey.withOpacity(0.6),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${playList.videos == null ? 0 : playList.videos!.length} videos",
                                      ),
                                      const Icon(Icons.playlist_play_rounded)
                                    ]),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 32.0),
                                  child: Text(
                                    playList.nameInArabic,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: mode.brightness ==
                                                    Brightness.dark
                                                ? DeviceConstraints.darkText
                                                : DeviceConstraints.lightText),
                                  ),
                                )),
                          ]),
                        ),
                        Expanded(
                            flex: deviceWidth > 1100
                                ? 3
                                : deviceWidth > 600
                                    ? 2
                                    : 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      playList.nameInEnglish,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${playList.videos == null ? 0 : playList.videos!.length} Lectures",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: mode.brightness ==
                                                      Brightness.dark
                                                  ? DeviceConstraints.darkText
                                                  : DeviceConstraints
                                                      .lightText),
                                    )
                                  ]),
                            ))
                      ],
                    ),
                  ),
                );
              }).toList(),
            //default videos will be displayed after the playlists
            if (defaultVideosList != null)
              ...defaultVideosList!
                  .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VideoPlayerScreen(videoDataModel: e),
                                  ),
                                );
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: NetworkImageLoader(
                                      imageUrl: e.thumbnailUrl),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16.0),
                              child: Text(e.videoDescription),
                            ),
                          ]))
                  .toList(),
          ]),
        ),
      ]),
    );
  }
}
