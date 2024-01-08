const demoUrl =
    "https://firebasestorage.googleapis.com/v0/b/video-audio-library.appspot.com/o/videos%2Fthumbnails%2F14832137_5517053.jpg?alt=media&token=1e3d63c6-2fc4-4b02-bb08-b8c74d13310a";

const demoVideoUrl =
    "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true"; // "https://www.youtube.com/watch?v=WNCl-69POro";
const demoVideoUrl1 = "https://www.youtube.com/watch?v=KJwYBJMSbPI";
const demoVideoUrl2 = "https://www.youtube.com/watch?v=i6tc3Pdj62M&t=629s";
const demoVideoUrl3 = "https://www.youtube.com/watch?v=NeYMYi7zkZU";
const demoVideoUrl4 = "https://youtu.be/NeYMYi7zkZU?si=mu77h6rh5CPf8C8s";
const demoVideoUrl5 =
    "https://firebasestorage.googleapis.com/v0/b/video-audio-library.appspot.com/o/videos%2Fvideos%2FPAKISTAN%204K%20-%20Scenic%20Relaxation%20Film%20by%20Peaceful%20Relaxing%20Music%20and%20Nature%20Video%20Ultra%20HD.mp4?alt=media&token=f51997cf-9b06-4f4b-b6e2-7af0588a3e34";

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
      videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(
      title: "Demo Text about the title of the video | demo date | demo time",
      imageUrl: demoUrl,
      videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl1),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
  VideoData(title: "Video 1", imageUrl: demoUrl, videoUrl: demoVideoUrl),
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
