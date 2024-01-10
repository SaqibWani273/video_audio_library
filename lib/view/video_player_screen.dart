import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_audio_library/constants/other_const.dart';
import 'package:video_audio_library/view/widgets/all_videos_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'widgets/appbar.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoData videoData;
  const VideoPlayerScreen({super.key, required this.videoData});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  late String _videoId;
  bool isLoaded = false;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
      mute: false,
      loop: false,
      enableCaption: true,
      // showVideoAnnotations: false,
      // enableJavaScript: false,
      strictRelatedVideos: true,
    ));

    _controller.setFullScreenListener((bool enteredFullScreen) {
      log(
        'FullScreen: ${enteredFullScreen ? 'Entered' : 'Exited'}',
      );
      isFullScreen = enteredFullScreen;
    });
    _controller.listen((event) {
      if (event.playerState == PlayerState.playing && isLoaded == false) {
        //to stop showing loading indicator when video started playing
        if (mounted) {
          setState(() {
            isLoaded = true;
          });
        }
      }
    });
    _videoId =
        YoutubePlayerController.convertUrlToId(widget.videoData.videoUrl) ?? "";
    _controller.loadVideoById(videoId: _videoId);
  }

  @override
  void dispose() {
    log("disposed video player screen");
    // _controller.stopVideo();
    //_controller.close();//shows some warnings in console
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows;
    final deviceWidth = MediaQuery.of(context).size.width;
    log(" device width : $deviceWidth");
    return VisibilityDetector(
      key: ValueKey(UniqueKey()),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage == 0) {
          _controller.pauseVideo();
        } else {
          _controller.playVideo();
        }
      },
      child: Scaffold(
        appBar: isFullScreen
            ? null
            : AppBarWidget(deviceSize: MediaQuery.of(context).size),
        body: YoutubePlayerScaffold(
          key: ValueKey(
              "$isLoaded"), //setstate will not rebuild this widget without using key
          backgroundColor: Colors.green,
          controller: _controller,
          autoFullScreen: false,
          aspectRatio: 16 / 9,

          builder: (_, player) {
            // log("entered here");
            return Scaffold(
              body: LayoutBuilder(builder: (context, constraints) {
                if (isDesktop && constraints.maxWidth > 1000) {
                  //Desktop view
                  return Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(children: [
                            Stack(children: [
                              player,
                              if (!isLoaded) LoadingWidget()
                            ]),
                            SizedBox(height: 10),
                            Suggestions(),
                            Text(widget.videoData.title),
                          ])),
                      Expanded(
                        flex: 2,
                        //to do: show suggested videos based on the selected suggestion
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: AllVideosWidget(videosList: videosList),
                        ),
                      )
                    ],
                  );
                }
                //Mobile view

                return Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(children: [
                    Expanded(
                      flex: isDesktop ? 9 : 4,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Container(
                          //round border
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? deviceWidth * 0.05 : 0.0),
                          width: MediaQuery.of(context).size.width,
                          child: Stack(children: [
                            player,
                            if (!isLoaded) LoadingWidget()
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 6,
                        child: Column(children: [
                          Expanded(
                            //suggestions
                            flex: 2,
                            child: Suggestions(),
                          ),
                          //to do: filter list dynamically
                          Expanded(
                              flex: 7,
                              child: AllVideosWidget(
                                videosList: videosList,
                              ))
                        ]))
                  ]),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

enum SuggestionsEnum {
  recommended,
  all,
  tafseer,
  seerah,
  fiqh,
  hadees,
  quran,
  quranRecitation,
  tafseerRecitation,
  quranTafseerRecitation,
  fiqh1,
  hadees1,
  quran1,
  quranRecitation1,
  tafseerRecitation1,
  quranTafseerRecitation1,
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        color: Colors.black,
        child: Center(
            child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
          // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 3.0,

          strokeCap: StrokeCap.square,
        )),
      ),
    );
  }
}

class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: SuggestionsEnum.values
                .map((e) => Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey.shade200,
                      ),
                      child: Text(e.name.toUpperCase()),
                    ))
                .toList()),
      ),
    );
  }
}
