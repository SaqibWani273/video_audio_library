import 'package:flutter/material.dart';
import '/view/widgets/category_header.dart';

import '../../constants/other_const.dart';
import '/view/widgets/all_videos_widget.dart';
import 'appbar.dart';

class CategoriesDetail extends StatelessWidget {
  final String playListImgUrl;
  final String playListName;
  final String playListNameInArabic;
  const CategoriesDetail({
    super.key,
    required this.playListImgUrl,
    required this.playListName,
    required this.playListNameInArabic,
  });
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarWidget(deviceSize: MediaQuery.of(context).size),
      body: Row(children: [
        if (deviceWidth > 800)
          //playlist tilte and image and other options like youtube has
          Expanded(
            child: CategoryHeader(
                playListImgUrl: playListImgUrl,
                playListName: playListName,
                playListNameInArabic: playListNameInArabic),
          ),
        Expanded(
          child: ListView(primary: true, children: [
            //playlist tilte and image and other options like youtube has
            if (deviceWidth < 800)
              CategoryHeader(
                  playListImgUrl: playListImgUrl,
                  playListName: playListName,
                  playListNameInArabic: playListNameInArabic),
            ...playLists
                .map((PlayList playList) => Container(
                      margin: const EdgeInsets.all(16.0),
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
                                  child: Image.network(
                                    playList.imageUrl ?? playListImgUrl,
                                  ),
                                ),
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
                                          "${playList.videos.length} videos",
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
                                          ?.copyWith(color: Colors.white),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        playList.nameInEnglish,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "${playList.videos.length} Lectures",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.black54),
                                      )
                                    ]),
                              ))
                        ],
                      ),
                    ))
                .toList(),
          ]),
        ),
      ]),
    );
  }
}

class PlayList {
  final String nameInEnglish;
  final String nameInArabic;
  final String? imageUrl;
  final List<VideoData> videos;
  PlayList({
    required this.nameInEnglish,
    required this.nameInArabic,
    this.imageUrl,
    required this.videos,
  });
}

final List<PlayList> playLists = <PlayList>[
  PlayList(
    nameInEnglish: 'Tafseer Surah tul Fatihah',
    nameInArabic: 'تفسير القرآن',
    // imageUrl: demoUrl,
    videos: videosList,
  ),
  PlayList(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
    videos: videosList,
  ),
  PlayList(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    // imageUrl: demoUrl,
    videos: videosList,
  ),
  PlayList(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
    videos: videosList,
  ),
  PlayList(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
    videos: videosList,
  ),
  PlayList(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    // imageUrl: demoUrl,
    videos: videosList,
  ),
  PlayList(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
    videos: videosList,
  ),
  PlayList(
    nameInEnglish: 'Tafseer ul Quran',
    nameInArabic: 'تفسير القرآن',
    imageUrl: demoUrl,
    videos: videosList,
  ),
];
