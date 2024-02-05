// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

class VideoDataModel {
  final String videoDescription;
  final String thumbnailUrl;
  final String videoUrl;
  final String category;
  final String? subCategory;
  VideoDataModel({
    required this.videoDescription,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.category,
    this.subCategory,
  });

  VideoDataModel copyWith({
    String? videoDescription,
    String? thumbnailUrl,
    String? videoUrl,
    String? category,
    String? subCategory,
  }) {
    return VideoDataModel(
      videoDescription: videoDescription ?? this.videoDescription,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'videoDescription': videoDescription,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'category': category,
      'subCategory': subCategory
    };
  }

  factory VideoDataModel.fromMap(Map<String, dynamic> map) {
    return VideoDataModel(
      videoDescription: map['videoDescription']["stringValue"] as String,
      thumbnailUrl: map['thumbnailUrl']["stringValue"] as String,
      videoUrl: map['videoUrl']["stringValue"] as String,
      category: map['category']["stringValue"] as String,
      subCategory: map['subCategory']["stringValue"] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoDataModel.fromJson(String source) =>
      VideoDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoDataModel(videoDescription: $videoDescription, thumbnailUrl: $thumbnailUrl, videoUrl: $videoUrl, category: $category)';
  }

  @override
  bool operator ==(covariant VideoDataModel other) {
    if (identical(this, other)) return true;

    return other.videoDescription == videoDescription &&
        other.thumbnailUrl == thumbnailUrl &&
        other.videoUrl == videoUrl &&
        other.category == category;
  }

  @override
  int get hashCode {
    return videoDescription.hashCode ^
        thumbnailUrl.hashCode ^
        videoUrl.hashCode ^
        category.hashCode;
  }
}
