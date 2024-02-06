import 'package:NUHA/constants/device_constraints.dart';
import 'package:NUHA/view/common_widgets/appbar.dart';
import 'package:NUHA/view/home_screen/widgets/categories_widget.dart';
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
  // final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    videosList =
        widget.videosList ?? context.read<DataRepo>().videoDataModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData mode = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, index) => [
            SliverAppBar(
              forceMaterialTransparency: false,
              backgroundColor: mode.brightness == Brightness.dark
                  ? DeviceConstraints.darkHeader
                  : DeviceConstraints.lightHeader,
              iconTheme: mode.iconTheme,
              automaticallyImplyLeading: false,
              title: const AppBarWidget(page: "VideoScreen"),
              floating: true,
              pinned: true,
              bottom: TabBar(
                // indicatorColor: Colors.transparent,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.video_settings),
                    text: "ALL",
                  ),
                  Tab(
                    icon: Icon(Icons.category),
                    text: "CATEGORIES",
                  ),
                  Tab(
                    icon: Icon(Icons.lightbulb_outlined),
                    text: "RECOMMENDED",
                  )
                ],
                labelStyle: TextStyle(
                    color: mode.brightness == Brightness.dark
                        ? DeviceConstraints.darkText
                        : DeviceConstraints.lightText,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
          body: const TabBarView(children: [
            MyBlockBuilder(),
            CategoriesWidget(),
            Center(
              child: Text("Recommended Videos will appear here soon !"),
            ),
          ]),
        ),
      ),
    );
    // MyBlockBuilder(
    //   videosList: videosList,
    // );
  }
}

class MyBlockBuilder extends StatefulWidget {
  final double? height;
  final List<VideoDataModel>? videosList;
  const MyBlockBuilder({
    super.key,
    this.videosList,
    this.height,
  });

  @override
  State<MyBlockBuilder> createState() => _MyBlockBuilderWidgetState();
}

class _MyBlockBuilderWidgetState extends State<MyBlockBuilder> {
  late final List<VideoDataModel> videosList;

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
    return BlocBuilder<DataBlocBloc, DataBlocState>(
      builder: (context, state) {
        if (state is LaodedState || state is LoadingState) {
          return GridView.builder(
              // controller: _scrollController,
              //  primary: true,
              itemCount: state is LaodedState
                  ? videosList.length
                  : 10, //videosList.length,
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
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                return state is LoadingState
                    ? const LoadingWidget()
                    : LoadedWidget(
                        videosList: videosList,
                        isDesktop: isDesktop,
                        index: index);
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
        //for any other state

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class LoadedWidget extends StatelessWidget {
  const LoadedWidget({
    super.key,
    required this.videosList,
    required this.isDesktop,
    required this.index,
  });

  final List<VideoDataModel> videosList;
  final bool isDesktop;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VideoPlayerScreen(videoDataModel: videosList[index]),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: isDesktop ? BorderRadius.circular(16.0) : null,
            ),
            child: ClipRRect(
              borderRadius: isDesktop
                  ? BorderRadius.circular(16.0)
                  : BorderRadius.circular(0.0),
              child:
                  NetworkImageLoader(imageUrl: videosList[index].thumbnailUrl),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Text(videosList[index].videoDescription),
      ),
    ]);
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: deviceWidth > 700 ? 500 : double.infinity,
            height: 100,
            color: const Color.fromARGB(255, 121, 118, 118),
          ),
          const SizedBox(height: 5),
          Container(
            width: deviceWidth > 700 ? 300 : deviceWidth * 0.5,
            height: 20,
            color: const Color.fromARGB(255, 121, 118, 118),
          ),
          const SizedBox(height: 5),
          Container(
            width: deviceWidth > 700 ? 100 : deviceWidth * 0.25,
            height: 15,
            color: const Color.fromARGB(255, 129, 126, 126),
          ),
          const SizedBox(height: 20),
        ]);
  }
}



    // MyScrollWidget(
    //   scrollController: _scrollController,
    //   height: widget.height,
    //   currentWidget:

    // );
    //........