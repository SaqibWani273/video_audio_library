// // Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// import '../../constants/other_const.dart';
// import 'all_videos_widget.dart';
// // import 'package:youtube_player_iframe_example/video_list_page.dart';

// // import 'widgets/meta_data_section.dart';
// // import 'widgets/play_pause_button_bar.dart';
// // import 'widgets/player_state_section.dart';
// // import 'widgets/source_input_section.dart';

// // const List<String> _videoIds = [
// //   'tcodrIK2P_I',
// //   'H5v3kku4y6Q',
// //   'nPt8bK2gbaU',
// //   'K18cpp_-gP8',
// //   'iLnmTe5Q2Qw',
// //   '_WoCV4c6XOE',
// //   'KmzdUe0RSJo',
// //   '6jZDSSZZxjQ',
// //   'p2lYr3vM_1w',
// //   '7QUtEmBT_-w',
// //   '34_PXCzGw1M'
// // ];

// // Future<void> main() async {
// //   runApp(YoutubeApp());
// // }

// ///
// // class YoutubeApp extends StatelessWidget {

// //   const YoutubeApp({super.key, required this.videoData});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Youtube Player IFrame Demo',
// //       theme: ThemeData.from(
// //         colorScheme: ColorScheme.fromSeed(
// //           seedColor: Colors.deepPurple,
// //           brightness: Brightness.dark,
// //         ),
// //         useMaterial3: true,
// //       ),
// //       debugShowCheckedModeBanner: false,
// //       home: YoutubeAppDemo(url: videoData.videoUrl),
// //     );
// //   }
// // }

// ///
// class YoutubePlayerIFrame extends StatefulWidget {
//   final VideoData videoData;
//   // final String url;

//   const YoutubePlayerIFrame({super.key, required this.videoData});
//   @override
//   _YoutubePlayerIFrameState createState() => _YoutubePlayerIFrameState();
// }

// class _YoutubePlayerIFrameState extends State<YoutubePlayerIFrame> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       params: const YoutubePlayerParams(
//         showControls: true,
//         mute: false,
//         showFullscreenButton: true,
//         loop: false,
//       ),
//     );

//     _controller.setFullScreenListener(
//       (isFullScreen) {
//         log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
//       },
//     );

//     // _controller.loadPlaylist(  https://youtube.com/shorts/ed-d0M0lLLY
//     //   list: _videoIds,
//     //   listType: ListType.playlist,
//     //   startSeconds: 136,
//     // );
//     // _controller.loadVideo(widget.url);
//     // _controller.loadVideoById(videoId: "NeYMYi7zkZU");
//     //,...........https://youtu.be/h52HfSagRls
//     //............https://youtu.be/rPgRHOz0JBk..............https://youtu.be/rPgRHOz0JBk
//     //...........https://youtu.be/rPgRHOz0JBk
//     //.....https://youtube.com/shorts/ed-d0M0lLLY
//     //......https://youtube.com/shorts/ed-d0M0lLLY?feature=share
//     // _controller.loadVideoByUrl(
//     //     mediaContentUrl: "https://www.youtube.com/shorts/ed-d0M0lLLY");
//     // _controller.loadVideoByUrl(mediaContentUrl: mediaContentUrl)

//     // _controller
//     //     .loadVideo("https://youtube.com/shorts/ed-d0M0lLLY?feature=share");
//     final videoid =
//         YoutubePlayerController.convertUrlToId(widget.videoData.videoUrl);
//     _controller.loadVideoById(videoId: videoid!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerScaffold(
//       controller: _controller,
//       builder: (context, player) {
//         return Scaffold(
//           body: LayoutBuilder(
//             builder: (context, constraints) {
//               //for desktop
//               if (kIsWeb && constraints.maxWidth > 750) {
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         children: [
//                           player,
//                           SizedBox(height: 10),

//                           //suggestions
//                           // flex: 1,

//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                                 children: Suggestions.values
//                                     .map((e) => Container(
//                                         margin: const EdgeInsets.all(8.0),
//                                         padding: const EdgeInsets.all(8.0),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(16.0),
//                                           color: Colors.grey.shade200,
//                                         ),
//                                         child: Text(e.name.toUpperCase())))
//                                     .toList()),
//                           ),

//                           Text(widget.videoData.title)
//                         ],
//                       ),
//                     ),
//                     const Expanded(
//                       flex: 2,
//                       child: SingleChildScrollView(
//                         // child: Controls(),
//                         child: SuggestedVideos(),
//                       ),
//                     ),
//                   ],
//                 );
//               }

//               return Column(
//                 children: [
//                   Expanded(flex: 3, child: player),
//                   // const VideoPositionIndicator(),
//                   Expanded(
//                       flex: 6,
//                       child: SingleChildScrollView(child: SuggestedVideos()))
//                   // const Controls(),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }
// }

// ///
// // class Controls extends StatelessWidget {
// //   ///
// //   const Controls();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // MetaDataSection(),
// //           Container(
// //             child: Text("meta data section"),
// //           ),
// //           _space,
// //           // SourceInputSection(),
// //           Container(
// //             child: Text(" source input section"),
// //           ),
// //           _space,
// //           // PlayPauseButtonBar(),
// //           Container(
// //             child: Text("play pause button bar"),
// //           ),
// //           _space,
// //           const VideoPositionSeeker(),
// //           _space,
// //           // PlayerStateSection(),

// //           Container(
// //             child: Text("player state section"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget get _space => const SizedBox(height: 10);
// // }

// ///
// class VideoPlaylistIconButton extends StatelessWidget {
//   ///
//   const VideoPlaylistIconButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = context.ytController;

//     return IconButton(
//       onPressed: () async {
//         // controller.pauseVideo();
//         // await Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => const VideoListPage(),
//         //   ),
//         // );
//         // controller.playVideo();
//       },
//       icon: const Icon(Icons.playlist_play_sharp),
//     );
//   }
// }

// ///
// class VideoPositionIndicator extends StatelessWidget {
//   ///
//   const VideoPositionIndicator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = context.ytController;

//     return StreamBuilder<YoutubeVideoState>(
//       stream: controller.videoStateStream,
//       initialData: const YoutubeVideoState(),
//       builder: (context, snapshot) {
//         final position = snapshot.data?.position.inMilliseconds ?? 0;
//         final duration = controller.metadata.duration.inMilliseconds;

//         return LinearProgressIndicator(
//           value: duration == 0 ? 0 : position / duration,
//           minHeight: 1,
//         );
//       },
//     );
//   }
// }

// // ///
// // class VideoPositionSeeker extends StatelessWidget {
// //   ///
// //   const VideoPositionSeeker({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     var value = 0.0;

// //     return Row(
// //       children: [
// //         const Text(
// //           'Seek',
// //           style: TextStyle(fontWeight: FontWeight.w300),
// //         ),
// //         const SizedBox(width: 14),
// //         Expanded(
// //           child: StreamBuilder<YoutubeVideoState>(
// //             stream: context.ytController.videoStateStream,
// //             initialData: const YoutubeVideoState(),
// //             builder: (context, snapshot) {
// //               final position = snapshot.data?.position.inSeconds ?? 0;
// //               final duration = context.ytController.metadata.duration.inSeconds;

// //               value = position == 0 || duration == 0 ? 0 : position / duration;

// //               return StatefulBuilder(
// //                 builder: (context, setState) {
// //                   return Slider(
// //                     value: value,
// //                     onChanged: (positionFraction) {
// //                       value = positionFraction;
// //                       setState(() {});

// //                       context.ytController.seekTo(
// //                         seconds: (value * duration).toDouble(),
// //                         allowSeekAhead: true,
// //                       );
// //                     },
// //                     min: 0,
// //                     max: 1,
// //                   );
// //                 },
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// class SuggestedVideos extends StatelessWidget {
//   const SuggestedVideos({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       //  height: MediaQuery.of(context).size.height,
//       child: Column(children: [
//         if (!(kIsWeb && MediaQuery.of(context).size.width > 750))
//           Expanded(
//             //suggestions
//             flex: 1,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                   children: Suggestions.values
//                       .map((e) => Container(
//                           margin: const EdgeInsets.all(8.0),
//                           padding: const EdgeInsets.all(8.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16.0),
//                             color: Colors.grey.shade200,
//                           ),
//                           child: Text(e.name.toUpperCase())))
//                       .toList()),
//             ),
//           ),
//         //to do: filter list dynamically
//         Expanded(
//             // flex: 7,
//             child: AllVideosWidget(
//           videosList: videosList,
//         ))
//       ]),
//     );
//   }
// }

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
