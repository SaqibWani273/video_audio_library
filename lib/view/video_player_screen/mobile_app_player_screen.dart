import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/video_data_model.dart';
import 'widgets/suggestions.dart';

class MobileAppPlayerScreen extends StatefulWidget {
  const MobileAppPlayerScreen({super.key, required this.videoData});
  final VideoDataModel videoData;

  @override
  State<MobileAppPlayerScreen> createState() => _MobileAppPlayerScreenState();
}

class _MobileAppPlayerScreenState extends State<MobileAppPlayerScreen> {
  late YoutubePlayerController _controller;
  // late TextEditingController _idController;
  var isFullScreen = false;

  late String _videoId;

  @override
  void deactivate() {
    //To Pause video while navigating to next page
    _controller.pause();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();

    // _idController = TextEditingController();
    _videoId = YoutubePlayer.convertUrlToId(widget.videoData.videoUrl) ?? "";
    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    // _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () async {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        isFullScreen = false;
      },
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
        isFullScreen = true;
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.green,
        progressColors: const ProgressBarColors(
          playedColor: Color.fromARGB(255, 22, 177, 60),
          handleColor: Color.fromARGB(123, 175, 33, 33),
        ),
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {},
        onEnded: (data) {
          //   _controller
          // .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          log('Video Ended!');
        },
      ),
      builder: (context, player) {
        return Scaffold(
          // appBar:
          //     isFullScreen ? null : const AppBarWidget(page: "videoPlayer"),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(children: [
              Expanded(
                flex: 3,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: PlayerWidget(
                    controller: _controller,
                    player: player,
                  ),
                ),
              ),
              Expanded(
                  flex: 7,
                  child: Suggestions(
                    currentVideoDataModel: widget.videoData,
                  )),
            ]),
          ),
        );
      },
    );
  }
}

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({
    super.key,
    required this.controller,
    required this.player,
  });

  final YoutubePlayerController controller;
  final Widget player;

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  var showSeekForwardContainer = false;
  var showSeekBackwardContainer = false;
  void seekVideo({required bool isForward}) async {
    final seconds = isForward ? 10 : -10;
    final newPosition =
        widget.controller.value.position + Duration(seconds: seconds);

    if (newPosition < Duration.zero) {
      widget.controller.seekTo(Duration.zero);
    } else {
      widget.controller.seekTo(newPosition);
    }
    setState(() {
      isForward
          ? showSeekForwardContainer = true
          : showSeekBackwardContainer = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showSeekBackwardContainer = false;
        showSeekForwardContainer = false;
      });
    }); //
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          child: widget.player,
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: deviceWidth * 0.7,
          child: Container(
            height: deviceHeight * 0.2,
            width: deviceWidth * 0.3,
            decoration: showSeekBackwardContainer
                ? BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.elliptical(48.0, 48.0),
                      bottomRight: Radius.elliptical(24.0, 24.0),
                    ),
                    color: Colors.black.withOpacity(0.3),
                  )
                : null,
            child: InkWell(
              child: showSeekBackwardContainer
                  ? TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.fast_rewind, color: Colors.white),
                      label: Text(
                        "10 secs",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : null,
              onTap: () => seekVideo(isForward: false),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: deviceWidth * 0.7,
          right: 0,
          child: Container(
            height: deviceHeight * 0.2,
            width: deviceWidth * 0.3,
            decoration: showSeekForwardContainer
                ? BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(48.0, 48.0),
                      bottomLeft: Radius.elliptical(24.0, 24.0),
                    ),
                    color: Colors.black.withOpacity(0.3),
                  )
                : null,
            child: InkWell(
              child: showSeekForwardContainer
                  ? TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.fast_forward, color: Colors.white),
                      label: Text(
                        "10 secs",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : null,
              onTap: () => seekVideo(isForward: true),
            ),
          ),
        ),
      ],
    );
  }
}

// enum Suggestions {
//   recommended,
//   all,
//   tafseer,
//   seerah,
//   fiqh,
//   hadees,
//   quran,
//   quranRecitation,
//   tafseerRecitation,
//   quranTafseerRecitation,
//   fiqh1,
//   hadees1,
//   quran1,
//   quranRecitation1,
//   tafseerRecitation1,
//   quranTafseerRecitation1,
// }
