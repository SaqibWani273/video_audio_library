import 'package:flutter/material.dart';
import '../../constants/device_constraints.dart';
import '../../constants/other_const.dart';

class AllVideosWidget extends StatelessWidget {
  const AllVideosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.15),
      height: DeviceConstraints.mainBodyHeight,
      width: double.infinity,
      child: GridView.builder(
          itemCount: videosList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   mainAxisSpacing: 16,
            crossAxisSpacing: 24,
            crossAxisCount: deviceWidth > 1100
                ? 3
                : deviceWidth > 700
                    ? 2
                    : 1,
            childAspectRatio: deviceWidth > 700 ? 1.0 : 1.1,
          ),
          itemBuilder: (context, index) {
            return Container(
              // // alignment: Alignment.center,
              // margin: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      //  height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(videosList[index].title),
                    // SizedBox(
                    //   height: 20,
                    // ),
                  ]),
            );
          }),
    );
  }
}

final List<VideoData> videosList = <VideoData>[
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: ''),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: ''),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: ''),
];

class VideoData {
  final String title;
  final String imageUrl;
  final String videoUrl;
  VideoData({
    required this.title,
    required this.imageUrl,
    required this.videoUrl,
  });
}
