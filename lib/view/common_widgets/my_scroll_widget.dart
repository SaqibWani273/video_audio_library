import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/device_constraints.dart';
import '../../model/video_data_model.dart';

class MyScrollWidget extends StatefulWidget {
  //this will be passed from playlist page & not from home page
  final double? height;
  // final List<VideoDataModel>? videosList;
  final Widget currentWidget;
  final ScrollController scrollController;
  const MyScrollWidget({
    super.key,
    // this.videosList,
    this.height,
    required this.currentWidget,
    required this.scrollController,
  });

  @override
  State<MyScrollWidget> createState() => _MyScrollWidgetState();
}

class _MyScrollWidgetState extends State<MyScrollWidget> {
  late final List<VideoDataModel> videosList;

  //to have scroll effect same as youtube on desktop
  // final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  String? previousLogicalKeyboardKey;

  void hanldeKeyEvents(KeyEvent event) {
    //to do : handle long press of arrow down and arrow up keys appropriately as youtube

    var offset = widget.scrollController.offset;
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
        scrollToAnimate(widget.scrollController.position.maxScrollExtent);
        break;

      default:
    }
  }

  // @override
  // void initState() {
  //   videosList =
  //       widget.videosList ?? context.read<DataRepo>().videoDataModelList;
  //   super.initState();
  // }

  void scrollToAnimate(double position) {
    widget.scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.scrollController.dispose();
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
              ? deviceWidth * 0.01
              : 0,
          vertical: widget.height != null ? widget.height! * 0.03 : 0,
        ),
        height: widget.height ?? DeviceConstraints.mainBodyHeight,
        width: double.infinity,
        child: KeyboardListener(
          autofocus: true,
          focusNode: _focusNode,
          onKeyEvent: hanldeKeyEvents,
          child: widget.currentWidget,
        ),
      );
    });
  }

  //........
}
