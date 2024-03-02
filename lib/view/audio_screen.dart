import '../constants/device_constraints.dart';
import '/model/video_data_model.dart';
import '/repository/data_repo.dart';
import '/view/common_widgets/appbar.dart';
import '/view/common_widgets/network_image_loader.dart';
import 'video_player_screen/web_app_player_screen.dart';
import 'video_player_screen/mobile_app_player_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioScreen extends StatefulWidget {
  final double? height;
  final List<VideoDataModel>? videosList;
  const AudioScreen({
    super.key,
    this.videosList,
    this.height,
  });

  @override
  State<AudioScreen> createState() => _AudioListWidgetState();
}

class _AudioListWidgetState extends State<AudioScreen> {
  late final List<VideoDataModel> videosList;

  @override
  void initState() {
    videosList =
        widget.videosList ?? context.read<DataRepo>().videoDataModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, index) => [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            title: AppBarWidget(page: "AudioScreen"),
          )
        ],
        body: ListView.separated(
            itemCount: 50,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Item $index'),
                  subtitle: Text('Subtitle for Item $index'),
                  leading: const Icon(Icons.star),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Action when the item is tapped
                    print('Tapped on Item $index');
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            }),
      ),
    );
    // final deviceWidth = MediaQuery.of(context).size.width;
    // return BlocBuilder<DataBlocBloc, DataBlocState>(
    //   builder: (context, state) {
    //     if (state is LaodedState || state is LoadingState) {
    //       return GridView.builder(
    //           //  primary: true,
    //           itemCount: state is LaodedState
    //               ? videosList.length
    //               : 10, //videosList.length,
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             mainAxisSpacing: 24,
    //             crossAxisSpacing: 24,
    //             crossAxisCount: deviceWidth > 1100
    //                 ? 4
    //                 : deviceWidth > 800
    //                     ? 3
    //                     : deviceWidth > 500
    //                         ? 2
    //                         : 1,
    //             childAspectRatio: 1.4,
    //           ),
    //           itemBuilder: (context, index) {
    //             return state is LoadingState
    //                 ? const LoadingWidget()
    //                 : LoadedWidget(
    //                     videosList: videosList,
    //                     kIsDesktop: kIsDesktop,
    //                     index: index);
    //           });
    //     }
    //     if (state is ErrorState) {
    //       return ErrorScreen(
    //           errorMessage: state.message,
    //           onPressed: () {
    //             context
    //                 .read<DataBlocBloc>()
    //                 .add(LoadDataFromFirestoreApiEvent());
    //           });
    //     }
    //     //for any other state

    //     return const Scaffold(
    //       body: Center(child: CircularProgressIndicator()),
    //     );
    //   },
    // );
  }
}

class LoadedWidget extends StatelessWidget {
  const LoadedWidget({
    super.key,
    required this.videosList,
    required this.index,
  });

  final List<VideoDataModel> videosList;

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
                builder: (context) => kIsWeb
                    ? WebAppPlayerScreen(videoDataModel: videosList[index])
                    : MobileAppPlayerScreen(videoData: videosList[index]),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: kIsDesktop ? BorderRadius.circular(16.0) : null,
            ),
            child: ClipRRect(
              borderRadius: kIsDesktop
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

 
    // ListView.separated(
    //     itemCount: 50,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Card(
    //         elevation: 3,
    //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //         child: ListTile(
    //           title: Text('Item $index'),
    //           subtitle: Text('Subtitle for Item $index'),
    //           leading: const Icon(Icons.star),
    //           trailing: const Icon(Icons.arrow_forward),
    //           onTap: () {
    //             // Action when the item is tapped
    //             print('Tapped on Item $index');
    //           },
    //         ),
    //       );
    //     },
    //     separatorBuilder: (context, index) {
    //       return const Divider();
    //     });


    // return Container(
    //     // padding: const EdgeInsets.only(left: 0.0),
    //     child: const Text(
    //   "Audio Home Page\n\n\n\n\nghggftfffcf\n\n\n\n\n\n\n hgvgfvghvchgf\n\n\n\n\n\nhggffdfdtgf\n\n\n\n\n\n\n\n\njkhjhggfhg\n\n\n\n\njhgjhgfhg\n\n\njhghgfhgfg",
    //   style: TextStyle(fontSize: 20),
    // ));