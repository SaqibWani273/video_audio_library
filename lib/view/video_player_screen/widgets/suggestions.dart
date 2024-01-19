import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_library/view/common_widgets/my_scroll_widget.dart';
import 'package:video_audio_library/view/video_player_screen/video_player_screen.dart';

import '../../home_screen/widgets/videos_list_widget.dart';
import '/model/video_data_model.dart';
import '/repository/data_repo.dart';
import '/view/common_widgets/error_screen.dart';
import '/view_model/suggested_videos_bloc/suggested_videos_bloc.dart';

class Suggestions extends StatefulWidget {
  final VideoDataModel currentVideoDataModel;
  const Suggestions({super.key, required this.currentVideoDataModel});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  late DataRepo dataRepo;
  final ScrollController scrollController = ScrollController();
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context
        .read<SuggestedVideosBloc>()
        .add(LoadSuggestedVideosEvent(suggestionTagName: "all"));
    dataRepo = context.read<DataRepo>();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(children: [
      Expanded(
        //suggestion tagname
        flex: deviceWidth > 1000 ? 1 : 4,
        child: SizedBox(
          child: Stack(
            children: [
              SingleChildScrollView(
                primary: true,
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: dataRepo.suggestionTagNames
                          .asMap()
                          .entries
                          .map((entry) => InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex = entry.key;
                                  });
                                  context.read<SuggestedVideosBloc>().add(
                                      LoadSuggestedVideosEvent(
                                          suggestionTagName: entry.value));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: currentIndex == entry.key
                                        ? Colors.black
                                        : Colors.grey.shade200,
                                  ),
                                  child: Text(
                                    entry.value.toUpperCase(),
                                    style: TextStyle(
                                      color: currentIndex == entry.key
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
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
      BlocBuilder<SuggestedVideosBloc, SuggestedVideosState>(
          builder: (context, state) {
        if (state is LaodedState) {
          return Expanded(
            flex: 7,
            child: defaultTargetPlatform == TargetPlatform.macOS ||
                    defaultTargetPlatform == TargetPlatform.linux ||
                    defaultTargetPlatform == TargetPlatform.windows
                ? DesktopSuggestions(
                    suggestedVideos: dataRepo.suggestedVideosList)
                : VideosListWidget(
                    videosList: dataRepo.suggestedVideosList,
                  ),

            //  AllVideosWidget(
            //     videosList: dataRepo.suggestedVideosList,
            //   ),
          );
        }
        if (state is ErrorState) {
          return ErrorScreen(
            errorMessage: state.message,
            onPressed: () {
              context.read<SuggestedVideosBloc>().add(LoadSuggestedVideosEvent(
                  suggestionTagName: widget.currentVideoDataModel.category));
            },
          );
        }

        //loading data or any other state

        return const Expanded(
            flex: 7, child: Center(child: CircularProgressIndicator()));
      })
    ]);
  }
}
