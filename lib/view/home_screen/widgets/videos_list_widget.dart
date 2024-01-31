import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:NUHA/view/common_widgets/error_screen.dart';
import 'package:NUHA/view/common_widgets/my_scroll_widget.dart';

import '../../../model/video_data_model.dart';
import '../../../repository/data_repo.dart';
import '../../../view/video_player_screen/video_player_screen.dart';
import '../../../view_model/data_bloc/data_bloc_bloc.dart';
import '../../common_widgets/network_image_loader.dart';

class VideosListWidget extends StatefulWidget {
  //this will be passed from playlist page & not from home page
  final double? height;
  final List<VideoDataModel>? videosList;
  const VideosListWidget({
    super.key,
    this.videosList,
    this.height,
  });

  @override
  State<VideosListWidget> createState() => _VideosListWidgetState();
}

class _VideosListWidgetState extends State<VideosListWidget> {
  late final List<VideoDataModel> videosList;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    videosList =
        widget.videosList ?? context.read<DataRepo>().videoDataModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows;

    return MyScrollWidget(
      scrollController: _scrollController,
      height: widget.height,
      currentWidget: BlocBuilder<DataBlocBloc, DataBlocState>(
        builder: (context, state) {
          if (state is LaodedState) {
            return GridView.builder(
                controller: _scrollController,
                //  primary: true,
                itemCount: videosList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  crossAxisCount: deviceWidth > 1100
                      ? 4
                      : deviceWidth > 800
                          ? 3
                          : deviceWidth > 500
                              ? 2
                              : 1,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    // // alignment: Alignment.center,
                    // margin: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(
                                        videoDataModel: videosList[index]),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: isDesktop
                                      ? BorderRadius.circular(16.0)
                                      : null,
                                ),
                                child: ClipRRect(
                                  borderRadius: isDesktop
                                      ? BorderRadius.circular(16.0)
                                      : BorderRadius.circular(0.0),
                                  child: NetworkImageLoader(
                                      imageUrl: videosList[index].thumbnailUrl),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 1.0),
                            child: Text(videosList[index].videoDescription),
                          ),
                        ]),
                  );
                });
          }
          if (state is ErrorState) {
            return ErrorScreen(
                errorMessage: state.message,
                onPressed: () {
                  context
                      .read<DataBlocBloc>()
                      .add(LoadDataFromFirestoreApiEvent());
                });
          }

          //loading data or any other state
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
    //........
  }
}
