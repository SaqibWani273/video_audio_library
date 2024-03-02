import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/device_constraints.dart';
import '../../home_screen/widgets/videos_list_widget.dart';
import '../web_app_player_screen.dart';
import '/model/video_data_model.dart';
import '/repository/data_repo.dart';

class Suggestions extends StatelessWidget {
  final VideoDataModel currentVideoDataModel;
  const Suggestions({super.key, required this.currentVideoDataModel});

  List<VideoDataModel> getsimilarVideos(BuildContext context) => context
      .read<DataRepo>()
      .videoDataModelList
      .where((element) =>
          element.category == currentVideoDataModel.category &&
          element.subCategory == currentVideoDataModel.subCategory)
      .toList()
    ..sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(children: [
      Expanded(
        //suggestion tagname
        flex: deviceWidth < 1000 && kIsDesktop ? 4 : 1,
        child: SizedBox(
          child: Stack(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    " Similar Videos",
                  ),
                ),
              ),
              // ),
              Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: const Icon(Icons.chevron_right_outlined)),
                  ))
            ],
          ),
        ),
      ),
      // suggested videos
      Expanded(
        flex: 7,
        child: kIsDesktop
            ? DesktopSuggestions(suggestedVideos: getsimilarVideos(context))
            : MyBlockBuilder(
                videosList: getsimilarVideos(context),
              ),
      ),
    ]);
  }
}
