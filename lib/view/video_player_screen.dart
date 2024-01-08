import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_audio_library/constants/other_const.dart';
import 'package:video_audio_library/view/widgets/all_videos_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoData videoData;
  const VideoPlayerScreen({super.key, required this.videoData});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

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
    ));
    _controller.setFullScreenListener((bool value) {
      log(
        'FullScreen: ${value ? 'Entered' : 'Exited'}',
      );
    });
    final _videoId =
        YoutubePlayerController.convertUrlToId(widget.videoData.videoUrl);
    _controller.loadVideoById(videoId: _videoId ?? "");
  }

  // @override
  // void dispose() {
  //   _controller.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    return YoutubePlayerScaffold(
      builder: (context, player) {
        return
            //  deviceWidth > 800
            //     ? DesktopView(player: player, title: widget.videoData.title)
            //     : MobileView(player: player);

            Scaffold(
          body: LayoutBuilder(builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return DesktopView(player: player, title: widget.videoData.title);
            }
            return MobileView(player: player);
          }),
        );
      },
      controller: _controller,
    );
  }
}

class DesktopView extends StatelessWidget {
  final Widget player;
  final String title;
  const DesktopView({super.key, required this.player, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Column(children: [
              player,
              SizedBox(height: 10),
              Suggestions(),
              Text(title),
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
}

class MobileView extends StatelessWidget {
  final Widget player;
  const MobileView({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(children: [
        Expanded(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: player,
            ),
          ),
        ),
        Expanded(
            flex: 6,
            child: Column(children: [
              Expanded(
                //suggestions
                flex: 1,
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
    //  Padding(
    //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    //   child: Column(children: [
    //     Expanded(
    //       flex: 3,
    //       child: FittedBox(
    //         fit: BoxFit.fill,
    //         child: Container(
    //           //to do: change dynamically
    //           height: 200,
    //           width: MediaQuery.of(context).size.width,
    //           child: player,
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //         flex: 6,
    //         child: Column(children: [
    //           Expanded(
    //             //suggestions
    //             flex: 1,
    //             child: Suggestions(),
    //           ),
    //           //to do: filter list dynamically
    //           Expanded(
    //               flex: 7,
    //               child: AllVideosWidget(
    //                 videosList: videosList,
    //               ))
    //         ]))
    //   ]),
    // );
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
