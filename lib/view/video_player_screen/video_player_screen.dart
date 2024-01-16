import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../common_widgets/appbar.dart';
import '/model/video_data_model.dart';
import '/view/home_screen/widgets/all_videos_widget.dart';
import 'widgets/loading_widget.dart';
import 'widgets/suggestions.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoDataModel videoDataModel;
  const VideoPlayerScreen({super.key, required this.videoDataModel});

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
    _videoId = YoutubePlayerController.convertUrlToId(
            widget.videoDataModel.videoUrl) ??
        "";
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
                              if (!isLoaded) const LoadingWidget()
                            ]),
                            const SizedBox(height: 10),
                            Suggestions(
                              currentVideoDataModel: widget.videoDataModel,
                            ),
                            Text(widget.videoDataModel.videoDescription),
                          ])),
                      const Expanded(
                        flex: 2,
                        //to do: show suggested videos based on the selected suggestion
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: AllVideosWidget(),
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
                            if (!isLoaded) const LoadingWidget()
                          ]),
                        ),
                      ),
                    ),
                    //suggested videos
                    Expanded(
                        flex: 6,
                        child: Suggestions(
                          currentVideoDataModel: widget.videoDataModel,
                        )

                        //  Column(children: [
                        //   Expanded(
                        //     //suggestions
                        //     flex: 2,
                        //     child: Suggestions( currentVideoDataModel: widget.videoDataModel),
                        //   ),
                        //   //to do: filter list dynamically
                        //   Expanded(flex: 7, child: AllVideosWidget())
                        // ]),
                        )
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
