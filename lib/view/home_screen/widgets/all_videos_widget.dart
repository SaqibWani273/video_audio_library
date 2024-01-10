import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_audio_library/view/video_player_screen/video_player_screen.dart';

import '../../../constants/device_constraints.dart';
import '../../../constants/other_const.dart';

class AllVideosWidget extends StatefulWidget {
  //this will be passed from playlist page & not from home page
  final double? height;
  final List<VideoData> videosList;
  const AllVideosWidget({
    super.key,
    required this.videosList,
    this.height,
  });

  @override
  State<AllVideosWidget> createState() => _AllVideosWidgetState();
}

class _AllVideosWidgetState extends State<AllVideosWidget> {
  //to have scroll effect same as youtube on desktop
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  String? previousLogicalKeyboardKey;
  void hanldeKeyEvents(RawKeyEvent event) {
    //to do : handle long press of arrow down and arrow up keys appropriately as youtube

    var offset = _scrollController.offset;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        scrollToAnimate(offset + 50);

        break;
      case LogicalKeyboardKey.pageDown:
        scrollToAnimate(offset + 200);

        break;
      case LogicalKeyboardKey.arrowUp:
        scrollToAnimate(offset - 50);

        break;
      case LogicalKeyboardKey.space:
        scrollToAnimate(offset + 400);
        break;
      case LogicalKeyboardKey.pageUp:
        scrollToAnimate(offset - 200);

        break;
      case LogicalKeyboardKey.home:
        scrollToAnimate(0);
        break;

      case LogicalKeyboardKey.end:
        scrollToAnimate(_scrollController.position.maxScrollExtent);
        break;

      default:
    }
  }

  void scrollToAnimate(double position) {
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      final deviceWidth = constraints.maxWidth;
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth > 600 ||
                  defaultTargetPlatform == TargetPlatform.macOS ||
                  defaultTargetPlatform == TargetPlatform.linux ||
                  defaultTargetPlatform == TargetPlatform.windows
              ? deviceWidth * 0.1
              : 0,
          vertical: widget.height != null ? widget.height! * 0.03 : 0,
        ),
        height: widget.height ?? DeviceConstraints.mainBodyHeight,
        width: double.infinity,
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: _focusNode,
          onKey: hanldeKeyEvents,
          child: GridView.builder(
              controller: _scrollController,
              //  primary: true,
              itemCount: videosList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   mainAxisSpacing: 16,
                crossAxisSpacing: 24,
                crossAxisCount: deviceWidth > 1100
                    ? 3
                    : deviceWidth > 700
                        ? 2
                        : 1,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                return Container(
                  // // alignment: Alignment.center,
                  // margin: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(
                                    videoData: videosList[index]),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  kIsWeb ? BorderRadius.circular(16.0) : null,
                            ),
                            child: ClipRRect(
                              borderRadius: kIsWeb
                                  ? BorderRadius.circular(16.0)
                                  : BorderRadius.circular(0.0),
                              child: Image.network(
                                videosList[index].imageUrl,
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Stack(children: [
                                          Container(
                                            color: Colors.grey.shade200,
                                          ),
                                          const Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: LinearProgressIndicator(),
                                          ),
                                        ]);
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(videosList[index].title),
                        ),
                      ]),
                );
              }),
        ),
      );
    });
  }
}
