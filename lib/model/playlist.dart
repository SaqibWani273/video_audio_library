// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:NUHA/model/video_data_model.dart';

class PlayList {
  final String nameInEnglish;
  final String nameInArabic;
  final String? imageUrl;
  final List<VideoDataModel>? videos;
  PlayList({
    required this.nameInEnglish,
    required this.nameInArabic,
    this.imageUrl,
    this.videos,
  });

  PlayList copyWith({
    String? nameInEnglish,
    String? nameInArabic,
    String? imageUrl,
    List<VideoDataModel>? videos,
  }) {
    return PlayList(
      nameInEnglish: nameInEnglish ?? this.nameInEnglish,
      nameInArabic: nameInArabic ?? this.nameInArabic,
      imageUrl: imageUrl ?? this.imageUrl,
      videos: videos ?? this.videos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameInEnglish': nameInEnglish,
      'nameInArabic': nameInArabic,
      'imageUrl': imageUrl,
      // 'videos': videos.map((x) => x.toMap()).toList(),
      'videos': videos?.map((x) => x.toMap()).toList(),
    };
  }

  factory PlayList.fromMap(Map<String, dynamic> map) {
    return PlayList(
      nameInEnglish: map['nameInEnglish']["stringValue"] as String,
      nameInArabic: map['nameInArabic']["stringValue"] as String,
      imageUrl: map['imageUrl'] != null
          ? map['imageUrl']["stringValue"] as String
          : null,
      // videos: List<VideoDataModel>.from(
      //   (map['videos'] as List<int>).map<VideoDataModel>(
      //     (x) => VideoDataModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayList.fromJson(String source) =>
      PlayList.fromMap(json.decode(source) as Map<String, dynamic>);
}
