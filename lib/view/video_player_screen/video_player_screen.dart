import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:NUHA/view/common_widgets/my_scroll_widget.dart';
import 'package:NUHA/view/common_widgets/network_image_loader.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../common_widgets/appbar.dart';
import '/model/video_data_model.dart';
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
    _videoId = YoutubePlayerController.convertUrlToId(
            widget.videoDataModel.videoUrl) ??
        "";
    loadVideo();
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
            log("setstate called");
            isLoaded = true;
          });
        }
      }
    });
  }

  Future<void> loadVideo() async {
    await _controller.loadVideoById(videoId: _videoId);
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
        appBar: isDesktop && !isFullScreen
            ? const AppBarWidget(page: "videoPlayer")
            : null,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child:
                                  Text(widget.videoDataModel.videoDescription),
                            ),
                          ])),
                      Expanded(
                        flex: 2,
                        //to do: show suggested videos based on the selected suggestion
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Suggestions(
                            currentVideoDataModel: widget.videoDataModel,
                          ),
                        ),
                      )
                    ],
                  );
                }
                //Mobile view / tablet view (not only for mobile but for desktop too)

                return Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(children: [
                    Expanded(
                      flex: isDesktop ? 8 : 3,
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
                    Expanded(
                        child: Center(
                            child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(widget.videoDataModel.videoDescription),
                    ))),
                    //suggested videos
                    Expanded(
                        flex: 4,
                        child: Suggestions(
                          currentVideoDataModel: widget.videoDataModel,
                        ))
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

class DesktopSuggestions extends StatelessWidget {
  final List<VideoDataModel> suggestedVideos;
  DesktopSuggestions({super.key, required this.suggestedVideos});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return MyScrollWidget(
      scrollController: _scrollController,
      // videosList: suggestedVideos,
      currentWidget: ListView.builder(
        // primary: true,
        controller: _scrollController,
        itemCount: suggestedVideos.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerScreen(videoDataModel: suggestedVideos[index]),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: NetworkImageLoader(
                            imageUrl: suggestedVideos[index].thumbnailUrl),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: deviceWidth > 1100
                          ? 3
                          : deviceWidth > 600
                              ? 2
                              : 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          suggestedVideos[index].videoDescription,
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
