import 'firestore_api_const.dart';

const demoVideoUrl1 = "https://www.youtube.com/watch?v=KJwYBJMSbPI";
const demoVideoUrl2 = "https://www.youtube.com/watch?v=i6tc3Pdj62M&t=629s";
const demoVideoUrl3 = "https://www.youtube.com/watch?v=NeYMYi7zkZU";
const demoVideoUrl4 = "https://youtu.be/NeYMYi7zkZU?si=mu77h6rh5CPf8C8s";

final List<VideoData> videosList = <VideoData>[
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl4),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl3),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl2),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
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
